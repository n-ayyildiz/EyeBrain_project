%-----------------------------------------------------------------------
% Preprocessing: Smoothing based on CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.spatial.smooth.data = {'/path/to/SUB-IDs/anat/mri/mwp1T1w.nii,1'};
matlabbatch{1}.spm.spatial.smooth.fwhm = [8 8 8];
matlabbatch{1}.spm.spatial.smooth.dtype = 0;
matlabbatch{1}.spm.spatial.smooth.im = 0;
matlabbatch{1}.spm.spatial.smooth.prefix = 'smoothed_';
