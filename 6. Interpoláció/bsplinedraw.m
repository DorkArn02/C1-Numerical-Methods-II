function bsplinedraw(indices)
% Intervallum felosztása [0,1] között
t = linspace(0, 5, 1000); % Itt át kell írni 1-re, csak szemléltetés miatt 5

% B-spline függvények inicializálása 0-kal
bspFns = zeros(length(indices), length(t));

% B-spline függvények kiszámítása
for i = 1:length(indices)
    bspFns(i, :) = bspline_basis(indices(i), t);
end

% B-spline függvények kirajzolása
figure;
hold on;
for i = 1:length(indices)
    plot(t, bspFns(i, :), 'LineWidth', 2);
end
title('B-Spline Függvények');
xlabel('t');
ylabel('B-spline(t)');
legend(cellstr(num2str(indices', 'B_{%d}')));
grid on;
hold off;
end

function result = bspline_basis(k, t)
% k - B-Spline fokszáma
% t - ahol ki szeretnénk értékelni a függvényt azok a helyek
% B-spline alapfüggvény kiszámítása
result = zeros(size(t));

for i = 1:length(t)
    result(i) = bspline_recursive(k, 0, t(i));
end
end

function result = bspline_recursive(k, l, t)
% k - B-Spline fokszáma
% l - Ahonnan szeretnénk kezdeni a kiértékelést (alapfüggvénynél ez x=0)
% t - kiértékelés helye, egy szám a [0, 1] intervallumból
% Rekurzív B-spline alapfüggvény kiszámítása
% Ha a B-spline fok (k) 0, akkor az alapfüggvény egyszerűen 0 vagy 1 értéket vesz fel
if k == 0
    % Az alapfüggvény értékét 0-nak vagy 1-nek állítjuk be attól függően, hogy t a [l, l+1) tartományban van-e
    if l <= t && t < l + 1
        result = 1;
    else
        result = 0;
    end
else
    % Ha a B-spline fok (k) nem 0, akkor az alapfüggvény rekurzív számítása
    % A rekurzió két részből áll: egy bal oldali és egy jobb oldali részből
    % A bal oldali rész a jelenlegi szakaszban (l) lévő alapfüggvény értékeit számolja ki
    % A jobb oldali rész a következő szakaszban (l+1) lévő alapfüggvény értékeit számolja ki
    result = (t - l) / k * bspline_recursive(k - 1, l, t) + ...
        (l + k + 1 - t) / k * bspline_recursive(k - 1, l + 1, t);
end
end

