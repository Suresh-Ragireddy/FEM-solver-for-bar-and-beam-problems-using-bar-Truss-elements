function x_vector = GlobalLocationBeam(x0, xL, e)
    h = (xL - x0) / e;
    x_vector = x0:h:xL; % Generates a vector of node locations
end