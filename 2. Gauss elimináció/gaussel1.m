function [x] = gaussel1(A, b, p1, p2)
% Kiszámolja a megoldásvektort a megadott értékek alapján GE-val
% Bemenet: A - LER mátrixa, b - jobboldal-vektor
% Kimenet: x - megoldásvektor
% p1 - közbülső mátrixok kiíratása 1 = igen, 0 = nem
% p2 - LU-felbontás kiíratása 1 = igen, 0 = nem
% Alulhatározott -> kevesebb egyenlet, mint ismeretlen
% Túlhatározott -> több egyenlet, mint ismeretlen
% Pl. gaussel1([1 2 -1; 2 -1 3; -1 3 1], [4;3;6], 1, 1) => [1;2;1]
% Pl. gaussel1([3 -7 -2 2; -3 5 1 0; 6 -4 0 -5; -9 5 -5 12],[-9;5;7;11], 0, 1)

% Ha az A mátrix sorainak száma nem egyezik meg b vektoréval
% b oszlopainak száma csak 1 lehet
if size(A,1) ~= size(b,1) || size(b,2) ~= 1
    error('Rossz dimenziók!')
end

% Rang ellenőrzés
if rank(A) ~= min(size(A))
    error('A mátrix nem teljesrangú');
end

% Túlhatározott eset
% Ha A rangja egyenlő [A, b] rangjával akkor létezik egyedi megoldás
% Ha A rangja nem egyenlő [A, b] rangjával akkor nincs egyedi megoldás
% de A\b visszaadja a legkisebb négyzetek megoldását
if size(A, 1) > size(A,2)
    warning("Túlhatározott");
    x = A\b;
    return
end

% Alulhatározott eset
% Bázismegoldás
% Általánosított inverz
if size(A,1) < size(A,2)
    %x = rref([A, b]);
    warning("Alulhatározott");
    format rat; % tört alakban való kiíratás
    x = pinv(A)*b;
    return
end

% n mátrix mérete
% L mátrix főátlójában 1-esek vannak kezdetkor
% U mátrix kezdetben csupa nulla
n = max(size(A));
L = eye(n);
U = zeros(n);

% U mátrix első sora az A első sora
U(1, :) = A(1, :);

% Gauss-elimináció
for k=1:n
    for i=k+1:n
        % pivot elem nem lehet nulla az osztás miatt
        if(A(k,k) == 0)
            error("A GE nem hajtható végre sor és oszlopcsere nélkül.")
        end

        % Együttható meghatározása, amellyel szorozni fogok
        m = A(i,k)/A(k,k);

        % Ezt berakom az L alsó háromszög mátrixba
        L(i, k) = m;

        % i-edik sorból kivonom k-adik sor m-szeresét
        % Így nullázom ki a főátló alatti elemeket...
        A(i,:) = A(i,:) - A(k,:)*m;

        % Közbülső A_i mátrixok kiíratása
        if(p1 == 1)
            fprintf('Közbülső A_%i mátrix\n', k)
            disp(A)
        end

        % b vektor i-edik eleméből kivonom k-adik eleme m-szeresét
        % Ezt azért kell, mert külön megadtuk b vektort nem összevonva
        % A-val
        b(i) = b(i) - b(k)*m;
    end

    % U felső háromszög mátrix adott eleme
    for i=k:n
        U(k, i) = A(k,i);
    end
end

% Visszahelyettesítés, eredményvektor
x = zeros(n,1);

% Az utolsó b vektorbeli elemet elosztom az utolsó diagonális elem
% értékével
x(n) = b(n)/A(n,n);

% Visszafelé haladunk a LER soraiban n-1-edik sortól 1.-ig
for k=n-1:-1:1
    x(k) = (b(k)-A(k,k+1:n)*x(k+1:n))/A(k,k);
end

% LU-felbontás kiíratása
if p2 == 1
    disp('L mátrix:')
    disp(L)
    disp('U mátrix:')
    disp(U)
end
end