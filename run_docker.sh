WORKSPACE=/media/data/fiftyone
DATA=/media/data/datasets

docker run -it \
	--gpus all \
    -w $WORKSPACE \
	-v $WORKSPACE:$WORKSPACE \
	-v $DATA:$DATA \
	-p 5151:5151 \
	-p 8888:8888 \
	fiftyone
