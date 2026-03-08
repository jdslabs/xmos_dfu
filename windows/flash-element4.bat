@ECHO OFF
SETLOCAL EnableDelayedExpansion

REM XMOS Firmware Flasher for Windows
REM Specifically for Element IV firmware updates

SET "SCRIPT_DIR=%~dp0"
SET "FIRMWARE_API=https://dsp.api.jdslabs.com/api/firmware/"
SET "BETA_API=https://dsp.api.jdslabs.com/api/beta-firmware/"
SET "CATALOG=%TEMP%\el4_fw_catalog.txt"

REM Fetch stable + beta firmware catalogs and merge, sorted newest first
ECHO.
ECHO Fetching firmware catalog from JDS Labs API...
powershell -NoProfile -Command "$stable = Invoke-RestMethod -Uri '%FIRMWARE_API%'; $beta = Invoke-RestMethod -Uri '%BETA_API%'; $all = @(); foreach ($f in $stable) { $all += [PSCustomObject]@{version=$f.version; url=$f.firmware_file; beta=$false; id=$f.id} }; foreach ($f in $beta) { $all += [PSCustomObject]@{version=$f.version; url=$f.firmware_file; beta=$true; id=$f.id} }; $all = $all | Sort-Object id -Descending; $lines = @(); foreach ($f in $all) { $tag = if ($f.beta) {'beta'} else {'stable'}; $lines += $f.version + '|' + $f.url + '|' + $tag }; $lines | Out-File -Encoding ascii '%CATALOG%'"

REM Parse catalog into indexed variables
SET "FW_COUNT=0"
SET "LATEST_VERSION=unknown"
SET "LATEST_URL="
SET "V151_URL="
FOR /F "usebackq tokens=1,2,3 delims=|" %%A IN ("%CATALOG%") DO (
    SET /A FW_COUNT+=1
    SET "FW_VER_!FW_COUNT!=%%A"
    SET "FW_URL_!FW_COUNT!=%%B"
    SET "FW_BETA_!FW_COUNT!=%%C"
    IF "%%C"=="stable" (
        IF "!LATEST_VERSION!"=="unknown" (
            SET "LATEST_VERSION=%%A"
            SET "LATEST_URL=%%B"
        )
    )
    IF "%%A"=="1.5.1" IF "%%C"=="stable" SET "V151_URL=%%B"
)
DEL "%CATALOG%" >NUL 2>&1

IF %FW_COUNT%==0 (
    ECHO.
    ECHO ERROR: Could not fetch firmware catalog. Check your internet connection.
    ECHO.
    PAUSE
    GOTO EOF
)

:MENU
CLS
ECHO =============================================
ECHO    XMOS FIRMWARE FLASHER - Element IV
ECHO =============================================
ECHO.
ECHO 1 - Flash Element IV - Latest v%LATEST_VERSION%
ECHO 2 - Flash Element IV v1.5.1 (required for devices below v1.4.0)
ECHO 3 - View Other Firmwares to Flash [%FW_COUNT% available]
ECHO 4 - View Current Firmware
ECHO 5 - Revert to Factory Image
ECHO 6 - EXIT
ECHO.
SET /P M=Type a number, then press ENTER: 
IF "%M%"=="1" GOTO FLASH_LATEST
IF "%M%"=="2" GOTO FLASH_V151
IF "%M%"=="3" GOTO OTHER_VERSIONS
IF "%M%"=="4" GOTO LIST_DEVICES
IF "%M%"=="5" GOTO REVERT_FACTORY
IF "%M%"=="6" GOTO EOF
ECHO Invalid selection, please try again.
TIMEOUT /T 2 >NUL
GOTO MENU

:FLASH_LATEST
CLS
ECHO.
IF "%LATEST_URL%"=="" (
    ECHO ERROR: Could not fetch firmware URL from API.
    ECHO.
    PAUSE
    GOTO MENU
)
SET /P AREYOUSURE=Flash Element IV firmware v%LATEST_VERSION% (y/n)? 
IF /I NOT "%AREYOUSURE%"=="y" GOTO MENU
SET "SEL_VER=%LATEST_VERSION%"
SET "SEL_URL=%LATEST_URL%"
GOTO DO_FLASH

