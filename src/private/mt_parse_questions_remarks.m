% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function [penalties, remarks, log] = ...
    mt_parse_questions_remarks(student_marks, questions_title, cw_settings)

%% Check consistency of inputs
[temp, num_questions] = size(student_marks);
assert(temp==1);

%% Define variables
penalties = nan(num_questions, 1);
remarks = cell(num_questions, 1);
log = string; % Initialise log

%% Find penalties
for question_id = 1:num_questions
    remark_str = student_marks{question_id};
    
    [penalties(question_id), remarks{question_id}, question_log] = ...
        mt_parse_question_remarks(remark_str, ...
                                  questions_title{question_id}, ...
                                  cw_settings);
    
    log = log + 'Question id ' + num2str(question_id) + ':' + newline + ...
                 question_log + newline + newline;
end

log = log + 'Total penalty: ' + sum(penalties) + newline;
             
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
