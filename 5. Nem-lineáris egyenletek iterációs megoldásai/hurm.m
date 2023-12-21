function root = hurm(f, a, b, n, grafikon)
% Húrmódszerrel gyökkeresés
% Bemenő paraméterek:
% f - függvény
% a, b kezdő- és végpont
% n - lépésszám
% grafikon 0 nem, 1 igen rajzolunk
% Kimenő paraméter: gyök közelítése
% Példa bemenet: hurm(@(x) x.^2-2, 1, 2, 10, 1)

% Ellenőrizzük az intervallumot
if f(a) * f(b) > 0
    error('Az intervallum nem megfelelő. A függvényértékeknek különböző előjelekkel kell rendelkezniük az intervallum végpontjainál.');
end

% Húrmódszer
for k = 1:n
    % Húr közepének kiszámítása
    c = (a * f(b) - b * f(a)) / (f(b) - f(a));

    % Gyök találatának ellenőrzése
    if f(c) == 0
        root = c;
        return;
    end

    % Az intervallum aktualizálása
    if f(c) * f(a) < 0
        b = c;
    else
        a = c;
    end
end

root = c;  % A közelített gyök
% Grafikon készítése
if grafikon
    figure;
    fplot(f, 'LineWidth', 2);
    hold on;
    plot(root, f(root), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    title('Húrmódszerrel keresett gyök');
    xlabel('x');
    ylabel('f(x)');
    grid on;
    legend('Függvény', 'Közelített gyök');
end
end