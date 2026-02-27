
function [encoded, bits_origin, bits_comp, rapp, eff,err] = Shannon_Fano_Compression(texte)

    if nargin < 1
%         errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        err = true;
    else


        data = double(texte(:)'); 
        symbols = unique(data);
        counts = histcounts(data, [symbols, max(symbols)+1]);


        total_len = length(data);
        probs = counts(counts > 0) / total_len; % 


        [probs, idx] = sort(probs, 'descend');
        symbols = symbols(idx);

        try
            codes = cell(1, length(symbols));
            codes = shannon_fano_recursive(probs, codes, '');

            encoded = '';

                dict_map = containers.Map(symbols, codes);

            for i = 1:length(data)
                encoded = [encoded, dict_map(data(i))];
            end

            entropy = -sum(probs .* log2(probs));

            longueurs_codes = cellfun(@length, codes); 
            L_moy = sum(probs .* longueurs_codes);

            eff = (entropy / L_moy) * 100;


            bits_origin = total_len * 8;  
            bits_comp = length(encoded);
            rapp = bits_origin / bits_comp;
            err = false;
        catch
            err = true;
            errordlg('Le texte est très court ou ne peut pas être compresser.','erreur');
        end
    end
% 
%     fprintf('========================================\n');
%     fprintf('   RÉSULTATS COMPRESSION SHANNON-FANO   \n');
%     fprintf('========================================\n');
%     
%     if length(texte) < 100
%         fprintf('Texte original     : %s\n', char(data));
%         fprintf('Message codé       : %s\n', encoded);
%     else
%         fprintf('Texte original     : [Données trop longues pour affichage]\n');
%     end
%     
%     fprintf('----------------------------------------\n');
%     fprintf('Taille initiale    : %d bits\n', bits_origin);
%     fprintf('Taille finale      : %d bits\n', bits_comp);
%     fprintf('Taux de compression: %.2f (Gain: %.2f %%)\n', rapp, gain);
%     fprintf('----------------------------------------\n');
%     fprintf('Entropie (H)       : %.4f bits/symbole\n', entropy);
%     fprintf('Longueur Moy (Lmoy): %.4f bits/symbole\n', L_moy);
%     fprintf('Efficacité         : %.2f %%\n', eff);
%     fprintf('========================================\n');

end