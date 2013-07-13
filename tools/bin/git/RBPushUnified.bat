::
::This calls Git to add, commit, and push
::

@echo off

set rb="Y:\Public\rookiebooks"
set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

cd /D %rb%

if not exist .\OpsRookieBooks (
	goto bad
) else (
	goto commit-question
)

:bad
echo Git directory does not exist, run pull script
pause
goto eos

:add
cd %rb%\OpsRookieBooks
%git% add -A
%git% status
goto commit

:commit-question
set /p commit=Would you like to commit your changes (Y/N)?
if %commit%==Y (goto add)
if %commit%==y (goto add)
if %commit%==N (goto push-question)
if %commit%==n (goto push-question)
echo Please choose Y or N
goto commit-question

:commit
set /p message=Enter commit message: 
set /p author=Enter your full name:
set /p email=Enter your FNAL email: 
%git% commit -m "%message%" --author="%author% <%email%>"
echo Your added files have been commited.
goto push-question

:push-question
set /p push=Would you like to push your changes to the server (Y/N)?
if %push%==Y (goto push)
if %push%==y (goto push)
if %push%==N (goto eos)
if %push%==n (goto eos)
echo Please choose Y or N
goto push-question

:push
%git% push origin master
echo Your commited files have been uploaded to the server
pause
goto eos

:eos
exit