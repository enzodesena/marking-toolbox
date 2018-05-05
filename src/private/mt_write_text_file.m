% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_write_text_file(filename, data)
fid = fopen(filename,'wt');
fprintf(fid, '%s', data);
fclose(fid);
end