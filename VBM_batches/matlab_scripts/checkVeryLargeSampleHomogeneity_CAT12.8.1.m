%-----------------------------------------------------------------------
% check sample homogeneity for very large samples based on CAT12.8.1
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.quality_measures.data = {'/path/to/SUB-IDs/anat/mri/mwp1T1w.nii,1'};
matlabbatch{1}.spm.tools.cat.tools.quality_measures.globals = 0;
matlabbatch{1}.spm.tools.cat.tools.quality_measures.csv_name = '/path/to/output/Quality_measures.csv';