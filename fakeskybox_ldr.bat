@echo off

echo FakeSkyBox creator v.1.0
echo by bagdenisov 2021
echo. 

for %%a in (".") do set CURRENT_DIR_NAME=%%~na

if not %CURRENT_DIR_NAME%==materialsrc (
echo This BAT work only in "materialsrc" directory!
pause
goto exit
)

:wrong
echo Write skybox name (example: skyboxic\hub2_sunset_02)
set /p name= :

if not exist %name%bk.vtf (
echo.
echo Fast check: File %name%bk.vtf is missing!
echo.
goto wrong
)

call :do bk
call :do dn
call :do ft
call :do lf
call :do rt
call :do up

if exist "%name%.txt" (
del "%name%.txt"
)

echo nonice 1 >>%name%.txt
echo nocompress 1 >>%name%.txt
echo --------------------------------------------------------------------
echo convert vtex
echo --------------------------------------------------------------------
echo.
"../../bin/vtex" -oldcubepath %name%.txt

if not exist "../materials/%name%.vtf" (
echo !!! final vmt file is not detected!
) else (

echo --------------------------------------------------------------------
echo creating %name%.vmt
echo --------------------------------------------------------------------
echo.
if exist "../materials/%name%.vmt" (
del "../materials/%name%.vmt"
)

echo "WindowImposter"{"$envmap" "%name%" "$nofog" "1"} >> ../materials/%name%.vmt
)
echo Complete!
pause
goto exit

:do
echo --------------------------------------------------------------------
echo convert %name%%1.vtf to %name%%1.tga 
echo --------------------------------------------------------------------
echo.
"../../bin/vtf2tga" -i %name%%1.vtf -o %name%%1.tga -quiet
echo.
exit /b

:exit