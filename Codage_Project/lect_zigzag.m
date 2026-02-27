function Z = lect_zigzag(M)

    [rows, cols] = size(M);
    Z = zeros(1, rows*cols);
    row = 1; col = 1;
    for i = 1:length(Z)
        Z(i) = M(row, col);
        if mod(row + col, 2) == 0 
            if col == cols, row = row + 1;
            elseif row == 1, col = col + 1;
            else, row = row - 1; col = col + 1; end
        else 
            if row == rows, col = col + 1;
            elseif col == 1, row = row + 1;
            else, row = row + 1; col = col - 1; end
        end
    end
end