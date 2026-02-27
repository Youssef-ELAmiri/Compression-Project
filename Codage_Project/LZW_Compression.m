function [encoded, taille_init, taille_final, rap_comp,err] = LZW_Compression(texte)
    if nargin < 1
%         errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        err = true;
    else
    
        try
        alphabet = unique(texte); 
        [y_lzw, dict_lzw] = LZWEncoder(texte, alphabet, 0);

        encoded = num2str(y_lzw);

        taille_init = length(texte) * 8;
        nb_symboles_lzw = length(y_lzw);
        taille_dico_lzw = length(dict_lzw);
        bits_par_index = ceil(log2(taille_dico_lzw)); 
        if bits_par_index < 8, bits_par_index = 8; end 

        taille_final = nb_symboles_lzw * bits_par_index;
        rap_comp = taille_init / taille_final;
        err = false;

        catch
            err = true;
            errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        end
    end
%     fprintf('--- ALGORITHME : LZW ---\n');
%     fprintf('Message codé          : %s\n', encoded);
%     fprintf('Taille initiale       : %d bits\n', taille_init);
%     fprintf('Taille compressée     : %d bits\n', taille_final);
%     fprintf('Rapport de compression: %.2f\n', rap_comp);
end