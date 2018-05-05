% Generate marks and latex feedback for coursework
% 
% Marking Matlab Toolbox
% Copyright Enzo De Sena 2017

function out = mt_char_is_num(ch)
if ch == '1' || ch == '2' || ch == '3' || ch == '4' || ch == '5' || ...
   ch == '6' || ch == '7' || ch == '8' || ch == '9' || ch == '0'
     out = true;
else
    out = false;
end

end
