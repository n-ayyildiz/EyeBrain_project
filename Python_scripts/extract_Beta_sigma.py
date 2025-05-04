#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 12 17:04:59 2024

@author: ayyildiz
"""
#from @Samyogita Hardikar

#check before if libraries installed, otherwise:
#pip install nilearn
#pip install nibabel

import nibabel as nib
import nilearn
import numpy as np

#from pprint import pprint

# load nifti
nifti = nib.load('/path/to/inputFolder/filename.nii')

# get data as 3D array or 2D array
nifti_data = nifti.get_fdata()

nifti_data.shape

#reshape 3D array into 1D array for VBM output
nifti_data_rs = nifti_data.reshape((nifti_data.shape[0]*nifti_data.shape[1]*nifti_data.shape[2]*nifti_data.shape[3]))

#reshape 2D array into 1d array for TBSS output
#nifti_data_rs = nifti_data.reshape((nifti_data.shape[0]*nifti_data.shape[1]*nifti_data.shape[2]))

#save 1d array as csv

np.savetxt('/path/to/outputFolder/filename.csv', nifti_data_rs, delimiter=",")

#


