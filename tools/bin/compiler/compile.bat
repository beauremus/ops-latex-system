::
::Take input and compile with pdfLaTeX
::
tskill acroRD32

:: Variables
set pdf="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\MikTexPortable\miktex\bin\pdflatex"
set bib="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\MikTexPortable\miktex\bin\bibtex"
set ind="\\beamssrv1.fnal.gov\operations.bd\Public\rookiebooks\MikTexPortable\miktex\bin\makeindex"

pushd %2

:: Run Cleanup
call:cleanup

:: Run pdflatex -> bibtex -> pdflatex -> pdflatex
%pdf% %1
::%pdf% %1

:: If you are using bibliography the following will run bibtex
%bib% %1

:: If you are using glossaries the following will run makeglossaries
%ind% -s %1.ist -t %1.glg -o %1.gls %1.glo

:: If you are using acronym option for glossaries the following will run makeglossaries
%ind% -s %1.ist -t %1.alg -o %1.als %1.acn

:: If you are using makeidx the following will run makeindex on .idx and creates .ind
%ind% %1

:: Auxiliary pdflatex run to make sure everything is accounted for
%pdf% %1

:: Run Cleanup
call:cleanup

:: START Acrobat
START "" %1.pdf
goto eof

:eof
cls
echo PDF compiled successfully!
pause

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