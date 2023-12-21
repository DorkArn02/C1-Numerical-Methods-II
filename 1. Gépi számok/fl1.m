function result = fl1(vec)
% Gépi szám értékének kiszámítása
% Bemenet: Vektor és részei[előjel mantissza karakterisztika]
% Példa bemenet: [0 1 0 1 0 1 0 1 1 -2]
% Kikötések:
% Mantissza jegyei csak {0, 1} lehetnek
% Gépi szám képlete: -1^e * m * 2^k
% Példa kimenetek:
% [100001| 3] => 4.125
% [10101010| −2] =>  0.166015625
% Visszatér: Gépi szám értéke
% fl1([0 1 0 0 0 0 1 3])

% Vektort adtunk-e meg?
if ~isvector(vec)
    error('Nem vektort adott meg bemenetként.');
end

% Előjelbit
e = vec(1);
% Mantissza
m = vec(2:end-1);
% Karakterisztika
k = vec(end);

% Előjelbit vizsgálata
if e ~= 0 && e ~= 1
    error('Az előjelbit csak 0 vagy 1 lehet.');
end

% Mantissza vizsgálata
if any(m ~= 0 & m ~= 1)
    error('A mantissza csak 0 és 1 közötti számokat tartalmazhat.');
end

% Karakterisztika vizsgálata
if(mod(k, 1) ~= 0)
    error('A karakterisztika csak egész szám lehet.');
end

% tmp = Szumma 1-től t-ig m_j * 2^(-i)
tmp = 0;
for j=2:length(vec)-1
    tmp = tmp + vec(j) * 2^(-(j-1));
end

% Képlet használata
result = (-1)^e * tmp * 2^k;

end
