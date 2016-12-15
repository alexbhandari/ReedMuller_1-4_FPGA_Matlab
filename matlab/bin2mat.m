function m = bin2mat(n,len)
b = zeros(1,len);
b0 = num2str(dec2bin(n))
if size(b,2)>len
    disp('Error size does not match number');
else
m = zeros(1,len);
end
for i = 1:len
    if i>size(b,2)
        b(i) = 0;
    else
        b(i) = b0(i);
    end
end

b

for i = 1:len
    m(i) = str2double(b(i))
end
end