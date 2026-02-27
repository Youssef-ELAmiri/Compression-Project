
function lect_max_zero = Lecture_max_zero(M)

    [M_out_aug, ~] = rendre_carre_augmenter(M); 


    V = lect_vert(M_out_aug);
    H = lect_hor(M_out_aug);
    Z = lect_zigzag(M_out_aug);


    v_zeros = max_zeros(V);
    h_zeros = max_zeros(H);
    z_zeros = max_zeros(Z);


    [~, idx] = max([v_zeros, h_zeros, z_zeros]);


    switch idx
        case 1
            lect_max_zero = 'V'; 
        case 2
            lect_max_zero = 'H';  
        case 3
            lect_max_zero = 'Z';  
    end

end













