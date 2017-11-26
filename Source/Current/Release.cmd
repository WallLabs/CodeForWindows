@echo off
setlocal
echo Release
echo =======
echo.
echo Performs a full build of all configurations then copies the output
echo to the central build directory for check-in and use by other
echo components or release.

echo.
echo Initializing Visual Studio environment...
call "%~dp0Scripts\Variables.cmd"
if %errorlevel% neq 0 goto Error

echo.
echo Clean any previous builds...
if exist "%~dp0Debug" rmdir "%~dp0Debug" /s /q
if %errorlevel% neq 0 goto Error
if exist "%~dp0Release" rmdir "%~dp0Release" /s /q
if %errorlevel% neq 0 goto Error

echo.
echo Update source (and delete extra files)...
rem * TODO: Replace TFS commands with GIT equivalent
rem tf undo "%~dp0..\..\Build\v1" /recursive /noprompt
rem if %errorlevel% gtr 1 goto Error
rem tf scorch "%~dp0..\..\Build\v1" /recursive /diff /noprompt
rem if %errorlevel% gtr 1 goto Error
rem tf get "%~dp0" /recursive /noprompt
rem if %errorlevel% gtr 1 goto Error
rem tf scorch "%~dp0" /recursive /diff /noprompt
rem if %errorlevel% gtr 1 goto Error

echo.
echo Versioning...
call "%~dp0Version.cmd"
if %errorlevel% neq 0 goto Error

echo.
echo Building...
rem * No debug build at this time (same as release).
rem call "%~dp0Build.cmd" Debug
rem if %errorlevel% neq 0 goto Error
call "%~dp0Build.cmd" Release
if %errorlevel% neq 0 goto Error

if not exist "%~dp0..\..\Build\v1" goto TargetClean
echo.
echo Delete old build directory so that old or renamed items are cleaned...
rem * TODO: Replace TFS commands with GIT equivalent
rem tf delete "%~dp0..\..\Build\v1" /recursive
rem if %errorlevel% gtr 1 goto Error
rmdir "%~dp0..\..\Build\v1" /s /q
if %errorlevel% neq 0 goto Error
rem tf checkin "%~dp0..\..\Build\v1" /recursive /noprompt
rem if %errorlevel% gtr 1 goto Error
:TargetClean

echo.
echo Copying output to build directory...
rem * No debug build at this time (same as release).
rem robocopy "%~dp0Debug" "%~dp0..\..\Build\v1\Debug" /s
rem if %errorlevel% gtr 7 goto Error
robocopy "%~dp0Release" "%~dp0..\..\Build\v1\Release" /s
if %errorlevel% gtr 7 goto Error

echo.
echo Adding any new files in build directory...
rem * TODO: Replace TFS commands with GIT equivalent
rem tf add "%~dp0..\..\Build\" /recursive /noprompt /noignore
rem if %errorlevel% gtr 1 goto Error

echo.
echo Build all successful.
endlocal
exit /b 0

:Error
echo Error %errorlevel%!
endlocal
exit /b 1