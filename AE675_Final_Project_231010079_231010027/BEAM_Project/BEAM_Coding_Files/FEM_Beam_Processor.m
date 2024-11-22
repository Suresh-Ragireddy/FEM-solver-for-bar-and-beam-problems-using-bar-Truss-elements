function [K_global,Fv,total_DOF,X,DOF_element,DOF_node,h] = FEM_Beam_Processor(e,L,a,f)

    syms x
    
    % No of Nodal points
    nodes =e+1;
    
    
    %P = 3; % hermitie cubic shape Functions
    x0 = 0;
    xL = L;
    
    % Element length
    h = (xL - x0) / e;
    
    DOF_element =4;

    % Define degrees of freedom per node
    DOF_node = 2;
    %Degree of Freedom per element
    nG = 6; % C_Local ( 3 shapeFunction + 3 shapeFunction )
    [w,xi] = GaussQuadrature(nG);
    
    shapMatrix=zeros(nG,DOF_element);
    ddshapMatrix=zeros(nG,DOF_element);
    
    for i = 1:nG
        xi_loc = xi(i);
        [shap,ddshap]  = Hermitecubicshapefunctions(xi_loc,h);
    
        for j =1:DOF_element
            shapMatrix(i,j)=shap(j);
            ddshapMatrix(i,j)=ddshap(j);
        end
    end
    
    % Local stiffness matrix
    K_Local = zeros(DOF_element, DOF_element);
    
    C_Local = zeros(DOF_element, DOF_element);
    
    for i = 1:DOF_element
        for j = 1:DOF_element
            K_Local(i, j) = 0;
            C_Local(i, j) =0;
            for k = 1:nG
                K_Local(i, j) = K_Local(i, j) + (a * ddshapMatrix(k,i) *ddshapMatrix(k,j)*((2/h)^3)*w(k));
         
                C_Local(i, j) = C_Local(i, j) + ( shapMatrix(k,i)*shapMatrix(k,j)*(h/2)*w(k));
            end
            
        end
    end
    
    KNM_local_sub = K_Local;
    CNM_local_sub = C_Local;
    
    
    % Total degrees of freedom
    total_DOF = nodes * DOF_node;
    
    % Initialize global stiffness matrix
    K_global = zeros(total_DOF);
    C_global = zeros(total_DOF);
    
    
    % Assemble the global stiffness matrix
    for i = 1:e
        % Global DOF indices for the current element
        start_index = (i-1) * DOF_node + 1;
        end_index = start_index + 2 * DOF_node - 1;
    
        % Assign local to global
        global_indices = start_index:end_index;
        K_global(global_indices, global_indices) = K_global(global_indices, global_indices) + KNM_local_sub;
        C_global(global_indices, global_indices) = C_global(global_indices, global_indices) + CNM_local_sub;
    end
    
    
    % Source vector Initialization 
    f_x = sym(zeros(nodes, 1));
    % Calculate f(x) for each x value symbolically and store in the vector
    
    X = x0:h:xL;
    
    for i = 1:nodes
        f_x(i) = subs(f, x, X(i));
    end
    f_x = [f_x,f_x];
    
    f_x = matrixToColumnVector(f_x);
    
    Fv = double(C_global*f_x); %Fvector

end