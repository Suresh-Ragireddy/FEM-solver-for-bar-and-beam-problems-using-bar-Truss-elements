function [shap,ddshap]  = Hermitecubicshapefunctions(xi_loc,h)
    % Define symbolic variables
    syms xi real;
    
    % Define the linear mapping from the master element to the physical element
    % x = a*xi + b, where a = h/2 and b = (x1 + xk)/2
    % This is derived from the linear interpolation between the endpoints of the element.
    
    shap = sym(zeros(4,1));
    ddshap = sym(zeros(4,1));
    % Define the Hermite shape functions in terms of natural coordinate xi
    N1_xi = 1 - 3/4*(1 + xi)^2 + 1/4*(1 + xi)^3;
    N2_xi = h/8 * ((1 + xi)*(xi - 1)^2);
    N3_xi = 3/4*(1 + xi)^2 - 1/4*(1 + xi)^3;
    N4_xi = h/8 * ((xi - 1)*(xi + 1)^2);

    shap(1) =  N1_xi; 
    shap(2) =  N2_xi;
    shap(3) =  N3_xi; 
    shap(4) =  N4_xi; 
    
    % % First derivative
    % dN1_xi = (3*(xi + 1)^2)/4 - (3*xi)/2 - 3/2;
    % dN2_xi = (h*(xi - 1)^2)/8 + (h*(2*xi - 2)*(xi + 1))/8;
    % dN3_xi  = (3*xi)/2 - (3*(xi + 1)^2)/4 + 3/2;
    % dN4_xi  = (h*(xi + 1)^2)/8 + (h*(2*xi + 2)*(xi - 1))/8;
    % 
    % Second derivative
    ddN1_xi = (3*xi)/2;
    ddN2_xi = (h*(xi + 1))/4 + (h*(2*xi - 2))/4;
    ddN3_xi = -(3*xi)/2;
    ddN4_xi = (h*(xi - 1))/4 + (h*(2*xi + 2))/4;

    ddshap(1) =  ddN1_xi ;
    ddshap(2) =  ddN2_xi ;
    ddshap(3) =  ddN3_xi ;
    ddshap(4) =  ddN4_xi ;

    shap = double(subs(shap,xi,xi_loc));
    ddshap = double(subs(ddshap,xi,xi_loc));
end