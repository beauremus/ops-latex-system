::
::Take input and compile with pdfLaTeX
::

:: Don't print script to screen
@ECHO OFF

:: Variables
set HOME="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\OpsRookieBooks"
set comp="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\compiler\compile.bat"
set quick="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\compiler\quick-compile.bat"
set commit="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\git\commit-push.bat"

pushd %HOME%

:select
SET index=1

cls
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
call :compile-question %%A
)
goto :eof

:RESOLVE
SET file_name=%1
goto compile
:~0,-9%

:compile-question
set /p compile=Would you like to do a quick compile (Q) or a full compile (F)?
if %compile%==Q (call %quick% %1
goto commit)
if %compile%==q (call %quick% %1
goto commit)
if %compile%==F (call %comp% %1
goto commit)
if %compile%==f (call %comp% %1
goto commit)
echo Please choose Q or F
goto compile-question

:commit
call %commit%
popd
goto :eof