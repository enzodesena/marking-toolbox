%% Defitions
mt_settings = struct();

%% Common mistakes
mt_settings.macros = {'P11_GEQ', 'Hello GEQ: [penalty:-5] [solution]\n\n';
                      'P11_OTH', 'Hellao OTH: [penalty:+5]\n\n'};

mt_settings.overall_remarks = {'100', '100', 'Your coursework is flawless.';
  '80', '99', 'Your coursework is excellent.';
  '70', '79', 'Your coursework is very good.';
  '60', '69', 'Your coursework is good.';
  '56', '59', 'Your coursework is ok.';
  '0', '55', 'Your coursework could be better. Please carefully revise this feedback, and arrange a tutorial with me so we can go over the coursework together.'};
                  
%% Directories and filenames
mt_settings.output_dir = 'outputs';
mt_settings.solution_tex_dir = 'solution_tex';
mt_settings.solution_message = 'Please see the correct solution below. \n\n';
mt_settings.feedback_template_filename = 'feedback_template.tex';
mt_settings.marks_filename = 'Workbook1.txt';
mt_settings.pdflatex_filename = '/Library/TeX/texbin/pdflatex';

%% Feedback settings
mt_settings.remove_penalty_from_text = true;
mt_settings.feedback_title = 'Feedback of ASP coursework 1';
mt_settings.message_no_remarks = 'This question was completed correctly.';

%% Email settings
mt_settings.send_emails = true;
mt_settings.email_subject = mt_settings.feedback_title;
mt_settings.email_template = 'email_template.txt';
mt_settings.feedback_description = ...
            'the first coursework of the Sound Synthesis module';

mt_settings.sender_email = 'Enzo De Sena <ed0018@surrey.ac.uk>';
mt_settings.email_appears_in_mac_mail = 'true';
mt_settings.send_email_automatically = 'false';
mt_settings.drive_name = 'Macintosh HD'; % TODO: extract this info automatically

