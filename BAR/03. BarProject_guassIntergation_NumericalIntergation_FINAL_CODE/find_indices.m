function indices = find_indices(x_vector, F_location)
    for i = 1:length(x_vector)
        if x_vector(i) == F_location
            indices = i;
            break;
        end
    end
end