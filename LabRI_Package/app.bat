@echo off
:: Defina o caminho completo para o Rscript.exe, incluindo aspas
set "RscriptPath=C:\Program Files\R\R-4.4.2\bin\Rscript.exe"  :: Ajuste para o caminho correto do R no seu computador

:: Defina o caminho para o script launch_app.R usando %~dp0 para pegar o diretório atual
set "scriptPath=%~dp0launch_app.R"

:: Executa o Rscript para rodar o launch_app.R, assegurando-se de que os caminhos estão entre aspas
"%RscriptPath%" "%scriptPath%"

:: Pausa para que o usuário possa ver as mensagens, se necessário
pause


