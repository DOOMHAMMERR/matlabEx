function [volume, surf_area] = calcConeVolumeArea(r,h,l)
    r_saured = (r.^2);
    r_saured_h = r_saured .*h;
    volume = (pi * r_saured_h) / 3;
    surf_area = pi .* r_saured + pi .* r .* l;
end