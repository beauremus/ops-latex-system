::
:: Commit and Push files
::

@ECHO off

:: Variables
set HOME=//beamssrv1.fnal.gov/operations.bd/Public/rookiebooks/OpsRookieBooks
set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

pushd %HOME%

if exist %HOME% (
goto commit-question
) else (
goto bad
)

:bad
echo Git directory does not exist, run pull script
pause
goto :eof

:commit-question
cls
set /p commit=Would you like to commit your changes (Y/N)?
if %commit%==Y (goto add)
if %commit%==y (goto add)
if %commit%==N (goto :eof)
if %commit%==n (goto :eof)
echo Please choose Y or N
goto commit-question

:add
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
echo Your commited files have been uploaded to the server.
pause
goto :eof