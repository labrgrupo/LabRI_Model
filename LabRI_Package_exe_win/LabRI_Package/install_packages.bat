REM Command Prompt Interface Configuration
title LabRI-R Package Installer

REM Initial message
echo ===========================================================================
echo Welcome to the LabRI Tool R Package Installer!
echo. 
echo This installer will ensure that all required R packages are properly 
echo installed for the Shiny-based LabRI tool. These packages are essential 
echo for performing the estimation and verification of reference intervals 
echo in clinical laboratories.
echo. 
echo If the required packages are already installed, no further action will 
echo be taken, and a confirmation message will be displayed.
echo ===========================================================================
echo.


REM Get the path to the installed R
for /f "tokens=2*" %%A in ('reg query HKLM\Software\R-core\R /v InstallPath 2^>nul') do set R_PATH=%%B

REM Check if R is installed
if "%R_PATH%"=="" (
    echo ===========================================================================
    echo WARNING: R is not installed or not found in the Windows Registry.
    echo Please install R from the official CRAN website:
    echo https://cran.r-project.org/
    echo ===========================================================================
    pause
    exit /b
) else (
    set R_SCRIPT="%R_PATH%\bin\x64\Rscript.exe"
    echo R installation detected at: %R_PATH%
)

REM Run the R script to install packages
echo ===========================================================================
echo Checking and installing required R packages...
echo Please wait while the installation process completes.
echo ===========================================================================
echo.

%R_SCRIPT% install_packages.R

REM Check the exit code to determine if the script ran successfully
if %ERRORLEVEL% EQU 0 (
    echo ===========================================================================
    echo SUCCESS: All required R packages have been successfully installed!
    echo You are now ready to use the LabRI tool.
    echo ===========================================================================
) else (
    echo ===========================================================================
    echo ERROR: An issue occurred during the R package installation process.
    echo Please check your R environment and internet connection, then try again.
    echo ===========================================================================
)

REM Keep the window open
pause
