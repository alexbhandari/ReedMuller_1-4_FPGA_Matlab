function [m,y] = syndrome_old(r)
H = [1 1 0 1 0 0;                 % parity matrix
     1 0 1 0 1 0;   
     0 1 1 0 0 1];
Het = mod(r*transpose(H),2);
%Het = yHt
% codebook
if Het == [0 0 0]
    %disp('r is correct');
    e = [0 0 0 0 0 0];
elseif Het == [0 0 1]
    e = [0 0 0 0 0 1];
elseif Het == [0 1 0]
    e = [0 0 0 0 1 0];
elseif Het == [1 0 0]
    e = [0 0 0 1 0 0];
elseif Het == [0 1 1]
    e = [0 0 1 0 0 0];
elseif Het == [1 0 1]
    e = [0 1 0 0 0 0];
elseif Het == [1 1 0]
    e = [1 0 0 0 0 0];
else
    e = 0;
    %disp('Invalid code');
end
       
         
 c_out = abs(r-e);
 m = c_out(1:3);
 
end