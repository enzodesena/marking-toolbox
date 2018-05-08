% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_run_feedback(settings_filename, only_student_id)


%% Load coursework variables and marks table
mt_settings = mt_settings_load(settings_filename);
[students_data, final_mark, overall_remarks, questions_title, remarks] = ...
        mt_load_parsed_data(strcat(mt_settings.output_dir, '/_parsed_marks.txt'));

%% Define variables
[num_students, ~] = size(remarks);

%% Run reports
if nargin == 2 % If selected a specific student
    num_students = 1;
    students_data = students_data(only_student_id,:);
    final_mark = final_mark(only_student_id);
    overall_remarks = overall_remarks(only_student_id);
    remarks = remarks(only_student_id,:);
end

for student_id = 1:num_students
    student_data = mt_create_student_struct(students_data(student_id, :));
    % Run student report
    mt_run_student(student_data, final_mark(student_id), ...
                   overall_remarks{student_id}, questions_title, ...
                   remarks(student_id, :), mt_settings)        
end

                            
end

