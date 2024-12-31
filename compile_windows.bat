@echo off

:: Nome do arquivo (sem extensão)
set NOME=5-converte_string

:: Verificar se o arquivo .asm existe
if not exist %NOME%.asm (
    echo Erro: Arquivo %NOME%.asm nao encontrado
    pause
    exit /b 1
)

:: Compilar o arquivo .asm para objeto
nasm -f win64 %NOME%.asm -o %NOME%.obj
if errorlevel 1 (
    echo Erro na compilacao do NASM
    pause
    exit /b 1
)

:: Usar o caminho exato do link.exe da sua máquina
"C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30133\bin\Hostx64\x64\link.exe" /subsystem:console /entry:main %NOME%.obj /out:%NOME%.exe
if errorlevel 1 (
    echo Erro no linking
    pause
    exit /b 1
)

:: Limpar arquivos temporários
del %NOME%.obj

echo Compilacao concluida com sucesso!
echo Arquivo executavel gerado: %NOME%.exe
pause