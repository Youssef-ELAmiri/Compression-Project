function [encoded, taille_init, taille_final, rap_comp,err] = LZ78_Compression(texte)
    if nargin < 1
%         errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        err = true;
    else
    
        try
        [y_lz78, dict_lz78] = LZ78Encoder(texte, 0);

        encoded = '';
        for i = 1:size(y_lz78, 1)
            idx = y_lz78{i, 1};
            char_val = y_lz78{i, 2};
            if isempty(char_val)
                s = 'EOF';  
            elseif char_val == ' '
                s = '_';  
            else
                s = char_val;
            end
            encoded = [encoded, sprintf('%d%s ', idx, s)];
        end

        taille_init = length(texte) * 8;
        nb_paires = size(y_lz78, 1);
        taille_dico_78 = length(dict_lz78);
        bits_index_78 = ceil(log2(taille_dico_78));
        if bits_index_78 == 0, bits_index_78 = 1; end

        taille_final = nb_paires * (bits_index_78 + 8);
        rap_comp = taille_init / taille_final;
        err = false;

        catch
            err = true;
            errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        end
    end
%     fprintf('--- ALGORITHME : LZ78 ---\n');
%     fprintf('Message codé          : %s\n', encoded);
%     fprintf('Taille initiale       : %d bits\n', taille_init);
%     fprintf('Taille compressée     : %d bits\n', taille_final);
%     fprintf('Rapport de compression: %.2f\n', rap_comp);
end