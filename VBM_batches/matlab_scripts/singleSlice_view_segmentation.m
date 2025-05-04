%-----------------------------------------------------------------------
% single slice imaging of the Preprocessing outputs, here segmentation,
% based on CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.showslice.data_vol = {'/path/to/SUB-IDs/anat/mri/wmT1w.nii,1'};
matlabbatch{1}.spm.tools.cat.tools.showslice.scale = 0;
matlabbatch{1}.spm.tools.cat.tools.showslice.orient = 3;
matlabbatch{1}.spm.tools.cat.tools.showslice.slice = 0;
