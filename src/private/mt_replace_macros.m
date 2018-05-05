% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function marks = mt_replace_macros(marks, macros)

[num_macros, ~] = size(macros);
[N, K] = size(marks);

for n=1:N
    for k=1:K
        for macro_id = 1:num_macros
            marks{n,k} = strrep(marks{n,k}, macros{macro_id, 1}, ...
                                            macros{macro_id, 2});
        end
    end
end

