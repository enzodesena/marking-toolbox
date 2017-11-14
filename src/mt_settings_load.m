% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function mt_settings = mt_settings_load(settings_filename)

assert(exist(settings_filename,'file') == 2, ...
        'Settings file not found' );
run(settings_filename) % Load settings
assert(exist('mt_settings', 'var') == 1, ...
        'File coursework_variables does not contain variable mt_settings');

[~, M] = size(mt_settings.macros);
assert(M==2, 'The macros variable has more than 2 columns');