function B = matrixToColumnVector(A)
    % matrixToColumnVector converts a n x 2 matrix into a 2n x 1 column vector.

    % Check if the input matrix A has exactly 2 columns
    if size(A, 2) ~= 2
        error('Input matrix must have exactly 2 columns');
    end

    % Reshape the matrix A to a column vector
    B = reshape(A', [], 1);

    % Optionally, display the output vector
    % disp(B);  % Uncomment this line if you want to display the vector
end