%-----------------------------------------------------------------------
% Investigation of Quality Ratings (IQR) of the images based on CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.iqr.data_xml = {'/path/to/SUB-IDs/anat/report/cat_T1w.xml'};
matlabbatch{1}.spm.tools.cat.tools.iqr.iqr_name = '/path/to/output/IQR.txt';
