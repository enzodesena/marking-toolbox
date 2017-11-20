% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [questions_title, students_data, remarks] = ...
            mt_data_load(data_filename)

assert(exist(data_filename,'file') == 2, ...
       strcat('File not found: ',data_filename));
% load(data_filename); % Load
% data = tdfread(data_filename);
data_text = fileread(data_filename);
data_in_rows = strsplit(data_text,'\r');

num_rows = length(data_in_rows);
assert(num_rows>1, 'There should be at least one line of data after the first');
data_first_row = strsplit(data_in_rows{1},'\t','CollapseDelimiters',0);
num_columns = length(data_first_row);
data = cell(num_rows, num_columns);
data(1,:) = data_first_row;

for n=2:num_rows
    data(n,:) = strsplit(data_in_rows{n},'\t','CollapseDelimiters',0);
end

%% Read first row
assert(strcmp(data{1,1}, 'Name'), ...
  'The first element of the first row should be Name');
assert(strcmp(data{1,2}, 'Surname'), ...
  'The second element of the first row should be Surname');
assert(strcmp(data{1,3}, 'URN'), ...
  'The third element of the first row should be URN');
assert(strcmp(data{1,4}, 'Email'), ...
  'The fourth element of the first row should be Email');
assert(strcmp(data{1,5}, 'Days of delay'), ...
  'The fifth element of the first row should be Days of delay');

%% Convert to string
[N, K] = size(data);

for n=1:N
    for k=1:K
        data{n,k} = strrep(string(data{n,k}), '"', '');
    end
end

questions_title = data(1,6:end);
% First five columns: name, surname, URN, email, # days delay
students_data = data(2:end,1:5);
remarks = data(2:end,6:end);

