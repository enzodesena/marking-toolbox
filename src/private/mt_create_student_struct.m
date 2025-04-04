% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017-2025

function student_data = mt_create_student_struct(student_data_cell)
student_data = struct;
student_data.name = student_data_cell{1};
student_data.surname = student_data_cell{2};
student_data.urn = str2double(student_data_cell{3});
student_data.email = student_data_cell{4};
student_data.late_submission_penalty = str2double(student_data_cell{5});
student_data.output_filename = student_data_cell{6};
end
