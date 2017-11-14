function filepath = mt_filepath(directory, student_data);

name = strrep(student_data.name, ' ', '');
surname = strrep(student_data.surname, ' ', '');
filename = strcat(name, surname);

% TODO: implement for windows
filepath = strcat(directory, '/', filename);