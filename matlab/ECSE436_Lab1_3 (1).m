m = rand(1,3) < 0.5             % message is 3 bits
G = [1 0 0 1 1 0;               % generator matrix
     0 1 0 1 0 1; 
     0 0 1 0 1 1]
c = m*G                         % 
E = (-0.5)*( rand(1,6) < 0.1 )  % 
m_out = abs(c+E)

y = 0
x = []


codes = [0 0 0 0 0 0;           % all possible codes
         0 0 1 0 1 1; 
         0 1 0 1 0 1; 
         0 1 1 1 1 0; 
         1 0 0 1 1 0; 
         1 0 1 1 0 1; 
         1 1 0 0 1 1; 
         1 1 1 0 0 0]

for n = 1:6
  if max( abs( codes(n,:) - m_out)) == 0.5  % look for the code that is the closest match
    y = y+1
    x = codes(n,:)
  end
end

if y > 1 % multiple messages
  disp('Could not find unique decoded message');
  m_final = x(1:3)
  disp(m_final);
elseif y < 1  % no messages
  disp('Could not find message'); 
else  % unique message
  disp('Found unique decoded message');
  m_final = x(1:3)
  disp(m_final)
end