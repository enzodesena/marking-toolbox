% Generate marks and latex feedback for coursework
%
% Marking Toolbox
% Copyright Enzo De Sena 2017-2025

function filepath = mt_filepath(directory, student_data)

% TODO: implement for windows
filepath = strcat(directory, '/', student_data.output_filename)
