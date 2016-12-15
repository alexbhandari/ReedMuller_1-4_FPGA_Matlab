function r=make_error(c,n)
P_erasure=0;
P_error=.1;
r=corrupt(c,P_erasure,P_error);
while nnz(abs(r-c)) ~= n
    r=corrupt(c,P_erasure,P_error);
end