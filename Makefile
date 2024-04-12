.PHONY: all train test demo clean
.ONESHELL:

all:

venv:
	python -m venv venv
	. venv/bin/activate
	pip install -U torch torchvision cython
	test -d detectron2_repo || git clone https://github.com/facebookresearch/detectron2 detectron2_repo
	pip install -e detectron2_repo
	test -d pytorchvideo || git clone https://github.com/facebookresearch/pytorchvideo pytorchvideo
	pip install -e pytorchvideo
	pip install -e .
	pip install japanize_matplotlib

train:
	. venv/bin/activate
	-rm -rf json_stats.log stdout.log checkpoints
	python tools/run_net.py --cfg configs/Kinetics/C2D_8x8_R50.yaml

test:
	. venv/bin/activate
	python tools/run_net.py --cfg configs/Kinetics/C2D_8x8_R50-test.yaml

demo:
	. venv/bin/activate
	python tools/run_net.py --cfg configs/Kinetics/C2D_8x8_R50-demo.yaml

clean:
	-rm -rf venv
