% Generate late submission message and penalty (edit this file to suit your
% marking rules)
% 
% Marking Toolbox
% Copyright Enzo De Sena 2018

function [penalty, late_message] = ....
    mt_late_submission(days_of_delay, mt_settings)

if days_of_delay == 0
    penalty = 0;
    late_message = "";
else 
    % The variable penalty_per_day_of_delay is a negative number, so also 
    % penalty will be negative
    penalty = days_of_delay*mt_settings.penalty_per_day_of_delay; 
    
    if days_of_delay == 1
        days = "day";
    else 
        days = "days";
    end
    
    late_message = "Your coursework was submitted " + num2str(days_of_delay) + " " + ...
        days + " late and thus it incurred a~$" + num2str(penalty) +...
        "$\% penalty (this penalty is already included in the overall mark above). ";
end