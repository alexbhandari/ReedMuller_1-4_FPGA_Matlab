function [codebook,message]=codebook()
codebook = zeros(32,16);
message = zeros(32,5);
for m = 0:31
    message(m+1,:) = binary_lookup(m);
    codebook(m+1,:) = encode(binary_lookup(m));
end