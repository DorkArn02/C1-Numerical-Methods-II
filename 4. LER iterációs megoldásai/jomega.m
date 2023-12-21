function jomega(A)
% A - lineáris egyenletrendszer mátrixa
% Kimenet:
% Omega paraméter függvényében a sajátértékek abszolútértéke
% Spektrálsugár ábrázolása
% Optimális omega értéke
% Konvergenciatartomány
% Értékek kiíratása eredményként
% Pl.: jomega([3 -2 0; -4 3 -4; 0 -2 3])
% jomega([4 -1 0; -1 4 -1; 0 -1 4])

% Méret ellenőrzése
[n, m] = size(A);
if n ~= m
    error('A mátrixnak négyzetesnek kell lennie.');
end

% A mátrix szétdarabolása
L = tril(A, -1);
U = triu(A, 1);
D = zeros(length(A))+diag(diag(A));

omega = sym("w");

% Átmenet mátrixok meghatározása
BJ1 = -inv(D)*(L+U); %J(1)
BJO = (1-omega)*eye(m)+omega*BJ1; %J(omega)

% Omega paraméter függvényében a sajátértékek abszolútértéke
eigenvalues = eig(BJO);

% Spektrálsugár kiszámítása
spec = max(abs(eigenvalues));

% Ne törölje az előző plotot
hold on;
ylim([0, Inf])
% Sajátértékek abszolútértékének ábrázolása
fplot(abs(eigenvalues(1)));
fplot(abs(eigenvalues(2)));
fplot(abs(eigenvalues(3)));
fplot(spec, 'Color', 'r', 'LineWidth', 1.5);
yline(1, 'Color', 'g')

legend('\lambda_1(\omega)', '\lambda_2(\omega)', '\lambda_3(\omega)', '\omega_{B_{JO}}', 'y=1');

% Konvergenciatartomány meghatározása
omega_values = linspace(0, 2, 1000);
convergence_range = [];
min_spec = Inf;
optim_omega = 0;

for omega = omega_values
    BJO = (1-omega)*eye(m) + omega*BJ1;
    eigenvalues = eig(BJO);
    spec = max(abs(eigenvalues));
    if spec < min_spec
        min_spec = spec;
        optim_omega = omega;
    end
end

for omega = omega_values
    BJO = (1-omega)*eye(m)+omega*BJ1;
    eigenvalues = eig(BJO);
    if all(abs(eigenvalues) < 1)
        convergence_range = [convergence_range, omega];
    end
end

if isempty(convergence_range)
    fprintf("Nem konvergens.\n");
    return
end

xline([min(convergence_range), max(convergence_range)], 'color', 'r', 'LineWidth', 1.5)

% Az optimális omega érték egyenes ábrázolása
plot(optim_omega, 0, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Vörös kör pont
text(optim_omega, -0.05, 'Optimális \omega', 'HorizontalAlignment', 'center');

% Sajátértékek
disp("Konvergencia tartomány");
disp([min(convergence_range), max(convergence_range)]);
fprintf("Optimális omega értéke: %d\n", round(optim_omega));
end
