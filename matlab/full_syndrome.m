%Variables
P_erasure=0;
P_error=.1;
N=16;
m = [1 0 1 0 1];
[G, H] = systematic_RM();

%Error generator (1 to 3 errors)
c = encode(m, G);
r=make_error(c,1);
r2=make_erasure(r,1);

%Detect erasures
e = []; %location of erasures
r_e = []; %erasure free r
H_e = []; %modified H
for i=1:size(r2,2) % loop through r
    if r2(i) ~= 0.5
        r_e = [r_e r(i)]; 
        H_e = [H_e H(:,i)]; %modify H - removes rows 
    else
        e = [e i];
    end
end

%run syndrome on errors only
dec_c = syndrome_b(r_e, H_e, size(r_e,2));
new_c = [];
%replace erasure
for i=1:size(r2,2) % loop through r
    if r2(i) == 0.5 % locate erasure
        new_c = [new_c r2(i)]; 
        if i~=16
            new_c = [new_c dec_c(i)];
        end
    else
        if i~=16
            new_c = [new_c dec_c(i)];
        end
    end
end

%Exhaustive decoding
y=0;
x=[];
for n = 1:31 % loop through all messages, encode, and compare codewords
  % look for best matching code words
  if max( abs( encode(binary_lookup(n),G) - new_c)) <= 0.5  
    y = y+1;
    x = [x;encode(binary_lookup(n),G)];
  end
end

if y > 1 % multiple messages
  disp('Could not find unique decoded message');
  m_final = x(1:5);
  disp(m_final);
elseif y < 1  % no messages
  disp('Could not find message'); 
  m_final = 0;
else  % unique message
  disp('Found unique decoded message');
  m_final = x(1:5);
  disp(m_final)
end

fprintf('original m = %s decoded m = %s\n',array2str(m),array2str(m_final));