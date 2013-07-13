:: Called from Notepad++ Run
:: [path_to_bat_file] "$(CURRENT_DIRECTORY)" "$(NAME_PART)"
:: %1 == $(CURRENT_DIRECTORY)
:: %2 == $(NAME_PART)

tskill acroRD32

:: Change Drive and  to File Directory
%~d1
cd %1
 
:: Run Cleanup
call:cleanup
 
:: Run pdflatex -&gt; bibtex -&gt; pdflatex -&gt; pdflatex
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %2

:: If you are using bibliography the following will run bibtex
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\bibtex" %2

"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %2

:: If you are using multibib the following will run bibtex on all aux files
::FOR /R . %%G IN (*.aux) DO "Y:\Public\rookiebooks\MikTexPortable\miktex\bin\bibtex" %%G

:: If you are using glossaries the following will run makeglossaries
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" -s %2.ist -t %2.glg -o %2.gls %2.glo

:: If you are using acronym option for glossaries the following will run makeglossaries
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" -s %2.ist -t %2.alg -o %2.als %2.acn

:: If you are using makeidx the following will run makeindex on .idx and creates .ind
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" %2

:: Auxiliary pdflatex run to make sure everything is accounted for
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %2

:: Run Cleanup
call:cleanup
 
:: Open PDF (Script updated based on comments by 'menfeser'
:: START "" "C:\Program Files\Adobe\Reader 9.0\Reader\AcroRd32.exe" %2.pdf
START "" %2.pdf
goto commit-question

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
echo Your commited files have been uploaded to the server.
pause
goto EOF
 
:: Cleanup Function
:cleanup
:: del *.log
:: del /*/*.log
del *.dvi
del *.aux
del /*/*.aux
del *.bbl
del *.blg
del *.brf
del *.out
del *.acn
del *.acr
del *.als
del *.glo
del *.gls
del *.idx
del *.ind
del *.ist
del *.lof
del *.lot
del *.toc
goto:eof