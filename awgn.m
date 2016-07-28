function coord = awgn(coord,sigma)
    for i = 1:length(coord)
        coord(i) = normrnd(real(coord(i)),sigma) + sqrt(-1)*(normrnd(imag(coord(i)),sigma));
    end
end