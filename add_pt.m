function [point] =add_pt(x,y)
    mi_addnode(x,y);
    
    for i=1:(length(x)-1)
        mi_addsegment(x(i),y(i),x(i+1),y(i+1));
    end
%     mi_addsegment(85,36,85,0);
    
%       for i=1:length(x)
%         mi_selectsegment(x(i),y(i));
%         %mi_mirror(85,1,85,2)
%        % mi_mirror(85,0,85,35)
%       end  
    
end
