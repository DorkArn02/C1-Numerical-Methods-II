function lnmaprox(polinomFokszama, csomopontokX, csomopontokY, rajz)
% Legkisebb négyzetek módszer approximáció
% Bemeneti paraméterek:
% polinomFokszama - polinom fokszáma
% csomopontokX - x pontjai
% csomopontokY - y pontjai
% rajz - Felhasználó kérése kell-e rajz
% Kimenet: lnmaprox(2, [-2,-1,0,1,2], [-4, -2, 1, 2, 4], 1)

% Ellenőrizzük, hogy a bemeneti vektorok mérete azonos-e
if numel(csomopontokX) ~= numel(csomopontokY)
    error('A csomopontokX és csomopontokY vektoroknak azonos méretűeknek kell lenniük.');
end

% Legkisebb négyzetek módszere a polinomra
% Polinom illesztése
coefficients = polyfit(csomopontokX, csomopontokY, polinomFokszama);

% Kiszámítjuk a közelítő polinom értékeit az adott csomópontoknál
% Polinom kiértékelése
fittedPolynomial = polyval(coefficients, csomopontokX);

% Kiírjuk a közelítő polinom együtthatóit
fprintf('Közelítő polinom együtthatói:\n');
disp(coefficients);

% Ábra létrehozása
if rajz == 1
    figure;
    plot(csomopontokX, csomopontokY, 'b*', 'MarkerSize', 10); % Eredeti pontok kék pontokkal
    hold on;
    plot(csomopontokX, fittedPolynomial, 'r-', 'LineWidth', 2); % Közelítő polinom piros vonallal
    xlabel('X tengely');
    ylabel('Y tengely');
    title('Legkisebb négyzetek módszerével közelített polinom');
    legend('Adatpontok', 'Közelítő polinom');
    grid on;
    hold off;
end
end
