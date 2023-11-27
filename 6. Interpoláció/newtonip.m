function interpolated_poly = newtonip(x_vals, y_vals)
% Interpolációs polinom Newton-alakja függvény
% Bemenetek:
% x_vals: A bemenő alappontok (vektor)
% y_vals: A bemenő függvényértékek (vektor)
% interpolated_poly: Az interpolációs polinom Newton-alakja
% Kimenet: Int. pol. Newton-alakja

% Ellenőrzés, hogy a bemenő vektorok azonos méretűek legyenek
if length(x_vals) ~= length(y_vals)
    error('A bemenő vektoroknak azonos méretűeknek kell lenniük.');
end

n = length(x_vals); % Az alappontok száma

% Osztott differenciák inicializálása
F = zeros(n, n);
F(:, 1) = y_vals';

% Osztott differenciák kiszámítása
for i = 2:n
    for j = 2:i
        F(i, j) = (F(i, j-1) - F(i-1, j-1)) / (x_vals(i) - x_vals(i-j+1));
    end
end

% Az interpolációs polinom Newton-alakjának létrehozása
syms x;
interpolated_poly = F(1, 1);
for i = 2:n
    term = F(i, i);
    for j = 1:i-1
        term = term * (x - x_vals(j));
    end
    interpolated_poly = interpolated_poly + term;
end

% Az interpolációs polinom kiértékelése és megjelenítése
disp('Az interpolációs polinom:');
disp(interpolated_poly);

% Felhasználói input a további alappontok hozzáadásához
choice = input('Szeretne új alappontot hozzáadni? (igen: 1, nem: 0): ');

while choice == 1
    new_x = input('Adjon meg egy új alappontot (x koordináta): ');
    new_y = input('Adja meg az új alappont függvényértékét (y koordináta): ');

    % Az új alappont hozzáadása az alappont és függvényérték vektorokhoz
    x_vals = [x_vals, new_x];
    y_vals = [y_vals, new_y];

    % Újra futtatjuk az interpolációt az új alapponttal
    n = length(x_vals);
    F = zeros(n, n);
    F(:, 1) = y_vals';
    for i = 2:n
        for j = 2:i
            F(i, j) = (F(i, j-1) - F(i-1, j-1)) / (x_vals(i) - x_vals(i-j+1));
        end
    end

    % Az új interpolációs polinom Newton-alakjának létrehozása
    interpolated_poly = F(1, 1);
    for i = 2:n
        term = F(i, i);
        for j = 1:i-1
            term = term * (x - x_vals(j));
        end
        interpolated_poly = interpolated_poly + term;
    end

    % Az új interpolációs polinom kiértékelése és megjelenítése
    disp('Az interpolációs polinom:');
    disp(interpolated_poly);

    % Újra megkérdezzük a felhasználót, hogy szeretne-e új alappontot hozzáadni
    choice = input('Szeretne új alappontot hozzáadni? (igen: 1, nem: 0): ');
end
end
