%% syndrome decoder
%% can decode up to 3 errors
function c=syndrome_b(r, H, n)

Het = mod(r*transpose(H),2); %(1,n)*(n,11)=(1,11)
e = [permpos(1,n);permpos(2,n);permpos(3,n)];
dec_e = ones(1,n)*-1;
if Het == zeros(1,size(H,1))
    %disp('r is correct');
    dec_e = zeros(1,n);
else
for i=1:size(e,1) % loop through error book
    if Het == mod(e(i,:)*transpose(H),2) %(1,n)*(n,11)=(1,11)
        dec_e = e(i,:);
        break;
    end
end
end
c = abs(r-dec_e);
end