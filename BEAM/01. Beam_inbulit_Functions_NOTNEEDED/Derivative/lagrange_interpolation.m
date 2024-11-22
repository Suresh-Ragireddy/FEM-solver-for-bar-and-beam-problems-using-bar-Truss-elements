function [L,L_simplified] = lagrange_interpolation(n,x_data, y_data)


    % here L is Lagrange polynomial
    syms x;
    L = 0;   % Initialize Lagrange polynomial
    
    % Creating symbolic variables for y_j and x_j
    y_string = sym('y', [1 n]);  % for Visualizing deriving Formula using symoblic math
    x_string = sym('x', [1 n]);
    
    % Generating Lagrange interpolating polynomial
    for j = 1:n
        % Compute the product term for each j
        product_term = 1;
        for k = 1:n
            if k ~= j
                product_term = product_term * (x - x_string(k)) / (x_string(j) - x_string(k));
            end
        end
    
        % Updating Lagrange polynomial
        L = L + y_string(j) * product_term;
    end

    L_substitute = subs(L, [x_string, y_string], [x_data, y_data]);

    L_simplified = simplify(L_substitute);
end