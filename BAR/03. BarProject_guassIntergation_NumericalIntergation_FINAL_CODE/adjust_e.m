function [incremented_e, decremented_e,valuePL] = adjust_e(x_vector,P, x0, x1, F_location, e)
    %h = (x1 - x0) / e;
    %x_vector = x0:(h / P):x1; formula i am using

    if any(x_vector == F_location)
        disp('F_location is present in x_vector.');
        incremented_e = 0;
        decremented_e = 0;
        valuePL = 1;
    else
        disp('For given Point load location and element number Their is No nodal point to keep Point load');
        disp("Instead Try adjusted Element value given below");
        disp("--------------------------------------------------------------------------------------------");
        e_adjusted = e;
        e_increment = 1; % small increment or decrement value for n
        valuePL = 2;


        found_incremented = false;
        found_decremented = false;

        while ~(found_incremented && found_decremented)
            % Increment e
            e_incremented = e_adjusted + e_increment;
            h_incremented = (x1 - x0) / e_incremented;
            x_vector_incremented = x0:(h_incremented / P):x1;

            % Check if F_location is present in the incremented x_vector
            if any(x_vector_incremented == F_location)
                found_incremented = true;
                disp(['Incremented e value: ', num2str(e_incremented)]);
                incremented_e = e_incremented;
            end

            % Decrement n
            e_decremented = e_adjusted - e_increment;
            h_decremented = (x1 - x0) / e_decremented;
            x_vector_decremented = x0:(h_decremented / P):x1;

            % Check if F_location is present in the decremented x_vector
            if any(x_vector_decremented == F_location)
                found_decremented = true;
                disp(['Decremented e value: ', num2str(e_decremented)]);
                decremented_e = e_decremented;
            end

            % If F_location is not found for either increment or decrement, update n_adjusted for next iteration
            if ~(found_incremented && found_decremented)
                e_adjusted = e_adjusted + e_increment;
            end
        end

        if ~(found_incremented || found_decremented)
            disp('F_location is not present in x_vector for both incremented and decremented e values.');
            incremented_e = 0;
            decremented_e = 0;
        end
    end
end