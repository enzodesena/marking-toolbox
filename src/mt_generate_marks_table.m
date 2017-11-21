function text = mt_generate_marks_table(marks, penalties, students_data, students_remarks, ...
                                         questions_title, mt_settings)

text = "Name" +char(9)+ "Surname" +char(9)+...
    "URN" +char(9)+ "Email" +char(9)+ "Days of delay" +char(9) + "Mark" + char(9);

for question_id=1:length(questions_title)
    text = text + questions_title{question_id}{1} + char(9) + questions_title{question_id}{1} + " penalty" + char(9);
end
text = text + newline;

[num_students, num_questions] = size(students_remarks);
for student_id=1:num_students
    text = text + string(strjoin(cellstr(students_data(student_id,:)), '\t')) + char(9);
    text = text + num2str(marks(student_id)) + char(9);
    for question_id=1:num_questions
        text = text + students_remarks(student_id,question_id) + char(9);
        text = text + penalties(student_id,question_id) + char(9);
    end
    text = text + newline;
end
