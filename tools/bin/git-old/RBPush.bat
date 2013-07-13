::
::This calls Git to add, commit, and push
::

@echo off

set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
if not exist "%HOME%" @set HOME=%USERPROFILE%

cd /D %HOME%

if not exist .\OpsRookieBooks (
	goto bad
) else (
	goto add
)

:bad
echo Git directory does not exist, run pull script
pause
goto eos

:add
cd .\OpsRookieBooks
%git% add -A
%git% status
pause
goto commit-question

:commit-question
set /p commit=Would you like to commit your changes (Y/N)?
if %commit%==Y (goto commit)
if %commit%==y (goto commit)
if %commit%==N (goto eos)
if %commit%==n (goto eos)
echo Please choose Y or N
goto commit-question

:commit
set /p message=Enter commit message: 
%git% commit -m "%message%"
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