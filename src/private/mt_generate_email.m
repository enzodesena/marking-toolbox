% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function email = mt_generate_email(student_data, mark, mt_settings)

%% Read template
email = fileread(mt_settings.email_template);

%% Change template title
email = strrep(email, 'MT_STUDENT_NAME', student_data.name);
email = strrep(email, 'MT_FEEDBACK_DESCRIPTION', ...
                       mt_settings.feedback_description);
email = strrep(email, 'MT_STUDENT_MARK', num2str(mark));

end