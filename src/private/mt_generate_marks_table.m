function [text, statistics] = mt_generate_marks_table(penalties, students_data, students_remarks, ...
                                                      questions_title, mt_settings)

text = "Name" +char(9)+ "Surname" +char(9)+...
    "Student ID" +char(9)+ "Email"+char(9)+...
    "Late submission penalty"+char(9)+...
    "Overall mark (after late submission penalty)"+char(9)+...
    "Raw mark"+char(9)+...
    "Total questions penalty"+char(9)+...
    "Overall remark"+char(9);

for question_id=1:length(questions_title)
    text = text + questions_title{question_id}{1} + char(9) + questions_title{question_id}{1} + " penalty";
    if question_id < length(questions_title)
         text = text + char(9);
    end
end
text = text + newline;

[num_students, num_questions] = size(students_remarks);
for student_id=1:num_students
    student_data = mt_create_student_struct(students_data(student_id,:));
    % Calculate marks
    total_penalty = sum(penalties(student_id,:));
    raw_mark = 100+total_penalty;
    mark_after_late_penalty = raw_mark + student_data.late_submission_penalty;
    
    % Print student data
    text = text + string(strjoin(cellstr(students_data(student_id,1:4)), '\t')) + char(9);
    
    % Print marks
    text = text + num2str(student_data.late_submission_penalty) + char(9);
    text = text + num2str(mark_after_late_penalty) + char(9);
    text = text + num2str(raw_mark) + char(9);
    text = text + num2str(total_penalty) + char(9);
    
    % Print overall remarks
    text = text + mt_overall_remark(raw_mark, student_data.late_submission_penalty, mt_settings) + char(9);
    
    for question_id=1:num_questions
        if isfield(mt_settings, 'message_no_remarks') && ...
           strlength(students_remarks{student_id,question_id}) == 0
            students_remarks{student_id,question_id} = mt_settings.message_no_remarks;
        end
        
        text = text + students_remarks(student_id,question_id) + char(9);
        text = text + penalties(student_id,question_id);
        if question_id < num_questions
         text = text + char(9);
        end
    end
    text = text + newline;
end

statistics = "%% Statistics " + newline;

statistics = statistics + char(9)+char(9)+char(9)+char(9) + ...
    "Average mark: " + char(9) + ...
    "=AVERAGE(F2:F"+ num2str(num_students+1) +")" + newline;

statistics = statistics + char(9)+char(9)+char(9)+char(9) + ...
    "Meadian mark: " + char(9) + ...
    "=MEDIAN(F2:F"+ num2str(num_students+1) +")" + newline;

statistics = statistics + char(9)+char(9)+char(9)+char(9) + ...
    "Standard deviation: " + char(9) + ...
    "=STDEV(F2:F"+ num2str(num_students+1) +")" + newline;

statistics = statistics + char(9)+char(9)+char(9)+char(9) + ...
    "Max mark: " + char(9) + ...
    "=MAX(F2:F"+ num2str(num_students+1) +")" + newline;


statistics = statistics + char(9)+char(9)+char(9)+char(9) + ...
    "Min mark: " + char(9) + ...
    "=MIN(F2:F"+ num2str(num_students+1) +")" + newline;

