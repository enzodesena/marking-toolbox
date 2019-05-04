% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_run_student(student_data, mark, overall_remarks, ...
                        questions_title, questions_remarks, mt_settings)
student_filepath = mt_filepath(mt_settings.output_dir, student_data);


if mt_settings.generate_pdf
    % Generate latex file and write it out
    latex = mt_generate_tex(student_data, mark, overall_remarks, ...
                            questions_title, questions_remarks, ...
                            mt_settings);
    mt_write_text_file(student_filepath + '.tex', latex);

    % Create pdf file
    command_compile = char(strcat(mt_settings.pdflatex_filename, {' '}, ...
                 {'-output-directory '}, mt_settings.output_dir, {' '}, ...
                 student_filepath, '.tex'));
    system(command_compile);
    system(command_compile); % Render references

    % Delete temporary files
    system(char(strcat({'rm '}, student_filepath, '.aux')));
    system(char(strcat({'rm '}, student_filepath, '.log')));
    system(char(strcat({'rm '}, student_filepath, '.out')));
end

%% Create email
if mt_settings.send_emails
    email = mt_generate_email(student_data, mark, mt_settings);
    mt_write_text_file(student_filepath + '.txt', email);
    
    if mt_settings.generate_pdf
        attachment = strcat(pwd, '/', student_filepath, '.pdf');
    else
        attachment = '';
    end
    
    script = mt_generate_applescript(student_data.email, ...
                                     mt_settings.email_subject, ...
                                     email, ...
                                     attachment, ... 
                                     mt_settings);
    mt_write_text_file(student_filepath + '.scpt', script);
end
end
