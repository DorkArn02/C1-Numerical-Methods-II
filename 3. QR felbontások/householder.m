function [H] = householder(p1, p2)
% Ez a függvény megadja egy Householder transzformáció mátrixát, ha
% ismerünk egy pontot és a képét
% Bemenő paraméterek: pont és képe
% Kimenő paraméter: Householder-transzformáció mátrixa
% Példa: householder([6;2;3;0], [4;2;5;2])
% householder([1;2;3], [1;1;1])

% Egyenlő hosszúak-e
if length(p1) ~= length(p2)
    error('A vektorok hossza nem azonos.');
end

% Létezik-e ilyen Householder-transzformáció
if (p1 == p2) | (norm(p1, 2) ~= norm(p2, 2))
    error("Nincs ilyen Householder-transzformáció.")
end

% p1 az egy oszlopvektor
% p = p1 - p2 / 2-es normája a p1 - p2-nek

p = p1 - p2;

% Szigma meghatározása
sigma = -sign(p(1))*norm(p, 2);

% Kanonikus egységvektor
tmp = zeros(length(p), 1);
tmp(1) = 1;

a = p - sigma * tmp;

v = a / norm(a, 2);

% Householder-mátrix
% Szimmetrikus és ortogonális mátrix
H = eye(length(p), length(p)) - 2*(v*v');

end