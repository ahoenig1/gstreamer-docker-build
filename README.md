# Building and using GStreamer in Docker

## Overview
This repository allows you to build GStreamer in a docker image, and then add it to another docker image to use.
There are two dockerfiles:
- Dockerfile.gstreamer is a multi-stage dockerfile.  In the first stage, it sets up a build environment with everything needed to compile GStreamer.  It then pulls the gst code from git, and builds it.  The second stage is a "from scratch" image (blank) which just copies the compiled GStreamer artifacts in.
- Dockerfile.develop is an example of how you would set up a development environment that uses GStreamer.  It sets up just the basics, installs the GStreamer dependencies, and then copies in the GStreamer artifacts from the final stage of Dockerfile.gstreamer.
- Dockerfile.deploy is an example of how you would set up a deployable image containing GStreamer (and applications that use GStreamer).  Only runtime dependencies are included.


## Quick-start
- run `./build_gstreamer.sh`
- run `./run_deploy_example.sh`
- TODO: somebody should add a quick sample that can be compiled in the develop image


## Dependencies
This repository only contains some video-related dependencies (build-time and deploy-time).  TODO: Somebody should add other dependencies (e.g. audio) in order to make the result more useful in general.


## Image repositories
This example tags the output of the GStreamer build stage as a local image (gstreamer_artifacts:latest), and then imports that local image into the develop and deploy images.  Instead, the compiled artifacts could be tagged with a repository location (dockerhub or private repo) and pushed there.  For example:
```
docker tag gstreamer_artifacts:latest gitlab.mycompany.com:12345/gstreamer:v1.2.3    # re-tag the output with a remote repository name
docker push gitlab.mycompany.com:12345/gstreamer:v1.2.3                              # push the image to the remote repository
```

In that case, GStreamer does not need to be compiled locally - the develop/deploy images can simply do:
```
RUN <install runtime dependencies here>
COPY --from=gitlab.mycompany.com:12345/gstreamer:v1.2.3 / /
```

