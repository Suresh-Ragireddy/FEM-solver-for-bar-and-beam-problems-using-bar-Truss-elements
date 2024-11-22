function [indices, are_on_nodes] = check_both_locations(P_loc, M_loc, x0, xL, e)
    x_vector = GlobalLocationBeam(x0, xL, e);
    P_on_node = any(abs(x_vector - P_loc) < eps);
    M_on_node = any(abs(x_vector - M_loc) < eps);
    indices = zeros(1,2);
    are_on_nodes = [P_on_node, M_on_node];

    if P_on_node
        indices(1) = find(abs(x_vector - P_loc) < eps);
    end
    if M_on_node
        indices(2) = find(abs(x_vector - M_loc) < eps);
    end

    if all(are_on_nodes)
        disp('Both Point Load and Moment locations are on nodes.');
    else
        disp('One or neither of the Point Load and Moment locations are on nodes.');
    end
end