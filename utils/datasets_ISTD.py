import glob
import random
import os
import torch.utils.data as data
from torch.utils.data import Dataset
from PIL import Image
import torchvision.transforms as transforms

def make_datapath_list(phase="train", rate=0.8):
    """
    make filepath list for train, validation and test images
    """
    random.seed(44)

    rootpath = './dataset/' + phase + '/'
    files_name = os.listdir(rootpath + phase + '_A')

    if phase=='train':
        random.shuffle(files_name)
    elif phase=='test':
        files_name.sort()

    path_A = []
    path_B = []
    path_C = []

    for name in files_name:
        path_A.append(rootpath + phase + '_A/'+name)
        path_B.append(rootpath + phase + '_B/'+name)
        path_C.append(rootpath + phase + '_C/'+name)

    num = len(path_A)

    if phase=='train':
        path_A, path_A_val = path_A[:int(num*rate)], path_A[int(num*rate):]
        path_B, path_B_val = path_B[:int(num*rate)], path_B[int(num*rate):]
        path_C, path_C_val = path_C[:int(num*rate)], path_C[int(num*rate):]
        path_list = {'path_A': path_A, 'path_B': path_B, 'path_C': path_C}
        path_list_val = {'path_A': path_A_val, 'path_B': path_B_val, 'path_C': path_C_val}
        return path_list,path_list_val

    elif phase=='test':
        path_list = {'path_A': path_A, 'path_B': path_B, 'path_C': path_C}
        return path_list


class ImageDataset(data.Dataset):
    """
    Dataset class. Inherit Dataset class from PyTrorch.
    """
    def __init__(self, img_list, img_transform, phase):
        self.img_list = img_list
        self.img_transform = img_transform
        self.phase = phase

    def __len__(self):
        return len(self.img_list['path_A'])

    def __getitem__(self, index):
        '''
        get tensor type preprocessed Image
        '''
        img = Image.open(self.img_list['path_A'][index]).convert('RGB')
        gt_shadow = Image.open(self.img_list['path_B'][index])
        gt = Image.open(self.img_list['path_C'][index]).convert('RGB')

        img, gt_shadow, gt = self.img_transform(self.phase, [img, gt_shadow, gt])

        return img, gt_shadow, gt

if __name__ == '__main__':
    img = Image.open('./dataset/train/train_A').convert('RGB')#E:\caoang\DM\ST-CGAN-master\dataset
    gt_shadow = Image.open('./dataset/train/train_B')
    gt = Image.open('./dataset/train/train_C').convert('RGB')
