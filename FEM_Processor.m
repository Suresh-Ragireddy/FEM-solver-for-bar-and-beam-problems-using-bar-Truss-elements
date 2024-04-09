function [K_global_D_bc,Fv,S,X] = FEM_Processor(P,e,L,a,b,c,f)
    syms x

    x0 = 0;
    xL = L;
    % P Order of Interpolation Function foe element
    ndofel=P+1;
    
    % Element length
    h = (xL - x0) / e;
    %PbarKL1 = 2*P -1;
    %PbarKL2 = 2*P;
    PbarKL3 = 3*P;
    
    % max(PbarKL1,PbarKL2,PbarKL3);
    
    Pbar = PbarKL3;
    if mod(Pbar, 2) == 1 % ODD
        nG = (Pbar + 1) / 2;
    else % Even
        nG = (Pbar + 2) / 2;
    end
    
    [w,xi] = GaussQuadrature(nG);
    
     
    shapMatrix=zeros(nG,ndofel);
    dshapMatrix=zeros(nG,ndofel);
    
    for i = 1:nG
        xi_loc = xi(i);
        [ndofel,shap,dshap] = SHAPE(P,xi_loc);
    
        for j =1:ndofel
            shapMatrix(i,j)=shap(j);
            dshapMatrix(i,j)=dshap(j);
        end
    end

    %ndofel=P+1;
    
    % Local stiffness matrix
    KL1 = zeros(ndofel, ndofel, 'sym');
    KL2 = zeros(ndofel, ndofel, 'sym');
    KL3_Ten3 = zeros(ndofel, ndofel,ndofel, 'sym');
    F_Mat = zeros(ndofel, ndofel, 'sym');
    
    for i = 1:ndofel
        for j = 1:ndofel
            KL1(i, j) = 0;
            KL2(i, j) = 0;
            F_Mat(i, j) =0;
            for k = 1:nG
                KL1(i, j) = KL1(i, j) + (a * dshapMatrix(k,i) *dshapMatrix(k,j)*(2/h)*w(k));
                KL2(i, j) = KL2(i, j) + (-b * dshapMatrix(k,j) * shapMatrix(k,i)*w(k));
        
                F_Mat(i, j) = F_Mat(i, j) + (-1* shapMatrix(k,i)*shapMatrix(k,j)*(h/2)*w(k));
            end
            
        end
    end
    
    for i = 1:ndofel
        for j = 1:ndofel
            for K = 1:ndofel
                KL3_Ten3(i, j,K)= 0;
                for M = 1:nG
                    KL3_Ten3(i, j, K) =  KL3_Ten3(i, j, K) + (-1* shapMatrix(M,i)*shapMatrix(M,j)*shapMatrix(M,K)*(h/2)*w(M));
                end
            end
    
        end
    end
    
    KL1_sub = KL1;
    KL2_sub = KL2;
    KL3_Ten3_sub = KL3_Ten3;
    F_Mat_sub = F_Mat;
    
    %generl formula for finding size of gloabl stiffness matrix-(S=OIF*e+1
    S=P*e+1;
    
    global_matrix_size = S; % each element has 2 nodal points
    % Initialize global stiffness matrix
    
    KL1_global = zeros(global_matrix_size);
    KL2_global = zeros(global_matrix_size);
    KL3_Ten3_global = zeros(global_matrix_size,global_matrix_size,global_matrix_size);
    F_global = zeros(global_matrix_size);
    
    % Loop through each element
    for element = 1:ndofel-1:S-1
    
        % Assemble local stiffness matrix into global stiffness matrix
        start_index = element;
        end_index = element + ndofel-1;
        KL1_global(start_index:end_index, start_index:end_index) = KL1_global(start_index:end_index, start_index:end_index) + KL1_sub;
        KL2_global(start_index:end_index, start_index:end_index) = KL2_global(start_index:end_index, start_index:end_index) + KL2_sub;
        KL3_Ten3_global(start_index:end_index, start_index:end_index,start_index:end_index) = KL3_Ten3_global(start_index:end_index, start_index:end_index,start_index:end_index) + KL3_Ten3_sub;
    
    
        F_global(start_index:end_index, start_index:end_index) = F_global(start_index:end_index, start_index:end_index) + F_Mat_sub;
    end
    
    
    X = (x0:h/P:xL)';
    
    c_x = sym(zeros(S, 1));
    f_x = sym(zeros(S, 1));
    
    for i = 1:S
        f_x(i) = subs(f, x, X(i));
        c_x(i) = subs(c, x, X(i));
    end
    
    % Perform tensor-vector multiplication
    KL3_global = zeros(global_matrix_size); % Initialize the result tensor
    for i = 1:global_matrix_size
    
        for j = 1:global_matrix_size
    
            for k = 1:global_matrix_size
    
                KL3_global(i, j) = KL3_global(i, j) + KL3_Ten3_global(i, j, k) * c_x(k);
            end
        end
    end
    
    %K_global_inverse=InverseTDMA(K_global)
    
    Fv = F_global*f_x;
    
    K_global_D_bc = KL1_global+KL2_global+KL3_global;
end