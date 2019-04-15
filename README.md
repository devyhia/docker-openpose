# Openpose Docker Build

Build Date: *April 14,  2019*

## Build Details

- Ubuntu 16.04
- Cuda 10
- CMU Openpose (master branch, commit: `b6058505a61a65b14510470c6c0212c88df57e40`)
- CMU Caffe fork (master branch, commit: `b5ede488952e40861e84e51a9f9fd8fe2395cc8a`)

## How to run openpose against images?

  1. Bash into the docker image:
  ```
  docker run -v /path/to/images:/images --runtime=nvidia --rm -it  openpose bash
  ```
  2. Run the following command:
  ```
  /openpose/build/examples/openpose/openpose.bin --image_dir /images --display 0 --render_pose 0 --write_json /images
  ```

  Now, the poses will saved along with the images as json files.
