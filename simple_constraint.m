function [c, ceq] = simple_constraint(X)
    nd_t=X(1);
    nd_h=X(2);
    al_w=X(3);
    p_h=X(4);
    c_t=X(5);
    c_h=X(6);
    wp_w=X(7);
    wp_h=X(8);

   force1 = abs(draw1(X));
   c=6650-force1
   
   ceq = [];
end