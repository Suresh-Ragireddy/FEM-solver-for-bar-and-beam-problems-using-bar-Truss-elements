function [element_numbers,interpolating_functions,ranges,u_prime_values] = uprime(u_nodes,X_nodes,P,e,S)
syms x
ndofel = P+1;
u_nodes =  u_nodes';
X_nodes = X_nodes';

% Initialize storage for table contents
element_numbers = (1:e)';
interpolating_functions = cell(e, 1);
ranges = cell(e, 1);


i =1;
% Initialize storage for u' values
u_prime_values = zeros(S,1)';
index =1;

for element = 1:ndofel-1:S-1

    start_index = element;
    end_index = element + ndofel-1;
    x_node_loc = X_nodes(start_index:end_index); % Extract node locations for the current element
    u_node_value = u_nodes(start_index:end_index); % Extract node values for the current element
    
    % Perform Lagrange interpolation (assuming you have a function that does this)
    [~, Lagrange_polynomial] = lagrange_interpolation(ndofel, x_node_loc, u_node_value);
    
    % Derive u' from the Lagrange polynomial
    Lagrange_derivative = diff(Lagrange_polynomial, x);
    
    % Evaluate u' at all nodal points within the element's range except for the last point
    for xi = x_node_loc(1:end-1)
        u_prime_value = double(subs(Lagrange_derivative, x, xi));
        u_prime_values(index) = u_prime_value;
        index = index+1;
    end

    if e == i
        u_prime_values(end) = double(subs(Lagrange_derivative, x, X_nodes(end)));
    end


    % Store the results
    interpolating_functions{i} = char(Lagrange_polynomial);
    ranges{i} = sprintf('[%g, %g]', x_node_loc(1), x_node_loc(end));

    i = i+1;
end

end