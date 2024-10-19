@echo off
setlocal

rem
rem Generate the output file name
rem
for %%f in (%1) do (set INPUTPATH=%%~pf)

if not defined VIDEODIR (set VIDEODIR="%INPUTPATH%")

set TARGETPATH="%INPUTPATH%\Countdown.mp4"


rem
rem Standard font values for the call to FFMPEG
rem 
set FONTCOLOUR=fontcolor=white
set FONTBORDER=borderw=2:bordercolor=black
set FONTFILE=fontfile='c\:\\windows\\fonts\\Arialbd.ttf'

rem
rem Parameters affecting the fade of the countdown text
rem all of them are in seconds
rem
set COUNTDOWN_DURATION=120
set LARGECOUNTCOUNTDOWN_DURATION=30
set FADECOUNTDOWN_DURATION=5

set /a FADESTART=%COUNTDOWN_DURATION%-%LARGECOUNTCOUNTDOWN_DURATION%
set /a FADEEND=%FADESTART%+5

rem The text showing the time left displayed in the bottom right hand corner, inset by 10% of the output width
set SMALLTEXT=text='Starting in %%{eif\:(%COUNTDOWN_DURATION%-t)/60\:d}m %%{eif\:mod(%COUNTDOWN_DURATION%-t, 60)\:d\:2}s'
set SMALLFONTSIZE=fontsize=40
set SMALLXPOS=x=(w-text_w)-(0.1*w)
set SMALLYPOS=y=(h-text_h)-(0.1*h)

rem Hide the text at the end of the fade
set SMALLENABLE=enable='lt(t,%FADEEND%)'

rem Use the Alpha channel to produce the fade
set SMALLALPHA=alpha='if(lt(t,%FADESTART%),1,(%FADEEND%-t)/%FADECOUNTDOWN_DURATION%)'
set SMALLCOUNTDOWN=drawtext=%SMALLTEXT%:%FONTFILE%:%SMALLFONTSIZE%:%FONTCOLOUR%:%SMALLXPOS%:%SMALLYPOS%:%FONTBORDER%:%SMALLENABLE%:%SMALLALPHA%

rem The big counter text that fades in for the last portion of the countdown, displayed
rem in the center of the video
set LARGETEXT=text='%%{eif\:mod(%COUNTDOWN_DURATION%-t, 60)\:d}'
set LARGEFONTSIZE=fontsize=400
set LARGEXPOS=x=(w-text_w)/2
set LARGEYPOS=y=(h-text_h)/2

rem Remove the counter at the end of the countdown
set LARGEENABLE=enable='between(t,%FADESTART%,%COUNTDOWN_DURATION%-1)'
set LARGEALPHA=alpha='if(gt(t,%FADEEND%),0.5,(t-(%FADESTART%))/10)'
set LARGECOUNTDOWN=drawtext=%LARGETEXT%:%FONTFILE%:%LARGEFONTSIZE%:%FONTCOLOUR%:%LARGEXPOS%:%LARGEYPOS%:%FONTBORDER%:%LARGEENABLE%:%LARGEALPHA%

rem Countdown Voice
set /a VOICE_OFFSET=(%COUNTDOWN_DURATION%-11) * 1000

if not defined COUNTDOWN_VOICE goto endvoice
set VOICE_COMMAND=-i %COUNTDOWN_VOICE% -filter_complex "[1:a] adelay=%VOICE_OFFSET%|%VOICE_OFFSET%[voice]" -map 0:v -map "[voice]"
:endvoice

rem
rem Set the path for FFMPEG
rem

if defined FFMPEGPATH (set PATH=%FFMPEGPATH%;"%PATH%")

ffmpeg -loop 1 -t %COUNTDOWN_DURATION% -i %1 %VOICE_COMMAND% -y -vf "fps=5,format=yuv420p,%SMALLCOUNTDOWN%,%LARGECOUNTDOWN%" -c:v libx264 %TARGETPATH%

echo Created video: %TARGETPATH%
