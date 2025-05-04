%-----------------------------------------------------------------------
% Calculating mean volume of the ROIs taken from prechosen atlasses in
% segmentation step based on CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.calcroi.roi_xml = {'/path/to/SUB-IDs/anat/label/catROI_T1w.xml'};
matlabbatch{1}.spm.tools.cat.tools.calcroi.point = '.';
matlabbatch{1}.spm.tools.cat.tools.calcroi.outdir = {'/path/to/outputFolder'};
matlabbatch{1}.spm.tools.cat.tools.calcroi.calcroi_name = 'fileName';
