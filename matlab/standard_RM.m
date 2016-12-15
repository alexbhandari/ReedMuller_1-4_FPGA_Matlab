function [G, H] = standard_RM()
r0=1;
m0=4;
G = reedmullergen(r0,m0);
H = reedmullergen(m0-r0-1,m0);
end