function bsplinedraw(coefficients, degree)
% B-Spline függvények megrajzolása az [0;1] intervallumon
% Bemenő paraméterek:
%   coefficients - B-Spline együtthatók
%   degree - B-Spline fokszáma (degree+1: a csomópontok száma)
% Pl.: bsplinedraw([1,2,3], 4)

% Interpolációs pontok
x = linspace(0, 1, 1000);  % Finom felbontású pontok az [0;1] intervallumon

% Létrehozzuk a B-Spline interpolációs splajnt
knots = linspace(0, 1, length(coefficients) + degree - 1);
spline = spmak(knots, coefficients);

% Megrajzoljuk az B-Spline függvényeket az [0;1] intervallumon
y = fnval(spline, x);

plot(x, y, 'r', 'LineWidth', 2);

xlabel('x');
ylabel('B-Spline érték');
title('B-Spline függvények');
grid on;
end

function point = deBoor(k,degree,i,x,knots,ctrlPoints)
if k == 1
    point = ctrlPoints(i);
else
    alpha = (x-knots(i))/(knots(i+degree+1-k)-knots(i));
    point = deBoor(k-1,degree, i-1, x, knots, ctrlPoints)*(1-alpha )+deBoor(k-1,degree, i, x, knots, ctrlPoints)*alpha;
end
end