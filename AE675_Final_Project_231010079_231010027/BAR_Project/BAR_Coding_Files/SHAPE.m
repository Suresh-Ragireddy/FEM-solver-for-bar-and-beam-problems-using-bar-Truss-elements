function [ndofel,shap,dshap] = SHAPE(P,xi_loc)

    % Define the polynomial degree P
    
    % Calculate the number of points
    ndofel = P + 1;
    
    syms xi;
    xs = sym('xi', [1 ndofel]);
    
    % Here L is the Numerator differentation of shape function
    L = sym(zeros(ndofel, 1));

    for i = 1:ndofel
        product = 0; % Initialize the product for the current basis function
        
        % Generate the product terms
        for j = 1:ndofel
            if j ~= i
                term = 1; % Initialize the term for the current product term
                
                % Generate the current product term
                for k = 1:ndofel
                    if k ~= i && k ~= j
                        term = term * (xi - xs(k));
                    end
                end
                
                product = product + term;
            end
        end
        
        % Add the current basis function to the Lagrange basis functions vector
        L(i) = product;
    end
    

    shap = sym(zeros(ndofel,1));
    dshap = sym(zeros(ndofel,1));
    
    % Generating Lagrange interpolating polynomial
    for j = 1:ndofel
        % Compute the product term for each j
        product_term = 1;
        deno = 1;
        for k = 1:ndofel
            if k ~= j
                product_term = product_term * (xi - xs(k)) / (xs(j) - xs(k));
                deno = deno * 1 / (xs(j) - xs(k));
            end
        end 
        shap(j)= product_term;
        dshap(j) = deno*L(j);
    end
    
    
    x_Loc = zeros(1,ndofel);
    for i = 1:ndofel
        x_Loc(i) = -1 + (i-1)*(2/P);
    end
    
    shap = subs(shap,xs,x_Loc);
    dshap = subs(dshap,xs,x_Loc);

    x_Loc = zeros(1,ndofel);
    for i = 1:ndofel
        x_Loc(i) = -1 + (i-1)*(2/P);
    end
    
    shap = subs(shap,xs,x_Loc);
    dshap = subs(dshap,xs,x_Loc);

    % substuting xi value and Transforming from column vector to row vector

    shap = double(subs(shap,xi,xi_loc))';
    dshap = double(subs(dshap,xi,xi_loc))';

end