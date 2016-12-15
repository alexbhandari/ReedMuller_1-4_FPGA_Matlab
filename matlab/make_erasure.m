function r=make_erasure(c,n)
P_erasure=.1;
P_error=0;
r=corrupt(c,P_erasure,P_error);
while nnz(abs(r-c)*2) ~= n
    r=corrupt(c,P_erasure,P_error);
end