
function codes = shannon_fano_recursive(p, codes, prefix)
    n = length(p);
    if n == 1
        codes{1} = prefix;
        return;
    end
    
    diffs = zeros(1, n-1);
    for i = 1:n-1
        diffs(i) = abs(sum(p(1:i)) - sum(p(i+1:end)));
    end
    [~, split_point] = min(diffs);
    
    codes_left = shannon_fano_recursive(p(1:split_point), codes(1:split_point), [prefix '0']);
    codes_right = shannon_fano_recursive(p(split_point+1:end), codes(split_point+1:end), [prefix '1']);
    
    codes = [codes_left, codes_right];
end