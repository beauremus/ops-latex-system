::
::Take input and compile with pdflatex
::
tskill acroRD32
 
:: Run Cleanup
call:cleanup
 
:: Run pdflatex -&gt; bibtex -&gt; pdflatex -&gt; pdflatex
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %1
::"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %1

:: If you are using bibliography the following will run bibtex
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\bibtex" %1

:: If you are using glossaries the following will run makeglossaries
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" -s %1.ist -t %1.glg -o %1.gls %1.glo

:: If you are using acronym option for glossaries the following will run makeglossaries
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" -s %1.ist -t %1.alg -o %1.als %1.acn

:: If you are using makeidx the following will run makeindex on .idx and creates .ind
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex" %1

:: Auxiliary pdflatex run to make sure everything is accounted for
"Y:\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex" %1

:: Run Cleanup
call:cleanup
 
:: Open PDF (Script updated based on comments by 'menfeser'
:: START "" "C:\Program Files\Adobe\Reader 9.0\Reader\AcroRd32.exe" %1.pdf
START "" %1.pdf
 
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