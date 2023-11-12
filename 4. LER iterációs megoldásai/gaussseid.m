function x = gaussseid(A, b, maxIterations, tol)
% A - lineáris egyenletrendszer mátrixa
% b - konstans vektor
% maxIterations - maximális iterációs szám
% tol - elfogadható relatív hiba
% Visszatérési érték: megoldásvektor megfelelő közelítése
% Példa bemenet: gaussseid([4 -1 0; -1 4 -1; 0 -1 4], [2;6;2], 10, 10^(-3))
% gaussseid([1 0 1; 0 1 -1; 1 1 1], [1;1;1], 3, 10^(-2))

% Méret ellenőrzése
[n, m] = size(A);
if n ~= m
    error('A mátrixnak négyzetesnek kell lennie.');
end

% A mátrix szétdarabolása
L = tril(A, -1);
U = triu(A, 1);
D = zeros(length(A))+diag(diag(A));

% Átmenet mátrix meghatározása
B = -inv((L+D))*U;

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

% Gauss-Seidel iteráció
x = zeros(n, 1); % Kezdeti megoldás, pl. mindent nullára állítunk

for iteration = 1:maxIterations
    x_prev = x; % Előző iteráció eredménye

    x = -inv((L+D))*U * x_prev + inv((D+L))*b;

    % for i = 1:n
    %     x(i) = (b(i) - A(i, 1:i-1) * x(1:i-1) - A(i, i+1:n) * x_prev(i+1:n)) / A(i, i); % Gauss-Seidel lépés
    % end

    % Konvergencia ellenőrzése
    if norm(x - x_prev, inf) < tol
        fprintf('A Gauss-Seidel iteráció konvergált %d lépésben.\n', iteration);
        return;
    end
end

fprintf('A Gauss-Seidel iteráció nem konvergált %d lépésben.\n', maxIterations);
end
