::
:: Called from Notepad++ -> Run
:: \\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\notepad2latex.bat "$(NAME_PART)"
::
:: %1 == $(NAME_PART) | %2 == $(CURRENT_DIRECTORY)

@ECHO off

:: Variables
set comp="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\compiler\compile.bat"
set quick="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\compiler\quick-compile.bat"
set commit="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\tools\bin\git\commit-push.bat"

if exist %2 (
goto compile-question
) else (
goto bad
)

:bad
echo Git directory does not exist, run pull script
pause
goto EOF

:compile-question
set /p compile=Would you like to do a quick compile (Q) or a full compile (F)?
if %compile%==Q (call %quick% %1 %2
goto commit)
if %compile%==q (call %quick% %1 %2
goto commit)
if %compile%==F (call %comp% %1 %2
goto commit)
if %compile%==f (call %comp% %1 %2
goto commit)
echo Please choose Q or F
goto compile-question

:commit
call %commit%
goto eof