function mtx = affin2(p,q,r,P,Q,R)
% Egy fgv, ami megadja tetszőleges affin transzf. mátrixát
% Bemenet: Háromszög csúcsai és képei koordinátái
% Kimenet: Transzformáció mátrixa
% Példa: affin2([10, 30], [15, 40], [20, 30], [30, 30], [40, 60], [50, 30])

% Van-e 6 db csúcs megadva?
% Ha nincs kérjük be grafikusan
if(nargin ~= 6)
    axis([0,100,0,100]) % Koordináta tengelyek beállítása
    hold on;
    grid on;

    % Csúcsok bekérése
    fprintf('Rajzold meg az eredeti háromszöget:\n');
    p = ginput(1);
    plot(p(1),p(2),'o')
    q = ginput(1);
    plot(q(1),q(2),'o')
    r = ginput(1);
    plot(r(1),r(2),'o')

    % Összekötjük a vonalakat, így látszik a háromszög
    line([p(1) q(1)],[p(2) q(2)],[1 1],'Marker','.','LineStyle','-')
    line([r(1) q(1)],[r(2) q(2)],[1 1],'Marker','.','LineStyle','-')
    line([r(1) p(1)],[r(2) p(2)],[1 1],'Marker','.','LineStyle','-')

    % Csúcsok képeinek bekérése
    fprintf('Rajzold meg a transzformált háromszöget:\n');
    P = ginput(1);
    plot(P(1),P(2),'o')
    Q = ginput(1);
    plot(Q(1),Q(2),'o')
    R = ginput(1);
    plot(R(1),R(2),'o')

    % Összekötjük a vonalakat, így látszik a háromszög
    line([P(1) Q(1)],[P(2) Q(2)],[1 1],'Marker','.','LineStyle','-')
    line([R(1) Q(1)],[R(2) Q(2)],[1 1],'Marker','.','LineStyle','-')
    line([R(1) P(1)],[R(2) P(2)],[1 1],'Marker','.','LineStyle','-')
end

% Kirajzoljuk a háromszöget és a transzformáltját
figure;
hold on;
grid on;
plot([p(1) q(1) r(1) p(1)], [p(2) q(2) r(2) p(2)], 'ro-', 'LineWidth', 2);
plot([P(1) Q(1) R(1) P(1)], [P(2) Q(2) R(2) P(2)], 'bo-', 'LineWidth', 2);
legend('Háromszög csúcsai', 'Transzformáció képei', 'Location', 'Best');

% Koordináták kibővítése
p = [p 1];
q = [q 1];
r = [r 1];

P = [P 1];
Q = [Q 1];
R = [R 1];

% Transzformáció mátrixa
mtx = [p', q', r']/[P', Q', R'];
end

