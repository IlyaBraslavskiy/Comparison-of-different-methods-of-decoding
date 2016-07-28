function prob = demodulate(coord,sigma)
prob = zeros(8,7);

for j=1:7
    prob(1:8,j) = coord(j);
end    

cons_points = modulate([0 1 2 3 4 5 6 7]);



for j=1:7
    prob(1:8,j) = exp(-(abs(prob(1:8,j) - conj(cons_points'))).^2./(2*sigma^2));
    prob(1:8,j) = prob(1:8,j)./sum(prob(1:8,j));
end

end
