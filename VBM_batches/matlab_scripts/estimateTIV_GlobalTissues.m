%-----------------------------------------------------------------------
% Calculating total intracranial volume (TIV) based on CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.calcvol.data_xml = {'/path/to/SUB-IDs/anat/report/cat_T1w.xml'};
matlabbatch{1}.spm.tools.cat.tools.calcvol.calcvol_TIV = 0;
matlabbatch{1}.spm.tools.cat.tools.calcvol.calcvol_savenames = 2;
matlabbatch{1}.spm.tools.cat.tools.calcvol.calcvol_name = '/path/to/output/TIV.txt';
