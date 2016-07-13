# Streaming Tech Toolbelt
We have created a toolbelt for streaming technicians. The toolbelt is a Docker container[1] filled with pre-built versions of video streaming related tools such as ffmpeg, mp4dash (Bento4) and Shaka Packager. This toolbelt is maintained by Eyevinn Technology, a Swedish company with consultants specialized in video and streaming technology

[1] https://hub.docker.com/r/eyevinntechnology/toolbelt/

# How to use it

## Install Docker
First you need to ensure that you have Docker installed and running. If you don't know what Docker is you can find more information about it here: https://www.docker.com/what-docker

Instructions on how to install Docker on:
  - Mac: https://docs.docker.com/docker-for-mac/
  - Windows: https://docs.docker.com/docker-for-windows/
  - Linux: https://docs.docker.com/engine/getstarted/

## Run the container

Fetch the latest version and run it

    docker run -it -v /Users/myuser:/mnt eyevinntechnology/toolbelt:latest /bin/bash
     
This will also mount your home directory (example on Mac) to /mnt inside your Docker container to make it possible to access for example media files on your computer. You will then be presented with this welcome message:

```
Welcome to Eyevinn Technology's streaming toolbelt

If you don't want to run as super user:

   su - eyevinn

Installed pre-compiled packages for:
 - ffmpeg
 - Bento4 (https://www.bento4.com)
 - Shaka Packager (https://github.com/google/shaka-packager)

Enjoy!

Questions about this Docker image? Send an email to us at info@eyevinn.se or chat
with us on Twitter (@InfoEyevinn)
root@cb78e699371d:/# 
```

This means that you are inside the Docker container. You probably don't want to run the commands as super user so we prepared the image with an ordinary user. Switch to this user with this command

    root@cb78e699371d:~# su - eyevinn

Now you can for example run ffprobe on a file on your local computer:

    eyevinn@cb78e699371d:~$ ffprobe /mnt/Movies/trailer.mp4

# How to contact us
We are happy to receive feedback and ideas on more tools we should add to this toolbelt. Drop us an email at info@eyevinn.se or chat with us on Twitter (https://twitter.com/InfoEyevinn)

Hope you find this useful!
