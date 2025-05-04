%-----------------------------------------------------------------------
% Second-level analysis: Multiple Regression, when averaged global RNFLT
% variable is independent and brain grey matter density is 
% dependent variable when age, TIV, sex, averaged retina scanning radius 
% were covariates of no interest within Factorial Design specification, 
% followed by Model review and Model estimation steps
% based on CAT12.8.2 VBM (voxel-based morphometry) 
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.factorial_design.dir = {'/path/to/averaged_global_RNFLT_withoutCVR'};
matlabbatch{1}.spm.stats.factorial_design.des.mreg.scans = {'/path/to/SUB-IDs/anat/mri/smoothed_mwp1T1w.nii,1'};
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov = struct('c', {}, 'cname', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.des.mreg.incint = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = 'vectorValues';
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = 'vectorValues';
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'TIV';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(3).c = 'vectorValues';
matlabbatch{1}.spm.stats.factorial_design.cov(3).cname = 'sex';
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(4).c = 'vectorValues';
matlabbatch{1}.spm.stats.factorial_design.cov(4).cname = 'averageGlobalRNFLT';
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(5).c = 'vectorValues';
matlabbatch{1}.spm.stats.factorial_design.cov(5).cname = 'averageRadius';
matlabbatch{1}.spm.stats.factorial_design.cov(5).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(5).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tma.athresh = 0.1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.review.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.review.display.matrix = 1;
matlabbatch{2}.spm.stats.review.print = 'ps';
matlabbatch{3}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{3}.spm.stats.fmri_est.method.Classical = 1;
