function root = intfel(f, a, b, epsilon)
% Gyökkeresés az intervallum felezéssel
% Bemenő paraméterek:
% f - függvény
% a kezdőpont és b végpont
% epsilon tolerancia, pontosság
% Visszatérés: a gyök közelítése
% Példa bemenet: intfel(@(x) x^2-2, 1, 2, 1/10)

% Ellenőrizzük az intervallumot
if f(a) * f(b) > 0
    error('Az intervallum nem megfelelő. A függvényértékeknek különböző előjelekkel kell rendelkezniük az intervallum végpontjainál.');
end

while (b - a) / 2 > epsilon
    % Intervallum felezése
    c = (a + b) / 2;

    % Ha a középpontban van a gyök, akkor visszaadjuk azt
    if f(c) == 0
        root = c;
        return;
    end

    % Az új intervallum kiválasztása
    if f(c) * f(a) < 0
        b = c;
    else
        a = c;
    end
end

% Az intervallum közepén lévő pontot adjuk vissza
root = (a + b) / 2;
end
