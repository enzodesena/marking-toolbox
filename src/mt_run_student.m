% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mark = mt_run_student(student_data, student_marks, ...
                               questions_title, mt_settings)
student_filepath = mt_filepath(mt_settings.output_dir, student_data);

%% Parse marks
[penalties, questions_remarks, log] = ...
        mt_parse_questions_remarks(student_marks, mt_settings);

%% Write out log text file
mt_write_text_file(student_filepath + '.txt', log);

%% Calculate student final mark
% We are adding the penalty because the convention used throughout the
% toolbox is that penalty values are negative, i.e. if penalties = -5
% we are subtracting 5 points from the final mark
mark = mt_settings.initial_mark + sum(penalties) + ...
       mt_settings.penalty_per_day_of_delay*student_data.days_of_delay;

%% Generate latex file and write it out
latex = mt_generate_student_report(student_data, ... 
                                   questions_title, ...
                                   questions_remarks,...
                                   mark, ...
                                   mt_settings);
mt_write_text_file(student_filepath + '.tex', latex);

%% Create pdf file
command_compile = char(strcat(mt_settings.pdflatex_filename, {' '}, ...
             {'-output-directory '}, mt_settings.output_dir, {' '}, ...
             student_filepath, '.tex'));
system(command_compile);

%% Delete temporary files
system(char(strcat({'rm '}, student_filepath, '.aux')));
system(char(strcat({'rm '}, student_filepath, '.log')));
system(char(strcat({'rm '}, student_filepath, '.out')));
system(char(strcat({'rm '}, student_filepath, '.tex')));

