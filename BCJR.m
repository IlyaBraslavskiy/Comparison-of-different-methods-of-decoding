function answer = BCJR(output) 


%msg = randi([0 7],6,1); % создаем информационный вектор
%codeword = [msg' mod(sum(msg),8) ]; % кодируем 


%sigm = 0.1; % 

gamma = zeros(8,8,7);
alpha = zeros(8,8);
beta = zeros(8,8);
sigma = [];
%lambda = [];

%output = demodulate(awgn(modulate(codeword),sigm),sigm);

for m2 = 0:7
    gamma(1,m2+1,1) = output(m2+1,1);
end
        

for t = 2:7
    for m1 = 0:7
        for m2 = 0:7
            delta = mod(m2 - m1,8);
            gamma(m1+1,m2+1,t) = output(delta + 1,t);
        end
    end
end

alpha(1,1) = 1;
alpha(1,8) = 1;


for t = 2:8
    for m2 = 0:7
      for m1 = 0:7
        alpha(m2+1,t) = alpha(m2+1,t) + alpha(m1+1,t-1) * gamma(m1+1,m2+1,t-1);
      end
    end
    alpha(:,t) = alpha(:,t)/sum(alpha(:,t));
end


beta(1,1) = 1;
beta(1,8) = 1;



for t = 7:-1:1
    for m2 = 0:7
      for m1 = 0:7
          beta(m2+1,t) = beta(m2+1,t) + beta(m1+1,t+1) * gamma(m2+1,m1+1,t);
      end
    end
    beta(:,t) = beta(:,t)/sum(beta(:,t));
end

for t = 1:7 
    for m1 = 0:7
        for m2 = 0:7
            sigma(m1+1,m2+1,t) = alpha(m1+1,t) * gamma(m1+1,m2+1,t) * beta(m2+1,t+1);
        end
    end
end

out_prob = zeros(8,7);

for t = 1:7
    for m1 = 0:7
        for m2 = 0:7
            %if m2 < m1 
            %    delta = 8 - abs(m2 - m1);
            %else
            %    delta = m2 - m1; 
            %end
            delta = mod(m2 - m1,8);
                
            out_prob(delta+1,t) = out_prob(delta+1,t) + sigma(m1+1,m2+1,t);  
        end
    end
end


answer = [];
for i = 1:7
    for j = 1:8
       if out_prob(j,i) == max(out_prob(:,i))
           answer(i) = j-1;
       end
    end
end

