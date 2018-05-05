% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [students_data, final_mark, overall_remarks, questions_title, remarks] = ...
        mt_load_parsed_data(data_filename)

data = mt_load_data(data_filename, newline);



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

%% Convert to string
questions_columns = data(1,10:end);
% check that for each question there is a penalty column
assert(rem(length(questions_columns),2)==0); 
questions_title = questions_columns(1:2:end);

% First five columns: name, surname, URN, email, # days delay
students_data = strtrim(data(2:end,1:5));
final_mark = str2double(data(2:end,6));
overall_remarks = data(2:end, 9);
remarks = data(2:end,10:2:end);
