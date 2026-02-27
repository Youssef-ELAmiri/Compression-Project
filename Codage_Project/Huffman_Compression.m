function [encoded, taille_init, taille_final, rap_comp, eff,err] = Huffman_Compression(texte)

    if nargin < 1
%         errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        err = true;
    else

        try
        data = double(texte(:)'); 
        symbols = unique(data);

        probs = zeros(1, length(symbols));
        for i = 1:length(symbols)
            probs(i) = sum(data == symbols(i)) / length(data);
        end

        [dict, avglen] = huffmandict(symbols, probs);
        encoded_msg = huffmanenco(data, dict);


        encoded = sprintf('%d', encoded_msg);

        entropy = -sum(probs .* log2(probs));

        L_moy = avglen; 

        eff = (entropy / L_moy) * 100;

        taille_init = length(texte) * 8;      
        taille_final = length(encoded_msg);   
        rap_comp = taille_init / taille_final;
        err = false;
        
        catch
            err = true;
            errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        end
    end


%     fprintf('========================================\n');
%     fprintf('      RÉSULTATS COMPRESSION HUFFMAN     \n');
%     fprintf('========================================\n');
%     
%     if length(texte) < 100
%         fprintf('Texte original     : %s\n', char(data));
%         fprintf('Message codé       : %s\n', encoded);
%     else
%         fprintf('Texte original     : [Trop long pour affichage]\n');
%     end
%     
%     fprintf('----------------------------------------\n');
%     fprintf('Taille initiale    : %d bits\n', taille_init);
%     fprintf('Taille finale      : %d bits\n', taille_final);
%     fprintf('Rapport compression: %.2f (Gain: %.2f %%)\n', rap_comp, gain);
%     fprintf('----------------------------------------\n');
%     fprintf('Entropie (H)       : %.4f bits/symbole\n', entropy);
%     fprintf('Longueur Moy (Lmoy): %.4f bits/symbole\n', L_moy);
%     fprintf('Efficacité         : %.2f %%\n', eff);
%     fprintf('========================================\n');
end