:FLASH_V151
CLS
ECHO.
IF "%V151_URL%"=="" (
    ECHO ERROR: Could not fetch v1.5.1 firmware URL from API.
    ECHO.
    PAUSE
    GOTO MENU
)
ECHO NOTE: Use this option ONLY if your device is running firmware below v1.4.0.
ECHO       After flashing v1.5.1, you can then upgrade to the latest version.
ECHO.
SET /P AREYOUSURE=Flash Element IV firmware v1.5.1 (y/n)? 
IF /I NOT "%AREYOUSURE%"=="y" GOTO MENU
SET "SEL_VER=1.5.1"
SET "SEL_URL=%V151_URL%"
GOTO DO_FLASH

:OTHER_VERSIONS
CLS
ECHO =============================================
ECHO    SELECT ANOTHER FIRMWARE VERSION
ECHO =============================================
ECHO.
FOR /L %%I IN (1,1,%FW_COUNT%) DO (
    SET "LABEL=v!FW_VER_%%I!"
    IF "!FW_BETA_%%I!"=="beta" SET "LABEL=!LABEL! [BETA]"
    IF "!FW_VER_%%I!"=="%LATEST_VERSION%" SET "LABEL=!LABEL! (latest stable^)"
    SET "PAD=  %%I"
    IF %%I GEQ 10 SET "PAD= %%I"
    ECHO !PAD! - !LABEL!
)
ECHO  B - Back to Main Menu
ECHO.
SET /P OV=Type a number, then press ENTER: 
IF /I "%OV%"=="B" GOTO MENU
SET /A "OV_NUM=%OV%" 2>NUL
IF %OV_NUM% LSS 1 (
    ECHO Invalid selection, please try again.
    TIMEOUT /T 2 >NUL
    GOTO OTHER_VERSIONS
)
IF %OV_NUM% GTR %FW_COUNT% (
    ECHO Invalid selection, please try again.
    TIMEOUT /T 2 >NUL
    GOTO OTHER_VERSIONS
)
SET "SEL_VER=!FW_VER_%OV_NUM%!"
SET "SEL_URL=!FW_URL_%OV_NUM%!"
ECHO.
SET /P AREYOUSURE=Flash Element IV firmware v%SEL_VER% (y/n)? 
IF /I NOT "%AREYOUSURE%"=="y" GOTO OTHER_VERSIONS
GOTO DO_FLASH

:DO_FLASH
ECHO.
ECHO *** Downloading Element IV firmware v%SEL_VER% ***
SET "FW_FILEPATH=%TEMP%\el4-v%SEL_VER%-upgrade.bin"
curl -L -o "%FW_FILEPATH%" "%SEL_URL%"
IF ERRORLEVEL 1 (
    ECHO.
    ECHO ERROR: Failed to download firmware.
    ECHO.
    PAUSE
    GOTO MENU
)
ECHO.
ECHO *** Flashing Element IV firmware v%SEL_VER% ***
ECHO.
"%SCRIPT_DIR%xmosdfu.exe" --download "%FW_FILEPATH%"
DEL "%FW_FILEPATH%" >NUL 2>&1
ECHO.
PAUSE
GOTO MENU

:LIST_DEVICES
CLS
ECHO.
ECHO *** Listing Connected JDS Labs Devices ***
ECHO.
"%SCRIPT_DIR%xmosdfu.exe" --listdevices 2>&1 | findstr /I "JDS"
ECHO.
PAUSE
GOTO MENU

:REVERT_FACTORY
CLS
ECHO.
SET /P AREYOUSURE=Clear upgrades and revert to FACTORY image (y/n)? 
IF /I NOT "%AREYOUSURE%"=="y" GOTO MENU
ECHO.
ECHO *** Reverting to FACTORY Image... ***
ECHO.
"%SCRIPT_DIR%xmosdfu.exe" --revertfactory
ECHO.
PAUSE
SET /P ANOTHER=Revert another device (y/n)? 
IF /I "%ANOTHER%"=="y" GOTO REVERT_FACTORY
GOTO MENU

:EOF
ENDLOCAL
EXIT /B 0
