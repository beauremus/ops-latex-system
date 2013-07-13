::
::This calls Git to pull down and upload files
::

@echo off

set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
if not exist "%HOME%" @set HOME=%USERPROFILE%
if not exist "%NPP%" @set NPP=%ProgramFiles(x86)%\Notepad++\notepad++.exe
if not exist "%NPP%" @set NPP=%ProgramFiles%\Notepad++\notepad++.exe

cd /D %HOME%

if exist .\OpsRookieBooks (
	goto pull
) else (
	goto prompt
)

:prompt
echo First time downloading files?
set /p full_name=Please enter your full name:
set /p email=Please eneter your FNAL email address:
set name=%email:~0,-9%
goto clone

:clone
%git% clone http://%name%@chablis.fnal.gov/git/OpsRookieBooks.git
%git% config --global user.name "%full_name%"
%git% config --global user.email %email%
%git% config --global core.autocrlf true
%git% config --global core.editor "'%NPP%' -multiInst -notabbar -nosession -noPlugin"
%git% config --global merge.tool npp
%git% config --global diff.tool npp
%git% config --global mergetool.npp.path "%npp%"
%git% config --global difftool.npp.path "%npp%"
%git% config --global mergetool.npp.cmd "%npp% $BASE $LOCAL $REMOTE $MERGED"
%git% config --global difftool.npp.cmd "%npp% $BASE $LOCAL $REMOTE $MERGED"
pause
explorer .\OpsRookieBooks
goto eos

:pull
cd .\OpsRookieBooks
%git% reset --soft origin/master
%git% stash
%git% pull
%git% stash pop
%git% mergetool
%git% stash clear
pause
explorer .\OpsRookieBooks
goto eos

:eos
exit

