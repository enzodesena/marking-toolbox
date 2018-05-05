% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_run_feedback(settings_filename, only_student_id)


%% Load coursework variables and marks table
mt_settings = mt_settings_load(settings_filename);
[questions_title, students_data, remarks] = ...
            mt_parsed_data_load(strcat(mt_settings.output_dir, '/_parsed_marks.txt'));

%% Define variables
[num_students, num_questions] = size(remarks);

%% Run reports
if nargin == 2 % If selected a specific student
    num_students = 1;
    students_data = students_data(only_student_id,:);
    remarks = remarks(only_student_id,:);
end

marks = nan(num_students, 1);
penalties = nan(num_students, num_questions);
for student_id = 1:num_students % First row is variable names
    student_data = mt_create_student_struct(students_data(student_id, :));
    student_remarks = remarks(student_id, :);
    
    % Run student report
    [marks(student_id), penalties(student_id,:)] = ...
        mt_run_student(student_data, student_remarks, ...
                       questions_title, mt_settings);
end

                            
end

