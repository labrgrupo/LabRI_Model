@echo off
set RscriptPath="C:\PROGRA~1\R\R-4.4.2\bin\x64\Rscript.exe"

:: Define o caminho do diretório onde o .bat está localizado
set scriptPath="%~dp0launch_app.R"

:: Executa o Rscript usando o caminho dinâmico
%RscriptPath% %scriptPath%
pause
