% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function marks = mt_replace_macros(marks, mt_settings)

[num_macros, ~] = size(mt_settings.macros);
[N, K] = size(marks);

for n=1:N
    for k=1:K
        for macro_id = 1:num_macros
            
            if isfield(mt_settings, 'macro_preamble') == 1 && strlength(mt_settings.macros{macro_id, 2}) > 0
                preamble = mt_settings.macro_preamble;
            else
                preamble = '';
            end
            if isfield(mt_settings, 'macro_postamble') == 1 && strlength(mt_settings.macros{macro_id, 2}) > 0
                postamble = mt_settings.macro_postamble;
            else
                postamble = '';
            end
               
            macro_text = [preamble, mt_settings.macros{macro_id, 2}, postamble];
            
            marks{n,k} = strrep(marks{n,k}, mt_settings.macros{macro_id, 1}, ...
                                            macro_text);
        end
    end
end

