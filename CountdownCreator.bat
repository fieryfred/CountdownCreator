@echo off
for %%A in (%1%) do (set FILENAME=%%~nA)

echo %FILENAME%


set DURATION=30
set FONTCOLOUR=fontcolor=white
set FONTBORDER=borderw=2:bordercolor=black
set FONTFILE=fontfile='c\:\\windows\\fonts\\Arialbd.ttf'

set FADESTART=%DURATION%-20
set FADEEND=%DURATION%-15

set SMALLTEXT=text='Starting in %%{eif\:(%DURATION%-t)/60\:d\:2}m %%{eif\:mod(%DURATION%-t, 60)\:d\:2}s'
set SMALLFONTSIZE=fontsize=40
set SMALLXPOS=x=(w-text_w)-(0.1*w)
set SMALLYPOS=y=(h-text_h)-(0.1*h)
set SMALLENABLE=enable='lt(t,%FADEEND%)'
set SMALLALPHA=alpha='if(lt(t,%FADESTART%),1,(%FADEEND%-t)/5)'
set SMALLCOUNTDOWN=drawtext=%SMALLTEXT%:%FONTFILE%:%SMALLFONTSIZE%:%FONTCOLOUR%:%SMALLXPOS%:%SMALLYPOS%:%FONTBORDER%:%SMALLENABLE%:%SMALLALPHA%

set LARGETEXT=text='%%{eif\:mod(%DURATION%-t, 60)\:d}'
set LARGEFONTSIZE=fontsize=400
set LARGEXPOS=x=(w-text_w)/2
set LARGEYPOS=y=(h-text_h)/2
set LARGEENABLE=enable='between(t,%FADESTART%,%DURATION%-1)'
set LARGEALPHA=alpha='if(gt(t,%FADEEND%),0.5,(t-(%FADESTART%))/10)'
set LARGECOUNTDOWN=drawtext=%LARGETEXT%:%FONTFILE%:%LARGEFONTSIZE%:%FONTCOLOUR%:%LARGEXPOS%:%LARGEYPOS%:%FONTBORDER%:%LARGEENABLE%:%LARGEALPHA%

%FFMPEG_PATH%\ffmpeg -loop 1 -r 5 -t %DURATION% -i %FILENAME% -y -vf "%SMALLCOUNTDOWN%,%LARGECOUNTDOWN%" out.mp4