function x_vector = GlobalLocation(x0,x1,P,e)
     h = (x1 - x0) / e;
     x_vector = x0:(h / P):x1; %formula i am using

end
