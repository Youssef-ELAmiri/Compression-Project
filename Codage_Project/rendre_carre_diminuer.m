function [M_out,taille] = rendre_carre_diminuer(M)

    [X, Y] = size(M);
    taille = min(X, Y);
    M_out = M(1:taille, 1:taille);

end