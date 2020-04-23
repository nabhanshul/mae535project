function []=add_bh_pt(magname,b,h)

    for i=1:length(b)
            mi_addbhpoint(magname,b(i),h(i));
    end

end
