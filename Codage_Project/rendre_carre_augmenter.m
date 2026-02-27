function [M_out,taille] = rendre_carre_augmenter(M)

    [X, Y] = size(M);
    taille = max(X, Y);
    M_out = zeros(taille, taille); 
    M_out(1:X, 1:Y) = M;

end