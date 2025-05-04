#!/usr/bin/env python
# coding: utf-8

# In[ ]:


#import libraries
from nilearn import plotting
import nibabel as nib
import matplotlib.pyplot as plt


# In[6]:


#load nifti data
data = nib.load('path/to/results_avG_wCVR.nii')


# In[7]:


#load nifti data
data2 = nib.load('path/to/results_avG_woutCVR.nii')


# In[ ]:





# In[21]:


# Visualize the image using a glass brain plot 
plotting.plot_glass_brain(data,
                          # title="Glass Brain Visualization",
                          #display_mode='ortho',  # You can try 'ortho', 'triplanar', etc.
                          colorbar=True,  # Show the colorbar
                          #plot_abs=False,  # If you want to display absolute values (usually useful for contrast)
                          cmap='hot', #'YlOrRd_r',
                          threshold=3.1,
                          #vmax=6.2,  # Set maximum value to 6.2 for the color scale
                          vmin=3.1,
                          vmax=6.4)  # Set minimum value to 3.1 for the color scale

# Show the plot
#plt.show()
plt.savefig("avG_wCVR_glass_6apr2025.svg", format='svg')


# In[22]:


# Visualize the image using a glass brain plot 
plotting.plot_glass_brain(data2,
                          # title="Glass Brain Visualization",
                          #display_mode='ortho',  # You can try 'ortho', 'triplanar', etc.
                          colorbar=True,  # Show the colorbar
                          cmap='hot', #'YlOrRd_r',
                          #plot_abs=False,  # If you want to display absolute values (usually useful for contrast)
                          threshold=3.1,
                          vmin=3.1,
                          vmax=6.4)  # Adjust this for better visualization based on your data 

# Show the plot
#plt.show()
plt.savefig("avG_woutCVR_glass_6apr2025.svg", format='svg')


# In[5]:


import matplotlib.pyplot as plt
print(plt.colormaps())


# In[ ]:




