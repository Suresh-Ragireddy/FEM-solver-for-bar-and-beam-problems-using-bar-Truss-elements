function A = columnVectorToMatrix(B)
    % columnVectorToMatrix converts a 2n x 1 column vector into a n x 2 matrix.

    % Check if the length of vector B is even
    if mod(length(B), 2) ~= 0
        error('Length of input vector must be even');
    end

    % Calculate the number of rows for the matrix A
    numRows = length(B) / 2;

    % Reshape the vector B to a matrix A of size n x 2
    A = reshape(B, 2, numRows)';

    % Optionally, display the output matrix
    % disp(A);  % Uncomment this line if you want to display the matrix
end