#!/usr/bin/env python
# coding: utf-8

# In[ ]:
#import libraries
from nilearn import plotting
import nibabel as nib
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import LinearSegmentedColormap

# In[6]:
    # Mango red_overlay color range exported
    # 'mango_red_overlay.lut' file
    # Define the normalized positions and RGB values (converted to [0, 1])
mango_lut_positions = [0.0, 0.5, 0.95, 1.0]
mango_lut_colors = [
    (191/255, 0/255, 0/255),      # Dark red
    (255/255, 127/255, 0/255),    # Orange
    (255/255, 255/255, 0/255),    # Yellow
    (255/255, 255/255, 255/255)   # White (alpha = 0 originally)
]

# Create the custom colormap
mango_red_overlay = LinearSegmentedColormap.from_list(
    'mango_red_overlay',
    list(zip(mango_lut_positions, mango_lut_colors)),
    N=256
)

#%%

#load nifti data
data = nib.load('path/to/avg_TNFLT.nii')


# In[7]:


#load nifti data
data2 = nib.load('path/to/results_avG_woutCVR.nii')


# In[21]:

# Visualize the image using a glass brain plot 
plotting.plot_glass_brain(data,
                          # title="Glass Brain Visualization",
                          #display_mode='ortho',  # You can try 'ortho', 'triplanar', etc.
                          colorbar=True,  # Show the colorbar
                          #plot_abs=False,  # If you want to display absolute values (usually useful for contrast)
                          cmap=mango_red_overlay, #'YlOrRd_r', 'hot'
                          threshold=3.1,
                          #vmax=6.2,  # Set maximum value to 6.2 for the color scale
                          vmin=3.1,
                          vmax=6.4)  # Set minimum value to 3.1 for the color scale

# Show the plot
#plt.show()
plt.savefig("avG_wCVR_glass_4May2025.svg", format='svg')


# In[22]:

# Visualize the image using a glass brain plot 
plotting.plot_glass_brain(data2,
                          # title="Glass Brain Visualization",
                          #display_mode='ortho',  # You can try 'ortho', 'triplanar', etc.
                          colorbar=True,  # Show the colorbar
                          cmap=mango_red_overlay, #'YlOrRd_r', 'hot'
                          #plot_abs=False,  # If you want to display absolute values (usually useful for contrast)
                          threshold=3.1,
                          vmin=3.1,
                          vmax=6.4)  # Adjust this for better visualization based on your data 

# Show the plot
#plt.show()
plt.savefig("avG_woutCVR_glass_4May2025.svg", format='svg')


# In[5]:

# to see other color options defined in python
# import matplotlib.pyplot as plt
# print(plt.colormaps())


# In[ ]:

