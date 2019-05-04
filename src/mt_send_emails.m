% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_send_emails(settings_filename)

%% Checking...
disp('Are you sure you want to send out the emails?');
pause
disp('Sure sure?');
pause

%% Load coursework variables and marks table
mt_settings = mt_settings_load(settings_filename);
[students_data, ~, ~, ~, ~] = ...
        mt_load_parsed_data(strcat(mt_settings.output_dir, '/_parsed_marks.txt'));
        
%% Define variables
[num_students, ~] = size(students_data);

%% Checking all the files are here
disp('Checking all the files are here.');
for student_id = 1:num_students % First row is variable names
    student_data = mt_create_student_struct(students_data(student_id, :));
    
    %% Read email
    student_filepath = mt_filepath(mt_settings.output_dir, student_data);
    assert(exist(student_filepath + '.txt','file') == 2, 'File not found');
    message = fileread(char(student_filepath + '.txt'));
    assert(strlength(message) > 0);
    if mt_settings.generate_pdf
      assert(exist(student_filepath + '.pdf','file') == 2, 'File not found');
    end
end

disp('All files are present.');

%% Send emails
for student_id = 1:num_students % First row is variable names
    student_data = mt_create_student_struct(students_data(student_id, :));
    
    %% Read email
    student_filepath = mt_filepath(mt_settings.output_dir, student_data);
    message = fileread(char(student_filepath + '.txt'));
    
    disp('Sending out email to ' + student_data.name + {' '} + ...
        student_data.surname + {' ('} + student_data.email + ').');
    system(char('cat ' + student_filepath + '.scpt | osascript'));
end

disp('All emails sent.');

end



