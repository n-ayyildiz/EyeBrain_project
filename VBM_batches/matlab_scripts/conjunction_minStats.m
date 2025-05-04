%-----------------------------------------------------------------------
% This script uses the approach by Tom Nichols et al 2005 'Valid conjunction
% inference with the minimum statistic, DOI:10.1016/j.neuroimage.2004.12.005'
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.imcalc.input = {
                                        '/path/to/FWE_cluster_corrected_result_wCVR.nii,1'
                                        '/path/to/FWE_cluster_corrected_result_woutCVR.nii,1'
                                        };
matlabbatch{1}.spm.util.imcalc.output = 'conjunction.nii';
matlabbatch{1}.spm.util.imcalc.outdir = {'/path/to/outputFolder'};
matlabbatch{1}.spm.util.imcalc.expression = 'min(X)';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{1}.spm.util.imcalc.options.mask = -1;
matlabbatch{1}.spm.util.imcalc.options.interp = 0;
matlabbatch{1}.spm.util.imcalc.options.dtype = 64;
