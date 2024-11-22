function [index, is_on_node] = check_location(location, type, x0, xL, e)
    x_vector = GlobalLocationBeam(x0, xL, e);
    is_on_node = any(abs(x_vector - location) < eps); % Check if on node
    if is_on_node
        index = find(abs(x_vector - location) < eps); % Find index of the node
        disp([type, ' location is on node at index ', num2str(index), '.']);
    else
        index = [];
        disp([type, ' location is not on a node.']);
     
    end
end