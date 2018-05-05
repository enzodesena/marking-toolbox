% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function data = mt_data_load(data_filename, row_delimiter)

assert(exist(data_filename,'file') == 2, ...
       strcat('File not found: ',data_filename));
   
data_text = fileread(data_filename);
data_in_rows = strsplit(data_text,row_delimiter);

num_rows = length(data_in_rows);
assert(num_rows>1, 'There should be at least one line of data after the first');
data_first_row = strsplit(data_in_rows{1},'\t','CollapseDelimiters',0);
num_columns = length(data_first_row);

%% Strip anything after the symbol %%
N = length(data_in_rows);
num_rows = N;
for n=1:N
    if length(data_in_rows{n}) >=2 && strcmp(data_in_rows{n}(1:2), '%%') 
        num_rows = n-1;
        break;
    end
end

data = cell(num_rows, num_columns);
data(1,:) = data_first_row;

for n=2:num_rows
    data(n,:) = strsplit(data_in_rows{n},'\t','CollapseDelimiters',0)
end

%% Convert to string
[N, K] = size(data);

for n=1:N
    for k=1:K
        data{n,k} = strrep(string(data{n,k}), '"', '');
        data{n,k} = strrep(string(data{n,k}), newline, '');
    end
end




