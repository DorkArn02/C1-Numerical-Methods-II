function root = newt(f, x0, n)
% Newton-módszer gyökkeresés
% Bemenő paraméterek:
% f - függvény
% x0 - kezdőpont
% n - lépésszám
% Visszatérés: gyök közelítése
% Példa bemenet: newt('sin(x)-2*x+1', 0, 100)
% newt('x^2 - 4', 2, 5)

syms x; % Definiáljuk a szimbolikus változót

% Függvény és derivált definiálása
f_sym = str2sym(f);
df = diff(f_sym, x);

% Newton-módszer
x = x0;
for k = 1:n
    % Newton lépés
    x = x - double(subs(f_sym, x) / subs(df, x));
end

root = x;  % A közelített gyök
end