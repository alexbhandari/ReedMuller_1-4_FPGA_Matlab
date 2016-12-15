function [G, H] = systematic_RM()
I = eye(5);
P = [transpose(permpos(3,5)) transpose([1 1 1 1 1])];
G = [I P]
H = [transpose(P) eye(11)]
end