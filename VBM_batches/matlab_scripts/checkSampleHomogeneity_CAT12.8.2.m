%-----------------------------------------------------------------------
% This script checks sample homogeneity based an CAT12.8.2
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.tools.cat.tools.check_homogeneity.data = {
                                                             {
                                                             '/path/to/SUB-IDs/anat/mri/mwp1T1w.nii,1'
                                                             }
                                                             }';
matlabbatch{1}.spm.tools.cat.tools.check_homogeneity.sel_xml.data_xml = {
                                                                         '/path/to/SUB-IDs/anat/report/cat_T1w.xml'
                                                                         };
matlabbatch{1}.spm.tools.cat.tools.check_homogeneity.globals = 0;
matlabbatch{1}.spm.tools.cat.tools.check_homogeneity.c = cell(1, 0);