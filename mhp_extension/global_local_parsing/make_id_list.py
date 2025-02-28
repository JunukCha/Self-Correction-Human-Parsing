import os

TYPE = 'crop_pic'  # crop_pic or DemoDataset
IMG_DIR = '../mhp_extension/data/DemoDataset/crop_pic'
SAVE_DIR = '../mhp_extension/data/DemoDataset'

if not os.path.exists(SAVE_DIR):
    os.makedirs(SAVE_DIR)

with open(os.path.join(SAVE_DIR, TYPE + '.txt'), "w") as f:
    for img_name in os.listdir(IMG_DIR):
        f.write(img_name[:-4] + '\n')

TYPE = 'global_pic'  # crop_pic or DemoDataset
IMG_DIR = '../mhp_extension/data/DemoDataset/global_pic'
SAVE_DIR = '../mhp_extension/data/DemoDataset'

if not os.path.exists(SAVE_DIR):
    os.makedirs(SAVE_DIR)

with open(os.path.join(SAVE_DIR, TYPE + '.txt'), "w") as f:
    for img_name in os.listdir(IMG_DIR):
        f.write(img_name[:-4] + '\n')
