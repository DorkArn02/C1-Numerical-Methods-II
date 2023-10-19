function [inverseMatrix, determinant] = gaussel3(matrix)
% Ez a függvény kiszámolja a megadott A mátrix inverzét, ha létezik
% Bemenet: A mátrix
% Kimenet: A mátrix inverze
% Példa bemenet: [A, D] = gaussel3([1 1 1; 2 4 2; -1 5 -2])

% Ellenőrizzük, hogy a mátrix négyzetes
[rows, cols] = size(matrix);

if rows ~= cols
    error('A mátrixnak négyzetesnek kell lennie!');
end

% Teljes rangú mátrixnak létezik inverze
if rank(matrix) ~= size(matrix, 1)
    error("Nem invertálható mert a mátrix oszlopvektorai nem lineárisan függetlenek!")
end

determinant = det(matrix);

% Kibővítjük a mátrixot az egységmátrixszal
augmentedMatrix = [matrix, eye(rows)];

% Gauss-Jordan elimináció lépései
for i = 1:rows
    % Pivot elem kiválasztása
    pivot = augmentedMatrix(i, i);

    % i-edik sor elemeit leosztom a pivot elemmel
    augmentedMatrix(i, :) = augmentedMatrix(i, :) / pivot;

    % Az alsó és felső sorok kivonása a normalizált sorral
    for j = 1:rows
        if i ~= j
            factor = augmentedMatrix(j, i);
            augmentedMatrix(j, :) = augmentedMatrix(j, :) - factor * augmentedMatrix(i, :);
        end
    end
end

% Az inverz mátrix a kibővített mátrix jobb oldali része
inverseMatrix = augmentedMatrix(:, cols+1:end);
end
