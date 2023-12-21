function [Q,R] = gramschmidt(A)
% QR-felbontás elvégzése Gram-Schmidt ortogonalizációval
% Bemenet: A - négyzetes mátrix, amelyre teljesül: A = Q * R
% Kimenet: Q - ortogonális mátrix és R - felső-háromszög mátrix
% Példa bemenet: gramschmidt([2 5 4; 6 8 0; 3 -3 2])
% [Q, R] = gramschmidt([4 1 8; 0 0 2; 3 7 6])
% [Q, R] = gramschmidt([-1 2 5; 0 1 2; 1 2 3])

[m,n] = size(A);

% Dimenziók ellenőrzése
if m ~= n
    error("A mátrix nem négyzetes!");
end

% Mátrixnak teljes oszloprangúnak kell lennie
if rank(A) ~= size(A, 2)
    error("A mátrix nem teljes oszloprangú!");
end

Q = zeros(n, m);
R = zeros(m, m);

% Az algoritmus elindul n db független oszlopvektorral (A oszlopai)
% Az algoritmus generál n db ortonormált vektort q1, ..., qn (Q oszlopai)
for k=1:n
    Q(:,k) = A(:,k);
    for j=1:k-1
        % 1-től k-1-ig megy és elkészíti a skaláris szorzatokat
        % Q mtx j-edik oszlopának és az A mtx k-adik oszlopának skaláris
        % szorzása
        % Q mtx k-adik oszlopa egyenlő k-adik oszlopából kivonva az előbbi
        % érték szor Q mátrix j-edik oszlopa
        R(j,k) = Q(:,j)'*A(:,k); % r_jk = (q_j, a_k)
        Q(:,k) = Q(:,k) - R(j,k)*Q(:,j); % q_k = q_k - r_1k*q_1 - ... - r_jk * q_j
    end

    % Norma számításhoz lehet használni beépített függvényt
    R(k,k) = norm(Q(:,k)); % r_kk = ||q_k|| Q mtx k-adik oszlopa
    
    % Q mátrix normalizálása
    Q(:,k) = Q(:,k)/R(k,k); % q_k = q_k / r_kk 
end
end