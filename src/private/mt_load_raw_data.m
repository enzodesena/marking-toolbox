% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [questions_title, students_data, remarks] = ...
            mt_load_raw_data(data_filename)

data = mt_load_data(data_filename, '\r');

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
questions_title = data(1,6:end);
% First five columns: name, surname, URN, email, # days delay
students_data = strtrim(data(2:end,1:5));
remarks = data(2:end,6:end);

