% Check for possible problems in the final table.
% 
% Marking Toolbox
% Copyright Enzo De Sena 2018

function mt_check_warnings(text)


%% Check if there are long runs of capital letters (possible unreplaced macros).
max_capital_run = 3; % Edit if you want

capital_letters = isstrprop(text, 'upper');
[run_length, run_initial_position] = mt_run_length(capital_letters);

if run_length > max_capital_run
    warning(char("There are some runs of capital letters longer than " + ...
        num2str(max_capital_run) + " characters. This may mean there are " +...
        "unreplaced macros. One way this can happen is if you make a " + ...
        "mistake in writing the macro. Another, more unexpected way " + ...
        "is when two macro keywords contain parts of each other, " + ...
        "e.g. NONEEDSIGFIG and SIGFIG. In case this happens, you should " +...
        "reorder the macros so that the longer one appears first. " + ...
        "The longest run of capital letters is: '" + ...
         extractBetween(text,run_initial_position, run_initial_position+run_length-1) + ...
         "'."));
end

warning_message = "There is at least one word similar to the word 'penalty', " + ...
        "which may mean that you made a mistake in writing it, and " + ...
        "thus that it did not get recognised by the system and counted " + ...
        "towards the student mark: ";
    
if contains(text, 'penatly')
    warning(strcat(warning_message, 'penatly'));
if contains(text, 'penaly')
    warning(strcat(warning_message, 'penaly'));
end
if contains(text, 'penaty')
    warning(strcat(warning_message, 'penaty'));
end
if contains(text, 'pnalty')
    warning(strcat(warning_message, 'pnalty'));
end
if contains(text, 'pealty')
    warning(strcat(warning_message, 'pealty'));
end
if contains(text, 'peanlty')
    warning(strcat(warning_message, 'peanlty'));
end
if contains(text, 'penalyt')
    warning(strcat(warning_message, 'penalyt'));
end
if contains(text, 'pnealty')
    warning(strcat(warning_message, 'pnealty'));
end
end

function [len_max, run_initial_position] = mt_run_length(vector)
len_max = 1;
run_length = 1;
run_initial_position = 1;
for n = 2:numel(vector)
    if vector(n) == vector(n-1) && vector(n) == 1
        run_length = run_length+1;
    else
        if run_length > len_max
            run_initial_position = n-run_length;
            len_max = run_length;
        end
        run_length = 1;
    end
end
