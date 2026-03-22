#!/bin/bash

git clone https://github.com/tamilts124/Youtube-Downloader-Personnel.git

cd Youtube-Downloader-Personnel

docker build -t youtube-downloader -f DockerfileWindows .

docker run -d -p 8000:8000 --name youtube-downloader-container youtube-downloader
