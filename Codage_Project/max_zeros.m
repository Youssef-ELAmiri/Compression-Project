   
function m = max_zeros(vec)
        v = (vec == 0);
        if ~any(v), m = 0; return; end
        d = diff([0, v, 0]);
        m = max(find(d == -1) - find(d == 1));
end