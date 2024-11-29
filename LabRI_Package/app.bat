@echo off

REM Command Prompt Interface Configuration
title LabRI Tool


REM Display an initial message
echo ===========================================================================
echo       Welcome to the Laboratory Reference Interval (LabRI) Tool
echo         Tool for Estimating and Verifying Reference Intervals
echo ===========================================================================
echo.

REM STEP 1: Get the R path from the registry
for /f "tokens=2*" %%A in ('reg query HKLM\Software\R-core\R /v InstallPath 2^>nul') do set R_PATH=%%B

REM STEP 2: Check if R is installed
if "%R_PATH%"=="" (
    echo =======================================================================
    echo WARNING: R is not installed or not found in the Windows Registry.
    echo Please install R from the official CRAN website:
    echo https://cran.r-project.org/
    echo =======================================================================
    pause
    exit /b
) else (
    set R_SCRIPT="%R_PATH%\bin\x64\Rscript.exe"
    echo R found at: %R_PATH%
)

REM STEP 3: Define the path to the R script based on the current directory
set SCRIPT_PATH="%~dp0launch_app.R"

REM Display progress messages
echo ===========================================================================
echo Starting the LabRI Shiny Tool...
echo Running the script: %SCRIPT_PATH%
echo ===========================================================================
echo.

REM Execute the script if R is found
%R_SCRIPT% %SCRIPT_PATH%

REM Check if the script executed successfully
if %ERRORLEVEL% EQU 0 (
    echo =======================================================================
    echo LabRI Tool successfully started!
    echo =======================================================================
) else (
    echo =======================================================================
    echo ERROR: An error occurred while starting the system.
    echo Please check if R is correctly installed.
    echo =======================================================================
)

REM Keep the window open for the user to view the messages
pause
