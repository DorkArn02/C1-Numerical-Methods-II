function [Q,R] = hhalg(A)
% QR-felbontás Householder transzformációval
% Bemenő paraméter: A négyzetes mátrix
% Kimenő paraméterek: Q és R mátrix

[m,n] = size(A);

% Dimenziók ellenőrzése
if(m ~= n)
    error("A bemenő mátrix nem négyzetes!");
end

% Kezdéértékek beállítása
R = A;
Q = eye(m);
I = eye(m);

% 1-től m-1-ig megyünk
for k=1:m-1
    x = R(k:m,k);

    % Householder transzformáció létrehozása
    v = -sign(x(1)) * norm(x) * eye(m-k+1, 1) - x;

    if norm(v) > 0
        v = v / norm(v);
        H = I;
        H(k:m, k:m) = H(k:m, k:m) - 2 * (v * v');

        % R mátrix aktualizálása
        R = H * R;

        % Q mátrix aktualizálása
        Q = Q * H;
    end
end
end
