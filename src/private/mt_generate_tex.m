% Generate marks and latex feedback for coursework
% 
% Marking Toolbox
% Copyright Enzo De Sena 2017

function tex = mt_generate_tex(student_data, mark, overall_remarks, ...
                               questions_title, questions_remarks, ...
                               mt_settings)

%% Read template
tex = fileread(mt_settings.tex_template_filename);

%% Change template title
tex = strrep(tex, 'MT_DOCUMENT_TITLE', ...
                            mt_settings.feedback_title);
tex = strrep(tex, 'MT_STUDENT_NAME', student_data.name);
tex = strrep(tex, 'MT_STUDENT_SURNAME', student_data.surname);
tex = strrep(tex, 'MT_STUDENT_MARK', num2str(mark));
tex = strrep(tex, 'MT_OVERALL_REMARK', overall_remarks);

tex_rmks = string;

num_questions = length(questions_title);
assert(length(questions_remarks) == num_questions);

for i = 1:num_questions
    questions_remarks{i} = strrep(questions_remarks{i}, '\n', newline);
    if strlength(questions_remarks{i})>0
        tex_rmks = tex_rmks + '\section*{' + questions_title{i} + '}' + newline;
        
        if isfield(mt_settings, 'tex_section_preamble') == 1
            tex_rmks = tex_rmks + mt_settings.tex_section_preamble;
        end
        
        tex_rmks = tex_rmks + questions_remarks{i} + newline + newline;
        
        if isfield(mt_settings, 'tex_section_postamble') == 1
            tex_rmks = tex_rmks + mt_settings.tex_section_postamble;
        end
    end
end

tex = strrep(tex, 'MT_QUESTIONS_REMARKS', tex_rmks);

end
