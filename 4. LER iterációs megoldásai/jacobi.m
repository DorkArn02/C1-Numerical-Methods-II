function [x] = jacobi(A, b, maxIterations, tol)
% A - lineáris egyenletrendszer mátrixa
% b - konstans vektor
% maxIterations - maximális iterációs szám
% tol - elfogadható relatív hiba
% Visszatérési érték: megoldásvektor megfelelő közelítése
% Példa bemenet: jacobi([4 -1 0; -1 4 -1; 0 -1 4], [2;6;2], 10, 10^(-3))

[m, n] = size(A);

% Négyzetes mátrix
if m ~=n
    error("A mátrix nem négyzetes!");
end

% A mátrix szétdarabolása
L = tril(A, -1);
U = triu(A, 1);
D = zeros(length(A))+diag(diag(A));

% Átmenet mátrix meghatározása
B = -inv(D)*(L+U);

conv = 0;

% Elégséges feltétel teljesül
if norm(B, 1) < 1 || norm(B, inf) < 1 || norm(B, 'fro') < 1
    fprintf("Eléséges feltétel teljesül, konvergál minden x0 esetén!\n");
    conv = 1;
else % Szükséges elégséges feltétel vizsgálata
    eigenvalues = eig(B);
    spec_rad = max(abs(eigenvalues));
    if spec_rad < 1
        fprintf("SZ+E feltétel teljesül, konvergál minden x0 esetén!\n");
        conv = 1;
    end
end

if conv == 0
    error("A Jacobi-iteráció nem konvergál tetszőleges kezdővektor esetén!");
end

% Az iterációs módszer megkezdése
x = zeros(m, 1); % Kezdővektor
%R = L+U;

for iteration = 1:maxIterations
    x_prev = x; % Előző iteráció eredménye

    % Jacobi iteráció vektoros alakja
    x = B * x_prev + inv(D) * b;
    % for i = 1:m
    %     x(i) = (b(i) - R(i, :) * x_prev) / D(i, i); % Jacobi lépés
    % end

    % Konvergencia ellenőrzése
    if norm(x - x_prev, inf) < tol
        format rational
        fprintf('A Jacobi iteráció konvergált %d lépésben.\n', iteration);
        return;
    end
end
fprintf('A Jacobi iteráció nem konvergált %d lépésben.\n', maxIterations);

end
