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
[~, students_data, ~] = mt_data_load(mt_settings.marks_filename);
        
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
    assert(exist(student_filepath + '.pdf','file') == 2, 'File not found');
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
%     mt_send_email(student_data.email, mt_settings.email_subject,...
%                   message, student_filepath + '.pdf', ...
%                   mt_settings);
end

disp('All emails sent.');

end

function mt_send_email(address, subject, message, attachment, mt_settings)
% Define these variables appropriately:
mail = 'e.desena@surrey.ac.uk'; %Your GMail email address
password = 'p4pp0nE84752'; %Your GMail password

% Then this code will set up the preferences properly:
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.office365.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.starttls.enable', 'true');
props.setProperty('mail.smtp.socketFactory.fallback', 'true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','587');

props.setProperty('mail.smtp.host', 'smtp.office365.com');
props.setProperty('mail.smtp.port', '587');
props.setProperty('mail.smtp.auth', 'true');
props.setProperty('mail.smtp.user', mail);
props.setProperty('mail.smtp.starttls.enable', 'true');
props.setProperty('mail.transport.protocol', 'smtps');

% Send the email
sendmail(address,subject,message)

end