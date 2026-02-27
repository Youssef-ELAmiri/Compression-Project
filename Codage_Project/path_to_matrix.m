function matrice = path_to_matrix(chemin)
    img = imread(chemin);

    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    matrice = double(img);
end