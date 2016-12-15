function r=corrupt(c,P_erasure,P_error)
%Corrupted signal
Noisy_channel=randsrc(1,length(c),[-1/2 1 0; P_erasure, P_error, 1-P_error-P_erasure]);
r=mod(abs(c+Noisy_channel),2);
end