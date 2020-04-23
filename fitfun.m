function [cost] = fitfun(X)

        nd_t=X(1);
        nd_h=X(2);
        al_w=X(3);
        p_h=X(4);
        c_t=X(5);
        c_h=X(6);
        wp_w=X(7);
        wp_h=X(8);

        alnicost = 2*50*al_w*14*(1);
        ndccost= nd_h*50*10*(1);
        ndscost = 2*nd_h*50*nd_t*(1);
        wpcost = 50*wp_w*wp_h*(1);
        polecost = 2*50*50*p_h*(1);
        casecost = (2*50*c_t*c_h + (50*(c_h-p_h-14)*(110+2*nd_t)))*(1);
        
        cost = alnicost + ndccost + ndscost + wpcost + polecost + casecost;
        
end
