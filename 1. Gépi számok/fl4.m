function result = fl4(n1, n2)
% Két gépi szám összegét kiszámoló függvény
% Bemenet: n1 és n2 gépi számok
% Kimenet: Két gépi szám összege
% Példa: [11010|2]+[10010|2]=[10110|3] (nem írom ki előjelbitet ezeknél)
% Példa: [11010|2]+[11010|2]=[11010|3]
% Példa: [01101|3]+[10110|3]=[10010|4]
% Példa: [10110|3]+[11010|2]=[10010|4]
% 0100001 + 0111104

if ~isvector(n1) || ~isvector(n2)
    error('n1 és n2 csak vektor lehet.');
end

% Előjelbitek
n1_e = n1(1);
n2_e = n2(1);

if (n1_e ~= 0 && n1_e ~= 1) || (n2_e ~= 0 && n2_e ~= 1)
    error('Az előjelbit csak 0 és 1 lehet.');
end

if n1_e == 1 || n2_e == 1
    error('Nem összeadásról van szó.');
end

% Mantisszák
n1_m = n1(2:end-1);
n2_m = n2(2:end-1);

if length(n1_m) ~= length(n2_m)
    error('A két gépi szám nem ugyanabból a számhalmazból valóak.');
end

% Mantissza vizsgálata
if any(n1_m ~= 0 & n1_m ~= 1)
    error('A mantissza csak 0 és 1 közötti számokat tartalmazhat.');
end

if any(n2_m ~= 0 & n2_m ~= 1)
    error('A mantissza csak 0 és 1 közötti számokat tartalmazhat.');
end

% Karakterisztikák
n1_k = n1(end);
n2_k = n2(end);

% Karakterisztika vizsgálata
if(mod(n1_k, 1) ~= 0)
    error('A karakterisztika csak egész szám lehet.');
end

if(mod(n2_k, 1) ~= 0)
    error('A karakterisztika csak egész szám lehet.');
end

% Közös karakterisztikára kell-e hozni?
if n1_k ~= n2_k
    b_k = n1_k > n2_k; % nagyobb karakterisztika
    if b_k == 1
        % n2_m shiftelése balra
        b_k = n1_k;
        tmp = n1_k-n2_k;
        n2_m = [zeros(1, tmp), n2_m(1:end-(tmp))];
    else
        % n1_m shiftelése balra
        b_k = n2_k;
        tmp = n2_k-n1_k;
        n1_m = [zeros(1, tmp), n1_m(1:end-(tmp))];
    end

    % Számok összeadása binárisan
    res = binaryAddition(n1_m, n2_m);
    % Normalizálás megnézése
    [normalized, kar] = normalize(length(n1_m), res, b_k, n1_m);
    normalized = sprintf("%d", normalized);
    result = [num2str(n1_e), num2str(normalized), num2str(kar)];
else
    % Számok összeadása binárisan
    res = binaryAddition(n1_m, n2_m);
    % Normalizálás megnézése
    % n1_k és n2_k ugyanaz tehát mindegy melyiket adom meg
    [normalized, kar] = normalize(length(n1_m), res, n1_k, n1_m);
    normalized = sprintf("%d", normalized);
    result = [num2str(n1_e), num2str(normalized), num2str(kar)];
end
end

function [normalized, kar] = normalize(t, number, k, orig)
% Bináris szám normalizálása
if length(number) > t
    % Kell-e kerekíteni?
    if number(end) == 1
        aa = zeros(1, t);
        % Kell tömbként megadni az 1-et binárisan pl. 00001
        aa(t) = 1;
        normalized = binaryAddition(number(1:t), aa);
        kar = k + (length(number)-length(orig));
    else
        normalized = number(1:t);
        kar = k + (length(number)-length(orig));
    end
else
    normalized = number;
    kar = k;
end
end

function resultBin = binaryAddition(n1_m, n2_m)
% Két bináris szám összegét adja vissza
% Átvitel (carry) kezdetben nulla
carry = 0;

% Az eredmény bináris száma
result = zeros(size(n1_m));

% Bitenkénti összeadás
for i = length(n1_m):-1:1
    bit1 = n1_m(i);
    bit2 = n2_m(i);
    osszeg = bit1 + bit2 + carry;
    if osszeg >= 2
        carry = 1;
        osszeg = mod(osszeg, 2);
    else
        carry = 0;
    end
    result(i) = osszeg;
end
% Ha a ciklus után még van átvitel, hozzáadjuk az eredményhez
if carry
    result = [1, result];
end

% Az eredmény
resultBin = result;
end