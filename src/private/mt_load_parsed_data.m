% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [students_data, final_mark, overall_remarks, questions_title, remarks] = ...
        mt_load_parsed_data(data_filename)

data = mt_load_data(data_filename, newline);
[num_rows, ~] = size(data);
num_students = num_rows - 1; % The first row is for headers

%% Read first row
assert(strcmp(data{1,1}, 'Name'), ...
  'The first element of the first row should be Name');
assert(strcmp(data{1,2}, 'Surname'), ...
  'The second element of the first row should be Surname');
assert(strcmp(data{1,3}, 'Student ID'), ...
  'The third element of the first row should be Student ID');
assert(strcmp(data{1,4}, 'Email'), ...
  'The fourth element of the first row should be Email');
assert(strcmp(data{1,5}, 'Late submission penalty'), ...
  'The fifth element of the first row should be Late submission penalty');
assert(strcmp(data{1,6}, 'Output filename'), ...
  'The sixth element of the first row should be Output filename. The contents of that columns should not include the file extension.');


%% Convert to string
questions_columns = data(1,11:end);
% check that for each question there is a penalty column
assert(rem(length(questions_columns),2)==0); 
questions_title = questions_columns(1:2:end);

% First five columns: name, surname, URN, email, # days delay
students_data = strtrim(data(2:end,1:6));
for n=1:num_students
    final_mark(n) = str2double(data{n+1,7});
end
overall_remarks = data(2:end, 10);
remarks = data(2:end,11:2:end);
