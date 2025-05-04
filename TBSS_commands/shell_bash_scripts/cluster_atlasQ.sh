#!/bin/bash

#FSL
#thresholding #masking
#cluster #atlasq (old-> atlasquery)

cd /path/to/stats/folder/

#masking
fslmaths tbss_clustere_corrp_tstat1.nii.gz -thr 0.95 -bin tbss_clustere_corrp_tstat1_MASK.nii.gz

#cluster
cluster -i tbss_L_G_n550_wCVR_clustere_corrp_tstat1.nii.gz -t 0.95 --mm > tbss_clustere_corrp_tstat1.output 

# ------------------------------------------------------------------------
# atlas query
# the atlasses used for reporting of the clusters 

atlasq ohi -a "JHU ICBM-DTI-81 White-Matter Labels" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_JHU_ICBM.output

atlasq ohi -a "Juelich Histological Atlas" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_Juelich.output

atlasq ohi -a "JHU White-Matter Tractography Atlas" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_JHU_Tractography.output
# ------------------------------------------------------------------------
## other atlasses for alternative information
atlasq ohi -a "Harvard-Oxford Cortical Structural Atlas" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_HarvardCort.output

atlasq ohi -a "Harvard-Oxford Subcortical Structural Atlas" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_HarvardSubCort.output

atlasq ohi -a "MNI Structural Atlas" -m tbss_clustere_corrp_tstat1_MASK > atlasquery_MNI.output

echo 'done'
###
