@ECHO OFF

set HOME=Y:\Public\rookiebooks
set comp=Y:\Public\rookiebooks\tools\bin\compiler\compile.bat
set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

cd /D %HOME%

if exist %HOME%\OpsRookieBooks (
cd OpsRookieBooks
goto select
) else (
goto :bad
)

:bad
echo Git directory does not exist, run pull script
pause
goto EOF

:commit-question
set /p commit=Would you like to commit your changes (Y/N)?
if %commit%==Y (goto add)
if %commit%==y (goto add)
if %commit%==N (goto EOF)
if %commit%==n (goto EOF)
echo Please choose Y or N
goto commit-question

:add
cd %HOME%\OpsRookieBooks
%git% add -A
%git% status
goto commit

:commit
set /p message=Enter commit message: 
set /p author=Enter your full name:
set /p email=Enter your FNAL email: 
%git% commit -m "%message%" --author="%author% <%email%>"
echo Your added files have been commited.
goto push

:push
%git% push origin master
echo Your commited files have been uploaded to the server
pause
goto EOF

:select
SET index=1

echo Please choose a document to compile

SETLOCAL ENABLEDELAYEDEXPANSION
FOR /d %%f IN (*) DO (
   SET file!index!=%%f
   ECHO !index! - %%f
   SET /A index=!index!+1
)

SETLOCAL DISABLEDELAYEDEXPANSION

SET /P selection="select file by number:"

SET file%selection% >nul 2>&1

IF ERRORLEVEL 1 (
   ECHO invalid number selected   
   EXIT /B 1
)

CALL :RESOLVE %%file%selection%%%

:compile
ECHO selected file name: %file_name%
cd %file_name%
setlocal disableDelayedExpansion
for /f "delims=" %%A in ('forfiles /m *.tex /c "cmd /c echo @FNAME"') do (
call %comp% %%A
)
cls
echo PDF compiled successfully!
pause
GOTO :commit-question

:RESOLVE
SET file_name=%1
GOTO :EOF
:~0,-9%
