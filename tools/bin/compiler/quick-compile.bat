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
 
:: Run pdflatex
%pdf% %1

:: Auxiliary pdflatex run to make sure everything is accounted for
::%pdf% %1

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