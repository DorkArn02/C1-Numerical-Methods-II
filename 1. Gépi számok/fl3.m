function result = fl3(varargin)
% Valós számok gépi alakját kiszámoló függvény
% Bemenet: M(t, k1, k2) gépi számhalmaz és number valós szám
% Megkötések:
% t természetes szám, k1, k2 egészek és k1 < k2
% Kimenet: Gépi szám alakja a valós számnak
% Példa: M(5, -3, 4) és a számok: 4.18, 10.85, sqrt(2), 1/10, -1/3

% Ha csak egy számot adunk meg, akkor használjuk a feladatban leírtakat
if nargin == 1
    t = 8;
    k1 = -5;
    k2 = 5;
    number = varargin{1};
else
    t = varargin{1};
    k1 = varargin{2};
    k2 = varargin{3};
    number = varargin{4};
end

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

% Ha negatív számot adunk meg akkor kezeljük pozitívként, de a végén
% előjelbit 1 lesz
e = 0;
if number < 0
    number = number * -1;
    e = 1;
end

% Számhalmaz határai
eps_0 = 2^(k1-1);
m_inf = (1-2^(-t))*2^k2;

% Ábrázolható-e a szám ezen halmazon belül?
if number > m_inf || number < eps_0
    error('Nem ábrázolható a szám ezen halmazon belül.');
end

% Mantissza binárisban
mantissa = dec2bin(number, t);

% Ha egész számot adunk meg
if mod(number, 1) == 0

    % Mantissza sztring
    mantissa_str = num2str(mantissa);
    % Keresd meg az első 1-gyes pozícióját a szövegben
    % Normalizálás
    % Pl. 001 akkor 100 legyen és karakterisztika csökkentése
    elso_egyes_index = strfind(mantissa_str, '1');

    % Első 1-gyes és az utáni számjegyek
    item = mantissa_str(elso_egyes_index(1):end);

    % Mennyi 0 van az első egyes előtt
    i = length(mantissa_str(1:elso_egyes_index(1)-1));
    szam = strcat(item, repmat('0', 1, i));

    % Rakjuk össze egy vektorba a számokat
    % Levonjuk a karakterisztikából, hogy mennyi nulla volt az első
    % előtt
    result = [num2str(e), szam, num2str(strlength(mantissa)-i)];

    % Ha tört számot adunk meg
else
    % Egészrész és törtrész meghatározása a számból
    egesz = dec2bin(floor(number));
    tort = number-floor(number);

    % Törtrész kiolvasása lefelé
    tmp = '';

    % Törtrész meghatározása
    % 1-nél kisebb törtek esetén
    if egesz == '0'
        % Segédváltozók
        kt = 0; % kt menjen t+1-ig
        xx = 0; % 1-nél kisebb törtek esetén ennyit vonunk ki a kar.
        % Első 1-gyes előfordulása igaz/hamis
        firstOne = 0;
        while kt ~= t+1
            tort = tort * 2;
            if tort >= 1
                tmp = strcat(tmp, '1');
                tort = tort - 1;
                firstOne = 1;
                kt = kt + 1;
            else
                if firstOne == 1
                    tmp = strcat(tmp, '0');
                    kt = kt + 1;
                else
                    xx = xx + 1;
                end
            end
        end

        % 1. >= törtek
    else
        for k=1:(t-strlength(egesz)+1)
            tort = tort * 2;
            if tort >= 1 % 1.00 felett pl 1.4-1=0.4 és utána azzal tovább
                tmp = strcat(tmp, '1');
                tort = tort - 1;
            else
                tmp = strcat(tmp, '0');
            end
        end
    end
    % Kerekítés eldöntése
    % Ha az egész rész 0 akkor
    if egesz == '0'
        combined = num2str(tmp);
        % t + 1 jegy a kerekítésre
        if combined(t+1) == '1'
            combined = combined(1:t);
            tmp2 = bin2dec(combined);
            tmp2 = tmp2 + 1;
            fontos = num2str(dec2bin(tmp2));
        else
            fontos = combined(1:t);
        end
    else

        combined = strcat(num2str(egesz), num2str(tmp));

        if combined(t+1) == '1'
            combined = combined(1:t);
            tmp2 = bin2dec(combined);
            tmp2 = tmp2 + 1;
            fontos = num2str(dec2bin(tmp2));
        else
            fontos = combined(1:t);
        end
    end

    % Normalizálás
    elso_egyes_index = strfind(fontos, '1');
    item = fontos(elso_egyes_index(1):end);
    i = length(fontos(1:elso_egyes_index(1)-1));
    fontos = strcat(item, repmat('0', 1, i));

    if egesz == '0'
        result = [num2str(e), fontos, num2str(0-xx)];
    else
        result = [num2str(e), fontos, num2str(strlength(egesz)-i)];
    end
end
end
