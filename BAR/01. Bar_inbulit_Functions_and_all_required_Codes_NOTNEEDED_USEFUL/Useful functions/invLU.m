function [A_inverse] = invLU(A)
%CroutsLU
    [m, n] = size(A);
    if m ~= n
        error('Input matrix must be square');
    end
    
    U = eye(n);  % Initialize L as identity matrix
    L = zeros(n); % Initialize U as zero matrix
    L(:,1) = A(:,1);
    U(1,:) = A(1,:)/L(1,1);

    for i = 2:n

        % Computing elements of L
        for k = i:n
            L(k, i) = A(k, i) - L(k, 1:i-1) * U(1:i-1, i);
        end

        %  Computing elements of U
        for j = i+1:n
            U(i, j) = (A(i, j) - L(i, 1:i-1) * U(1:i-1, j))/L(i,i);
        end

    end

    [n, ~] = size(L);
    % Identity matrix for b
    b = eye(n);
    
    x = zeros(n, n);
    
    % Solve Ly = b and then Ux = y for each column of b
    for col = 1:n
        y = zeros(n, 1);
    
        % Solve Ly = b (forward substitution)
        y(1) = b(1, col) / L(1, 1);
        for i = 2:n
            sum = b(i, col);
            for j = 1:i-1
                sum = sum - L(i, j) * y(j);
            end
            y(i) = sum / L(i, i);
        end
    
        % Solve Ux = y (backward substitution)
        x(n, col) = y(n);
        for i = n-1:-1:1
            sum = y(i);
            for j = i+1:n
                sum = sum - U(i, j) * x(j, col);
            end
            x(i, col) = sum / U(i, i);
        end
    end
    % Now,in  this x matrix contains the columns of the inverse of A
    A_inverse = x;
end
