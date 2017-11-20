function remark = mt_overall_remark(mark, mt_settings)

[num_levels, ~] = size(mt_settings.overall_remarks);

for n=1:num_levels
    if mark >= str2double(mt_settings.overall_remarks{n, 1}) && ...
       mark <= str2double(mt_settings.overall_remarks{n, 2})
        remark = mt_settings.overall_remarks{n, 3};
    end
end