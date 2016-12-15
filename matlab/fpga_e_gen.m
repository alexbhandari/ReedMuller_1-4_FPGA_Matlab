[G, H] = systematic_RM();
e = [permpos(0,16);permpos(1,16);permpos(2,16);permpos(3,16)];
e_het = [];
for i=1:size(e,1) % build e_het book for FPGA
    e_het = [e_het; mod(e(i,:)*transpose(H),2)]; %(1,16)*(16,11)=(1,11)
end
e_het