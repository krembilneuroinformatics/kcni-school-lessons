function tnueeg_smooth_images( images, options )
%TNUEEG_SMOOTH_IMAGES Convolutes an image in 3D using a Gaussian filter
%   IN:     images      - cell array list of image names to smooth
%           options     - the struct that holds all analysis options
%   OUT:    --

nImages = numel(images);
% in ERP conversion, nImages equals the number of conditions
% in single-trial conversion, nImages equals the number of trials

% Gaussian filter width {FWHM} in mm, can be anisotropic ([sx sy sz]) or a
% scalar for isotropic smoothing. For EEG data that have been filtered in
% time already (using high- and lowpass filters during preprocessing), it
% is sufficient to smooth in space only ([sx sy 0]).
s = options.conversion.smooKernel;
dtype = 0;

for imIdx = 1: nImages
    % determine name of smoothed images (Q) from unsmoothed (P)
    [imPath, imFile, imExt, imNum] = spm_fileparts(images{imIdx});
    P = fullfile(imPath, [imFile imExt imNum]);
    Q = fullfile(imPath, ['smoothed_' imFile imExt imNum]);
    
    % actual smoothing
    spm_smooth(P, Q, s, dtype);
    
    % make sure implicit masks are preserved 
    % note: an implicit mask is implied by a particular voxel value (0 for 
    % images with integer type, NaN for float images)
    volIn = spm_vol(P);
    volOut = spm_vol(Q);
    for j=1:numel(volIn)
        volVolIn = spm_read_vols(volIn(j),1);
        volVolOut = spm_read_vols(volOut(j));
        if spm_type(volOut(j).dt(1),'nanrep')
            volVolOut(isnan(volVolIn)) = NaN;
        else
            volVolOut(isnan(volVolIn)) = 0;
        end
        spm_write_vol(volOut(j),volVolOut);
    end
end

end