#!/bin/bash
docker build -t gstreamer_deploy_example -f Dockerfile.deploy .
docker run --rm -t --gpus all --network host -u $UID -e DISPLAY --ipc host -v /tmp/.X11-unix:/tmp/.X11-unix \
    gstreamer_deploy_example \
    gst-launch-1.0 videotestsrc ! autovideosink
