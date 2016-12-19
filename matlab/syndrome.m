%% syndrome decoder
%% can decode up to 3 errors
function m=syndrome(r, G, H)

Het = mod(r*transpose(H),2); %(1,16)*(16,11)=(1,11)
e = [permpos(1,16);permpos(2,16);permpos(3,16)];
dec_e = ones(1,16)*-1;
if Het == zeros(1,11)
    %disp('r is correct');
    dec_e = zeros(1,16);
else
for i=1:size(e,1) % loop through error book
    if Het == mod(e(i,:)*transpose(H),2) %(1,16)*(16,11)=(1,11)
        dec_e = e(i,:);
        break;
    end
end
end
c = abs(r-dec_e);
%m = decode(c, G);
m=c(1:5);
end