% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function tex = mt_generate_feedback(student_data, questions_title, ...
                                    questions_remarks, mark, ...
                                    mt_settings)

%% Read template
tex = fileread(mt_settings.feedback_template_filename);

%% Change template title
[~, late_message] = mt_late_submission(student_data.days_of_delay, mt_settings);

tex = strrep(tex, 'MT_DOCUMENT_TITLE', ...
                            mt_settings.feedback_title);
tex = strrep(tex, 'MT_STUDENT_NAME', student_data.name);
tex = strrep(tex, 'MT_STUDENT_SURNAME', student_data.surname);
tex = strrep(tex, 'MT_STUDENT_MARK', num2str(mark));
tex = strrep(tex, 'MT_LATE_REMARK', late_message);
tex = strrep(tex, 'MT_OVERALL_REMARK', mt_overall_remark(mark, mt_settings));

tex_rmks = string;

num_questions = length(questions_title);
assert(length(questions_remarks) == num_questions);

for i = 1:num_questions
    if strlength(questions_remarks{i}) == 0
        questions_remarks{i} = mt_settings.message_no_remarks;
    end
    questions_remarks{i} = strrep(questions_remarks{i}, '\n', newline);
    tex_rmks = tex_rmks + '\section*{' + questions_title{i} + '}' + newline;
    tex_rmks = tex_rmks + questions_remarks{i} + newline + newline;
end

tex = strrep(tex, 'MT_QUESTIONS_REMARKS', tex_rmks);

end
