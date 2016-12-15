%Variables
P_erasure=0;
P_error=.1;
N=16;
m = [1 0 1 0 1];
[G, H] = systematic_RM();

%Error generator (1 to 3 errors)
c = encode(m, G);
r=make_error(c,3);

%decode
dec_m = syndrome(r, G, H);
fprintf('original m = %s decoded m = %s\n',array2str(m),array2str(dec_m));