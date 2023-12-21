function [Q,R] = hhalg(A)
% QR-felbontás Householder transzformációval
% Bemenő paraméter: A négyzetes mátrix
% Kimenő paraméterek: Q és R mátrix
format default
[m,n] = size(A);

% Dimenziók ellenőrzése
if(m ~= n)
    error("A bemenő mátrix nem négyzetes!");
end

% Mátrixnak teljes oszloprangúnak kell lennie
if rank(A) ~= size(A, 2)
    error("A mátrix nem teljes oszloprangú!");
end

% Kezdéértékek beállítása
R = A;
Q = eye(m);
I = eye(m);

% 1-től m-1-ig megyünk (oszloponként alkalmazzuk a transzformációt)
for k=1:m-1
    x = R(k:m,k);

    % Householder transzformáció létrehozása
    % v = -sgn(x_1)*||x||*e_1-x
    v = -sign(x(1)) * norm(x) * eye(m-k+1, 1) - x;

    % Vektor hossza így > 0
    if norm(v) > 0
        v = v / norm(v);
        H = I;

        % H = I - 2vv'
        H(k:m, k:m) = H(k:m, k:m) - 2 * (v * v');

        % R mátrix aktualizálása
        R = H * R;

        % Q mátrix aktualizálása
        Q = Q * H;
    end
end
end
