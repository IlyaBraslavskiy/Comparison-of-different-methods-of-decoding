function answer = viterbi(output) 

%msg = randi([0 7],6,1); % ������� �������������� ������
%codeword = [msg' mod(-sum(msg),8) ]; % �������� 


%sigma = 0.1; % 

%output = demodulate(awgn(modulate(codeword),sigma),sigma); % �������� ������� �������� ������������

states = [0:7]; 
start_p = output(1:8,1); % ��������� ����

% ������� ��������� ��� ������� ����, ���������� ��� � ���� 
% �������������� �� 

   T = {};
   
   for state = 1:length(states)
       %            path         state_weight 
       T{state} = {states(state),start_p(state)};
   end
   
   for deep = 2:6 % ��� ������ �������(������� �������)
       for state = 1:length(states)
           U{state} = {[],0};
       end
           
       for current_state = 1:length(states) % ��� ������� ����
           Ti = T{current_state}; 
           path = Ti{1}; weight = Ti{2};
           for next_state = 1:length(states) % ��� ������� ���� �� ������� k 
               p = output(next_state,deep);
               new_index = mod((sum(path) + states(next_state)), 8) + 1; 
               if p * weight > U{new_index}{2}
                  U{new_index} = {[path, states(next_state)], p * weight};
               end
           end
       end
       T = U;
   end
   
   M = 0;
   
   for state = 1:length(states)            
   path = T{state}{1}; weight = T{state}{2};
   last = mod(-sum(path), 8);
   weight = weight * output(last+1, 7);
   path = [path, last];
   T{state} = {path, weight};
   if T{state}{2} > M 
       M = T{state}{2};
       answer = T{state}{1};
   end
   
       
   end
   
   
%end