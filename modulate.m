function coord = modulate(codeword)
 for i = 1:length(codeword)
     switch codeword(i)
         case 0
              coord(i) = complex(1,0);
         case 1
              coord(i) = complex(0.7071,0.7071);
         case 2 
              coord(i) = complex(0,1);
         case 3 
              coord(i) = complex(-0.7071,0.7071);
         case 4 
             coord(i) = complex(-1,0);
         case 5 
             coord(i) = complex(-0.7071,-0.7071);
         case 6 
             coord(i) = complex(0,-1);
         case 7 
            coord(i) = complex(0.7071,-0.7071);
 end
 end
end