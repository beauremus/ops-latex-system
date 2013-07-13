::
::This calls Git to pull down and upload files
::

@echo off

set rb="Y:\Public\rookiebooks"
set git="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\GitPortable\cmd\git.exe"

if not exist "%NPP%" @set NPP=%ProgramFiles(x86)%\Notepad++\notepad++.exe
if not exist "%NPP%" @set NPP=%ProgramFiles%\Notepad++\notepad++.exe

cd /D %rb%

if exist .\OpsRookieBooks (
	goto pull
) else (
	goto prompt
)

:prompt
echo First time downloading files?
goto clone

:clone
%git% clone http://beau:beau01git@chablis.fnal.gov/git/OpsRookieBooks.git
%git% config --global core.autocrlf true
%git% config --global core.editor "'%NPP%' -multiInst -notabbar -nosession -noPlugin"
%git% config --global merge.tool npp
%git% config --global diff.tool npp
%git% config --global mergetool.npp.path "%npp%"
%git% config --global difftool.npp.path "%npp%"
%git% config --global mergetool.npp.cmd "%npp% $BASE $LOCAL $REMOTE $MERGED"
%git% config --global difftool.npp.cmd "%npp% $BASE $LOCAL $REMOTE $MERGED"
%git% config --global push.default simple
pause
explorer %rb%\OpsRookieBooks
goto eos

:pull
cd %rb%\OpsRookieBooks
%git% reset --soft origin/master
%git% stash
%git% pull
%git% stash pop
%git% mergetool
%git% stash clear
pause
explorer %rb%\OpsRookieBooks
goto eos

:eos
exit

