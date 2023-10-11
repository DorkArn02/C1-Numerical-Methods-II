function fl2(t, k1, k2)
% M(t, k1, k2) gépi számhalmaz elemeit ábrázolja a valós számegyenesen
% Bemenet: t - a mantissza hossza, k1, k2 legkisebb és
% legnagyobb karakterisztika
% Megkötések:
% t term. szám és k1, k2 egészek és k1 < k2
% Példa kimenet: M(5, −4, 4) Számegyenes, m_inf = 15.5 és eps_0 = 0.03125
% Visszatér: számhalmaz elemei számegyenesen ábrázolva

% Mantissza hossz vizsgálata
if mod(t, 1) ~= 0 || t <= 0
    error('t csak természetes szám lehet,');
end

% Karakterisztika vizsgálata
if mod(k1, 1) ~=0 || mod(k2, 1) ~= 0
    error('k1 és k2 csak egész szám lehet.');
end

% Karakterisztika vizsgálata
if k1 >= k2
    error('k1-nek kisebbnek kell lennie, mint k2.');
end

% Számhalmaz nevezetes elemei
% Legkisebb gépi szám, attól 1-gyel nagyobb gépi szám és a legnagyobb
eps_0 = 2^(k1-1);
eps_1 = 2^(-t+1);
m_inf = (1-2^(-t))*2^k2;

% Számhalmaz elemszáma
num = 2^t * (k2 - k1 + 1);

% elemszám x 1-gyes tömb nullákkal feltöltve
elements = zeros(num, 1);
index = 1;

% Számhalmaz elemeinek meghatározása fl1 segítségével
for e = [0, 1]
    for k = k1:k2
        for mantissa = 0:2^t-1
            % mantissza binárissá alakítása
            mantissa_str = dec2bin(mantissa, t);

            % 0-k és 1-k után rakjunk vesszőket
            mantissa_str = strrep(mantissa_str, '0', '0,');
            mantissa_str = strrep(mantissa_str, '1', '1,');

            % Pl. 0, 0, 0, 1, és
            % Utolsó vessző eltávolítása
            mantissa_str = mantissa_str(1:end-1);

            % Előjelbit, mantissza, karakterisztika egy vektorban
            machine_number = [e, str2num(mantissa_str), k];

            % fl1 függvénnyel kiszámoljuk a gépi szám értékét
            elements(index) = fl1(machine_number);

            % Megyünk a következő számra
            index = index + 1;
        end
    end
end

% Rajz készítése
figure;

% Ne írja felül minden egyes rajzoláskor
hold on;

% Kiemelt elemeket piros színnel írja ki
plot([eps_0, eps_1, m_inf], zeros(3), 'rX', 'markersize', 15);

% Többi elem kiíratása
stem(elements, zeros(size(elements)), 'b.');

% Cím
title('Számhalmaz elemei');

% Rács
grid on;
end