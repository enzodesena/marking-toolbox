% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_run(settings_filename, only_student_id)


%% Load coursework variables and marks table
mt_settings = mt_settings_load(settings_filename);
[questions_title, students_data, remarks] = ...
            mt_data_load(mt_settings.marks_filename);

%% Define variables
[num_students, num_questions] = size(remarks);

%% Replace macros
if isfield(mt_settings, 'macros') == 1
    remarks = mt_replace_macros(remarks, mt_settings.macros);
end

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

text = mt_generate_marks_table(marks, penalties, students_data, remarks, ...
                               questions_title, mt_settings);     
mt_check_warnings(text);
mt_write_text_file(strcat(mt_settings.output_dir, '/_rendered_marks.txt'), text);

                            
%% Display info
display(newline);
display(strcat('Number of students: ', num2str(num_students)));
display(strcat('Number of questions/points: ', num2str(num_questions)));
display(strcat('Average mark: ', num2str(mean(marks))));
display(strcat('Median mark: ', num2str(median(marks))));
display(strcat('Standard deviation: ', num2str(std(marks))));
display(strcat('Max mark: ', num2str(max(marks))));
display(strcat('Min mark: ', num2str(min(marks))));

end

