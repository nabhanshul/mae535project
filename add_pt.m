function [point] =add_pt(x,y)
    mi_addnode(x,y);
    
    for i=1:(length(x)-1)
        mi_addsegment(x(i),y(i),x(i+1),y(i+1));
    end
    
end
