# Countdown Creator
This batch file will create a video, with a countdown, from an image file. 

https://user-images.githubusercontent.com/54833655/170360269-6b2fadb1-c989-4160-8762-2b5bacbd5f9e.mp4

It was written is to provide a simple introduction video for live-streaming a Church service. And, because it will be used by non-technical users it has to be simple. Therefore, the batch file only takes one argument, which is the input image file, and so can be placed as a shortcut on the desktop.
## Requirements
FFMPEG needs to be installed. It can be downloaded from [ffmpeg](https://ffmpeg.org/download.html#build-windows). The batch file uses the 'libx264' encoder so download the 'GPL' version.
## Environment Variables
| Variable | Description|
|----------|------------|
|FFMPEGPATH|The path to the ffmpeg `bin` directory. This is only required if it is not already included in the `PATH` environment variable|
| VIDEODIR|The path to the directory to store the generated video. If not defined then videos are stored in the current user's home directory|

## Usage

The default is to create a 15 minute video with a timer in the bottom right hand corner. For the last 30 seconds, the timer is replaced by a large count down in the centre of the screen.

1. Create a shortcut of the desktop to the batch file. Dragging and dropping an image file onto the shortcut will generate the video.
2. Open a command prompt in the directory the batch file is installed and run:
> `countdowncreator.bat imagefile.jpg`
