@ECHO off
REM  Install script for DAQFactory serial drivers
REM  Must be run as administrator due to permissions on destination folder
REM
REM  Copies protocol files (*.ddp) from subfolders into C:\DAQFactory
REM  Be manual and explicit instead of automatic and efficient


REM Give user option to abort
ECHO Preparing to install DAQFactory serial driver files...
CHOICE /M "Any currently installed drivers will overwritten. Continue?"
IF %ERRORLEVEL% EQU 2 EXIT

REM Switch back to file directory while running as administrator
PUSHD %~dp0
ECHO.

REM Copy individual protocol files into destination (overwrite if exists)
XCOPY "LGR_N2O_CO\pLGR_N2O_CO.ddp" "C:\DAQFactory\" /Y
XCOPY "LGR_UGGA\pLGR_UGGA.ddp" "C:\DAQFactory\" /Y

REM Brief delay for user to review
ECHO.
ECHO.
ECHO Finished installing.
TIMEOUT 15
