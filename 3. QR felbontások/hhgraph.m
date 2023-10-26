function hhgraph()
% Bemenet: Grafikus input p1 és p2
% Kimenet: Hipersík és pont képe

% Grafikus pontok bekérése
hold on;
grid on;
axis([0,10,0,10]);

% Két pont bekérése és ábrázolása
[x1,y1] = ginput(1);
x1 = round(x1);
y1 = round(y1);

plot(x1,y1,'ob');

% Kör rajzolása az első pont köré
radius = norm([x1, y1]); % Az első pont és az origó távolsága
theta = linspace(0, 2 * pi, 100);
x = radius * cos(theta) + x1;
y = radius * sin(theta) + y1;
plot(x, y, '--g'); % Zöld szaggatott vonal az első pont körül
axis equal;

[x2,y2] = ginput(1);
x2 = round(x2);
y2 = round(y2);

plot(x2,y2, 'or');

%disp(norm([x1, y1], 2));
%disp(norm([x2, y2], 2));

% Householder transzformáció
H = householder([x1, y1], [x2, y2]);

v = [x2-x1; y2-y1];
v_tukrozott = H * v;

% Tükörzött pont kinyerése
x_tukrozott = v_tukrozott(1);
y_tukrozott = v_tukrozott(2);

plot(x_tukrozott, y_tukrozott, 'og'); % Zöld pont a tükörzött pontra

% Egyenes ábrázolása, ami a tükröző hipersíkot jelképezi
d = [x2 - x1, y2 - y1];
m = (x1 + x2) / 2;
n = (y1 + y2) / 2;
x = linspace(0, 10, 100);
y = (-d(1) / d(2)) * (x - m) + n;
plot(x, y, '-c'); % Kék egyenes a tükröző hipersík

end