%Variables
P_erasure=0;
P_error=.1;
N=16;
m = [1 1 1 1 1];
[G, H] = systematic_RM();

%Error generator
c = encode(m, G);
%r=corrupt(c,P_erasure,P_error)
r=make_error(c,3);
r2=make_erasure(r,1);

%remove erasure

dec_m = syndrome(r, G, H);
    
%[dc,dm]=reedmullerdec(r,G,1,4);

fprintf('m=%s\nc=%s\nf=000%s\n',array2str(m),array2str(c),dec2bin(hex2dec('12B7')));
fprintf('c=%s\n',dec2hex(bin2dec(array2str(c))));