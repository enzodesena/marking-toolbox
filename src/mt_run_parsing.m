% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_run_parsing(settings_filename)


%% Load coursework variables and marks table
mt_settings = mt_settings_load(settings_filename);
[questions_title, students_data, remarks] = ...
            mt_load_raw_data(mt_settings.marks_filename);

        
%% Create output directory, if it doesn't exist already
if exist(mt_settings.output_dir, 'dir') ~= 7
    mkdir(mt_settings.output_dir);
end
        
%% Define variables
[num_students, num_questions] = size(remarks);

%% Replace macros
if isfield(mt_settings, 'macros') == 1
    remarks = mt_replace_macros(remarks, mt_settings.macros);
end

%% Run reports
penalties = nan(num_students, num_questions);
for student_id = 1:num_students % First row is variable names
    student_data = mt_create_student_struct(students_data(student_id, :));
    
    student_filepath = mt_filepath(mt_settings.output_dir, student_data);

    %% Parse marks
    [penalties(student_id, :), remarks(student_id, :), log] = ...
            mt_parse_questions_remarks(remarks(student_id, :), questions_title, mt_settings);

    %% Write out log text file
    mt_write_text_file(student_filepath + '.log', log);
end

[text, statistics] = mt_generate_marks_table(penalties, students_data, remarks, ...
                                             questions_title, mt_settings);

mt_check_warnings(text);
parsed_filename = strcat(mt_settings.output_dir, '/_parsed_marks.txt');
mt_write_text_file(parsed_filename, text + statistics);


%% Display info
disp('Parsing finished!');
disp(strcat('Number of students: ', num2str(num_students)));
disp(strcat('Number of questions: ', num2str(num_questions)));
disp(' ');
disp(strcat('The output spreadsheet can be found at:', parsed_filename));
disp('If you dont need to modify anything there, you can now run');
disp(strcat('mt_run_feedback(''',settings_filename,''')'));
end

