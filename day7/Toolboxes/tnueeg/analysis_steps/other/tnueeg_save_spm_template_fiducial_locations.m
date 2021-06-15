function fid = tnueeg_save_spm_template_fiducial_locations(filename)

fid.labels = {'NAS'; 'LPA'; 'RPA'};
fid.data   = [  1,    85,    -41; ...
              -83,   -20,    -65; ...
               83,   -20,    -65];
save(filename, 'fid');

end
