output = [];
count = 0;
undecoded = 0;
range = [0.2, 0.05, 0.01];
%Variables
P_erasure=0;
P_error=0;
for P_erasure = range
missed = 0;
for i = 1:100
    m = rand(1,5) < 0.5;        % message is 3 bits
%--------

[G, H] = systematic_RM();

%Error generator (1 to 3 errors)
c = encode(m, G);
r2=corrupt(c,P_erasure,P_error);

r=make_error(c,1);
%r2=make_erasure(r,1);

%Detect erasures
e = []; %location of erasures
r_e = []; %erasure free r
H_e = []; %modified H
G_e = []; %modified G
G_r = G;
for k=1:size(r2,2) % loop through r
    if r2(k) ~= 0.5
        r_e = [r_e r2(k)]; 
        H_e = [H_e H(:,k)]; %modify H - removes rows
        %modify G method
        G_e = [G_e G(:,k)];
    else
        e = [e k];
    end
end
G_r(:,e)=[]; %strip columns with erasures

%new G
G_r = mod(rref(G_r),2);

%look through G for message erasures and remove those rows
for k=1:5
    if G_r(k,k)==0
        G_r(k,:) = [];
    end
end

%new H
I_r = G(:,1:5);
P_r = G_r(:,6:size(G_r,2));
H_r = [transpose(P_r) eye(size(G_r,2)-5)];

%run syndrome on errors only
dec_c = syndrome_b(r_e, H_r, size(r_e,2));
if sum(dec_c)/size(dec_c,2) > 1
    r2;
    H_e;
    r_e;
    undecoded = undecoded + 1;
    %sum(dec_c)/size(dec_c);
end

new_c = dec_c;
%replace erasure
if ~isempty(e)
new_c = [];
for k=1:size(r2,2) % loop through r
    if r2(k) == 0.5 % locate erasure
        new_c = [new_c r2(k)]; 
        if k~=16
            new_c = [new_c dec_c(k)];
        end
    else
        if k~=16
            new_c = [new_c dec_c(k)];
        end
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
  %disp('Could not find unique decoded message');
  m_final = x(1:5);
  %disp(m_final);
elseif y < 1  % no messages
  %disp('Could not find message'); 
  m_final = 0;
else  % unique message
  %disp('Found unique decoded message');
  m_final = x(1:5);
  %disp(m_final)
end

%fprintf('original m = %s decoded m = %s\n',array2str(m),array2str(m_final));

%-------------------    
    
    if m ~= m_final
        missed = missed + 1;
    end
end
count = count + 1;
output(count) = missed/i;
end
plot(range,output);
undecoded