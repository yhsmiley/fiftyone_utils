WORKSPACE=/media/data/fiftyone_utils
DATA=/media/data/datasets
# SHARED_DIR=/path/to/shared/dir

docker run -it \
	--gpus all \
	--net host \
    -w $WORKSPACE \
	-v $WORKSPACE:$WORKSPACE \
	-v $DATA:$DATA \
	-p 5151:5151 \
	-p 8888:8888 \
	fiftyone

	# -v $HOME/.Xauthority:/root/.Xauthority:rw \
	# -v /tmp/.X11-unix:/tmp/.X11-unix \
	# -e DISPLAY=unix$DISPLAY \
	# -e QT_X11_NO_MITSHM=1 \
	# --shm-size=64g \
	# -v ${SHARED_DIR}:/fiftyone
