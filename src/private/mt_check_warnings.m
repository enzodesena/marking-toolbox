% Check for possible problems in the final table.
% 
% Marking Toolbox
% Copyright Enzo De Sena 2018

function mt_check_warnings(text)


%% Check if there are long runs of capital letters (possible unreplaced macros).
max_capital_run = 3; % Edit if you want


strings_above_max_capital_run = mt_run_length(text, max_capital_run);

if ~isempty(strings_above_max_capital_run)
    strings_together = '';
    for n=1:length(strings_above_max_capital_run)
        strings_together = strcat(strings_together, " '", strings_above_max_capital_run{n},"'");
    end
    warning(char("There are some runs of capital letters longer than " + ...
        num2str(max_capital_run) + " characters. This may mean there are " +...
        "unreplaced macros. One way this can happen is if you make a " + ...
        "mistake in writing the macro. Another, more unexpected way " + ...
        "is when two macro keywords contain parts of each other, " + ...
        "e.g. NONEEDSIGFIG and SIGFIG. In case this happens, you should " +...
        "reorder the macros so that the longer one appears first. " + ...
        "These are the detected runs of capital letters: " + strings_together));
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

function unique_strings = mt_run_length(text, max_capital_run)

capital_letters = isstrprop(text, 'upper');

strings = {};


run_length = 0;
for n = 1:numel(capital_letters)
    if run_length > 0 && (capital_letters(n) == 0 || n == numel(capital_letters)) % run ended
        if run_length > max_capital_run
            strings{end+1} = extractBetween(text, start_of_run, start_of_run + run_length -1);
        end
        run_length = 0;
        start_of_run = nan;
        continue;
    end
    
    if capital_letters(n) == 1
        if run_length == 0
            start_of_run = n;
        end
        run_length = run_length + 1;
    end
end

unique_strings = {};

for n=1:length(strings)
    if ~is_string_in_cell_array(strings{n}, unique_strings)
        unique_strings{end+1} = strings{n};
    end
end



function result = is_string_in_cell_array(string, cell_array)
for n=1:length(cell_array)
    if strcmp(string, cell_array{n})
        result = true;
        return;
    end
end
result = false;