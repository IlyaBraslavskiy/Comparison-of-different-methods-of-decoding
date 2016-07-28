%M = 8;           % Modulation order
%bps = log2(M);   % Bits per symbol
N = 7;           % Codeword length
K = 6;           % Message length
        
In = eye(K);
b = [1 1 1 1 1 1];
G = [In b'];
H = [1 1 1 1 1 1 1];

infor = [];
cod = [];
vit = [];
vit_symb = [];
iter = 1; 
bcjr_symb = [];
cod_symb = [];
n = 1000;

%SNR_array = [0:0.5:15];

for sigma = 0.05:0.025:0.7
    
    %sigma = (0.5*10^(-SNR/10));
    
    inf_error = 0;
    cod_error = 0;
    vit_error = 0;  
    bcjr_error = 0;
    vit_symb_error = 0;
    cod_symb_error = 0;
    bcjr_symb_error = 0; 
    for i = 1:n
        msg = randi([0 7],6,1);
        codeword = [msg' mod(-sum(msg),8) ];
        out_word = zeros(7,1);
        
        %sigma = sqrt(0.5 * 10^(0.1 * EsN0) );
     
  
        output = demodulate(awgn(modulate(codeword),sigma),sigma);
    
        for i = 1:8
            for j = 1:7
                if output(i,j) == max(output(1:8,j))
                    out_word(j) = i-1;
                end
            end
        end
    
    %    if out_word(1:6) == codeword(1:6)'
    %        inf_error = inf_error + 0;
    %    else  inf_error = inf_error + 1;
    %    end
    
      for i = 1:7
                if out_word(i) == codeword(i)
                    cod_symb_error = cod_symb_error + 0;
                else cod_symb_error = cod_symb_error + 1;
                end
            end
    
         
      %  if out_word == codeword'
      %     cod_error = cod_error + 0;
      %  else  cod_error = cod_error + 1;
           
            
       % end
             
            answ = viterbi(output);
            
         %   if answ == codeword
         %       vit_error = vit_error + 0;
         %   else vit_error = vit_error + 1;
         %   end
             
            for i = 1:7
                if answ(i) == codeword(i)
                    vit_symb_error = vit_symb_error + 0;
                else vit_symb_error = vit_symb_error + 1;
                end
            end
             
              bcjr_answ = BCJR(output);
                    for i = 1:7
                    if bcjr_answ(i) == codeword(i)'
           bcjr_symb_error = bcjr_symb_error + 0;
        else  bcjr_symb_error = bcjr_symb_error + 1;
                    end
                    end
                    
            bcjr_answ = BCJR(output);
            
         %   if bcjr_answ == codeword
         %       bcjr_error = bcjr_error + 0;
         %   else bcjr_error = bcjr_error +1;
         %   end
            
    
        
end
        
    
    infor(iter) = inf_error/n;
    cod(iter) = cod_error/n;
    vit(iter) = vit_error/n;
    bcjr_symb(iter) = bcjr_symb_error/(8*n);
    vit_symb(iter) = vit_symb_error/(8*n);
    cod_symb(iter) = cod_symb_error/(8*n);
    iter = iter + 1;
    
end

y = [0.05:0.025:0.7];

x = 10*log10(0.5./y.^2);


figure;
semilogy(x,cod_symb,'-',   x,vit_symb,'-', ...
         x,bcjr_symb,'-');
legend  ( 'uncoded infromation message',              'Viterbi', ...
          'BCJR', ...
          'Location','SouthWest');
xlabel  ( 'Es/No (dB)' ); ylabel( 'Error Probability' );
title   ( 'Error on the symbol' );   grid on;