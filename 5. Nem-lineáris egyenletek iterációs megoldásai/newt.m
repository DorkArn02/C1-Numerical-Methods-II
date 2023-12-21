function root = newt(f, x0, n)
% Newton-módszer gyökkeresés
% Bemenő paraméterek:
% f - függvény
% x0 - kezdőpont
% n - lépésszám
% Visszatérés: gyök közelítése
% Példa bemenet: newt('sin(x)-2*x+1', 0, 100), newt('cos(x)-4*x+2', 0, 100)
% newt('x^2 - 4', 2, 5)

syms x; % Definiáljuk a szimbolikus változót

% Függvény és derivált definiálása
f_sym = str2sym(f); % Szimbolikus kifejezés sztringből
df = diff(f_sym, x); % f'(x_k) nem egyenlő 0-val

% Newton-módszer
x = x0; % x0 tetszőleges valós szám
for k = 1:n
    % Newton lépés x_k+1 = x_k - f(x_k)/f'(x_k)
    % subs szimbólikus helyettesítés
    x = x - double(subs(f_sym, x) / subs(df, x)); 
end

root = x;  % A közelített gyök
end