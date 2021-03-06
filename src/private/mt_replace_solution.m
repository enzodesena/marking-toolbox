% Replace solution into tex file
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function [question_str, log_sol] = ...
    mt_replace_solution(question_str, question_title, mt_settings)

solution_needed = strfind(question_str, "[solution]");  
if solution_needed
    assert(isfield(mt_settings, 'solution_tex_dir'), ...
        strcat('A solution has been requested, but the tex directory',...
        ' of solutions hasnt been set. Please add',...
        ' mt_settings.solution_tex_dir to the settings.'));
    
    solution_filename = strrep(question_title, " ", "_");
    solution_filename = strrep(solution_filename, ".", "_");
    solution_filename = strcat(mt_settings.solution_tex_dir, '/',...
        solution_filename, ".tex");
    
    assert(exist(solution_filename,'file') == 2, ...
       char("A solution has been requested for " +  ...
          question_title + " but file " + ...
          solution_filename + " cannot found."));
    
    solution_tex = "\n\n" + mt_settings.solution_message + "\n\n \vspace{10px}\n " + ...
        "\input{../" + solution_filename + "}";
    
    % Remove [solution]
    question_str = question_str + solution_tex;

    question_str = strrep(question_str, "[solution]", ""); 
    
    log_sol = 'Solution is added ' + solution_filename;
else 
    log_sol = 'Solution not needed';
end

