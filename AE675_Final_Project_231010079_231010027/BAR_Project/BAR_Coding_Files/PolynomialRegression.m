function Cofficients_of_Polynomial= PolynomialRegression(order,x,y)
    %  Checking if the sizes are the same
    if numel(x) ~= numel(y)
        error('Error: Data sizes are not the same.');
    end

    LHSMatrix = zeros(order+1); 
    RHSVector = zeros(order+1,1);
    
    for i = 1:(order+1)

        for j = 1:(order+1)
            LHSMatrix(i, j) = sum(x.^ (i+j-2)); 
            % note here first terms Matrix(1,1) = n,, 
            % will be calculated directly with formulae, again no need to reassign 
        end
        
        RHSVector(i) = sum(y.*(x.^ (i-1)));
    end

    Cofficients_of_Polynomial = LHSMatrix\RHSVector;
    % Instead inv function which is slow, i'm using matrix right division (/) or matrix left division (\). That is:
    % - Replace inv(A)*b with A\b
    % - Replace b*inV(A) with b/A
end