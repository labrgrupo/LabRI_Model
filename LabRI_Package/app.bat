@echo off

REM Obtém o caminho do R a partir do registro
for /f "tokens=2*" %%A in ('reg query HKLM\Software\R-core\R /v InstallPath 2^>nul') do set R_PATH=%%B

REM Verifica se o caminho foi encontrado
if "%R_PATH%"=="" (
    echo Aviso: Caminho do R não encontrado no Registro. Tentando usar o Rscript do PATH do sistema.
    set R_SCRIPT=Rscript
) else (
    REM Define o caminho para Rscript.exe
    set R_SCRIPT="%R_PATH%\bin\x64\Rscript.exe"
)

REM Define o caminho do script R para o diretório atual onde o .bat está
set SCRIPT_PATH="%~dp02_supplementary_files/launch_app.R"

REM Executa o script
%R_SCRIPT% %SCRIPT_PATH%

REM Remove o pause para evitar a janela indesejada
exit /b


