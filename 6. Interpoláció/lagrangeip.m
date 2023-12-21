function F = lagrangeip(x, y, graf)
% Lagrange-interpoláció függvény
% Bemenet: alappontok x és függvényértékek y és graf 0 nincs rajz, 1 van rajz
% Kimenet: Interpolációs polinom L. alakja
% Példa bemenet: lagrangeip([1, 4, 9],[1, 2, 3], 1)
% lagrangeip([-2,2,-1, 0],[27,19,10, 3], 1)

% Pl.:
% l_0(x) = (x-4)(x-9)/(1-4)(1-9)=1/24 (x-4)(x-9) 
% l_1(x) = (x-1)(x-9)/(4-1)(4-9)=-1/15 (x-1)(x-9) 
% l_2(x) = (x-1)(x-4)/(9-1)(9-4)=1/40 (x-1)(x-4) 
% L2(x) = 1*l_0(x)+2*l_1(x)+3*l_2(x)

n = length(x);

if n ~= length(y)
    error('x és y vektorok dimenziója nem azonos');
end

% Szimbolikus változó a Lagrange-polimom kifejezéséhez
syms X;

% Lagrange polinom kifejezése
% l_k(x) = 0-tól n-ig és i != k (x-x_i)/(x_k-x_i) k=0,...,n
P = 0;
for k = 1:n
    lk = 1;
    for i = 1:n
        if i ~= k
            lk = lk * (X - x(i)) / (x(k) - x(i));
        end
    end
    % L_n(x) = k=0-tól n-ig y_k*l_k(x) = P_n(x)
    P = P + y(k) * lk;
end
% Interpolációs polinom Lagrange-alakja
F = simplify(sum(P));

% Csináljunk rajzot
if graf==1
    plot(x,y,'ro','MarkerSize',10,'LineWidth',1.5);
    grid;
    hold on;
    plot(x,subs(F,x),'LineWidth',1);
    xlabel('X'), ylabel('Y'), title('Lagrange Form');
end
end
