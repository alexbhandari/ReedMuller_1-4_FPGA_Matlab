output = [];
count = 0;
range = [0.7, 0.5, 0.2, 0.05, 0.01];
for P_error = range
missed = 0;
for i = 1:1000
    m = rand(1,5) < 0.5;        % message is 3 bits
%--------

%Variables
P_erasure=0;

[G, H] = systematic_RM();

%Error generator (1 to 3 errors)
c = encode(m, G);
r=corrupt(c,P_erasure,P_error);

%decode
dec_m = syndrome(r, G, H);
%fprintf('original m = %s decoded m = %s\n',array2str(m),array2str(dec_m));

%------------
    if m ~= dec_m
        missed = missed + 1;
    end
end
count = count + 1;
output(count) = missed/i;
end
plot(range,output);