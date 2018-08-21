% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [question_penalty, question_str, log] = ...
                    mt_parse_question_remarks(question_str, question_title, mt_settings)
wrong_format_msg = strcat('Wrong format of penalty, ',...
                          'should be [penalty:-X], [penalty:-XX], ',...
                          '[penalty:+X] or [penalty:+XX]');
log = 'Parsing string ''' + question_str + ''' (length: ' + ...
    num2str(strlength(question_str)) + ' chars)' + newline;

question_penalty = 0;

%% Parse for string (penalty:-XX)
penalties = extractBetween(question_str,"[penalty:","]");  
log = log + 'Found ' + num2str(length(penalties)) + ...
             ' occurrences of [penalty:XXX]: ' + ...
             strjoin(penalties) + newline;

%% Parse each (penalty:-XX) occurrence
for penalty_id = 1:length(penalties)
    penalty_str = penalties{penalty_id};
    
    % Check correct format of string
    assert(strlength(penalty_str)>=2, strcat(wrong_format_msg, '. It is ''', penalty_str, ''''));
    assert(strlength(penalty_str)<=3, strcat(wrong_format_msg, '. It is ''', penalty_str, ''''));
    assert(penalty_str(1) == '+' || penalty_str(1) == '-', wrong_format_msg);
    assert(mt_char_is_num(penalty_str(2)), wrong_format_msg);
    if strlength(penalty_str) == 3
        assert(mt_char_is_num(penalty_str(3)), wrong_format_msg);
    end
    
    % Add penalty to question
    question_penalty = question_penalty + str2double(penalty_str);
end

log = log + 'Total penalty for this question: ' + ...
             num2str(question_penalty) + newline;

%% Remove the penalty from text remark, if needed
if isfield(mt_settings, 'remove_penalty_from_text') && ...
           mt_settings.remove_penalty_from_text
    question_str = replaceBetween(question_str, "[penalty:", "]", '',...
                                  'Boundaries', 'inclusive');
end

%% Replace solution
[question_str, log_sol] = mt_replace_solution(question_str, question_title, mt_settings);
log = log + log_sol;
    

end
