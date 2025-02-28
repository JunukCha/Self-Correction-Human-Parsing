conda create -n schp python=3.10 -y
conda activate schp
conda install pytorch==1.13.1 torchvision==0.14.1 torchaudio==0.13.1 pytorch-cuda=11.7 -c pytorch -c nvidia -y

pip install scikit-image pycocotools numpy==1.23.5 opencv-python joblib

python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
