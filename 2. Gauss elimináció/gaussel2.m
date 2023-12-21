function [x] = gaussel2(A, b, p1, p2)
% Részleges/Teljes főelemkiválasztás Gauss-eliminációval
% Bemenet: A mátrix és b vektor
% p1 = 0 akkor részleges, p1 = 1 akkor teljes főelem kiv.
% p2 = 0 akkor nem íratjuk ki a közbeeső mátrixok egyébként igen
% Visszatérés: x megoldásvektor
% Pl.: gaussel2([1 -1 2; 2 3 1; 3 2 1], [3;5;8], 1, 1) => [2.8, -0.2, 0]
% Pl.: gaussel2([2 1 3; 4 4 7; 2 5 9], [1;1;3], 0, 0) => [-0.5, -1, 1]

% Részleges főelemkiválasztást válaszott a felhasználó
if p1 == 0
    % n mátrix mérete
    n = max(size(A));
    A = [A, b];

    % Gauss-elimináció
    for k=1:n
        % Részleges főelemkiválasztás
        [~,maxindex] = max(abs(A(k:n,k)));
        sorindex = maxindex(1);
        % Kell sorcsere
        if sorindex > k
            sor = A(sorindex,:);
            A(sorindex,:) = A(k,:);
            A(k,:) = sor;
            fprintf('A(z) %d. és %d. sor cseréje:\n', k, sorindex);
            disp(A);
        end
        for i=k+1:n
            % pivot elem nem lehet nulla az osztás miatt
            if(A(k,k) == 0)
                warning("A főelem = 0, tehát nem hajtható végre a GE részleges főelemkiválasztással.");
                warning("Továbblépés teljes főelem kiválasztással");
                x = teljesFoelemKiv(A, b);
                return
            end

            % Együttható meghatározása, amellyel szorozni fogok
            m = A(i,k)/A(k,k);

            % i-edik sorból kivonom k-adik sor m-szeresét
            % Így nullázom ki a főátló alatti elemeket...
            A(i,:) = A(i,:) - A(k,:)*m;

            % Közbülső A_i mátrixok kiíratása
            if(p2 == 1)
                fprintf('Közbülső A_%i mátrix\n', k)
                disp(A)
            end

            % b vektor i-edik eleméből kivonom k-adik eleme m-szeresét
            % Ezt azért kell, mert külön megadtuk b vektort nem összevonva
            % A-val
            b(i) = b(i) - b(k)*m;
        end
    end

    % Visszahelyettesítés, eredményvektor
    x = zeros(n,1);

    % Az utolsó b vektorbeli elemet elosztom az utolsó diagonális elem
    % értékével
    x(n) = A(n, n+1)/A(n,n);

    % Visszafelé haladunk a LER soraiban n-1-edik sortól 1.-ig
    for k=n-1:-1:1
        x(k)=A(k,n+1);
        for j=k+1:n
            x(k)=x(k)-A(k,j)*x(j);
        end
        x(k)=x(k)/A(k,k);
    end
else
    % Teljes főelemkiválasztást választott a felhasználó
    x = teljesFoelemKiv(A, b, p2);
end
end

function [x]= teljesFoelemKiv(A, b, p2)
% n mátrix mérete
n = max(size(A));
A = [A, b];
% Gauss-elimináció
for k=1:n
    % Teljes főelemkiválasztás
    % Sor- és oszlopcsere engedélyezett
    [maxc, maxindex] = max(abs(A(k:n,k)));
    [~, colindex] = max(maxc);
    sorindex = maxindex(1);
    oszlopindex = colindex(1);

    % Kell sorcsere
    if sorindex > k
        sor = A(sorindex,:);
        A(sorindex,:) = A(k,:);
        A(k,:) = sor;
        %fprintf('A(z) %d. és %d. sor cseréje:\n', k, sorindex);
    end

    % Kell oszlopcsere
    if oszlopindex > k
        oszlop = A(:,oszlopindex);
        A(:,oszlopindex) = A(:,k);
        A(:,k) = oszlop;
    end
    if sorindex>k && oszlopindex==k
        fprintf('A(z) %d. és %d. sor cseréje:\n',k,sorindex);
        disp(A);
    elseif  sorindex==k && oszlopindex>k
        fprintf('A(z) %d. és %d. oszlop cseréje:\n',k,oszlopindex);
        disp(A);
    elseif  sorindex>k && oszlopindex>k
        fprintf('A(z) %d. és %d. sor, %d. és %d. oszlop cseréje:\n',k,sorindex,k,oszlopindex);
        disp(A);
    end
    for i=k+1:n
        % pivot elem nem lehet nulla az osztás miatt
        if(A(k,k) == 0)
            error("A főelem = 0, tehát nem hajtható végre a GE.")
        end

        % Együttható meghatározása, amellyel szorozni fogok
        m = A(i,k)/A(k,k);

        % i-edik sorból kivonom k-adik sor m-szeresét
        % Így nullázom ki a főátló alatti elemeket...
        A(i,:) = A(i,:) - A(k,:)*m;

        % Közbülső A_i mátrixok kiíratása
        if(p2 == 1)
            fprintf('Közbülső A_%i mátrix\n', k)
            disp(A)
        end

        % b vektor i-edik eleméből kivonom k-adik eleme m-szeresét
        % Ezt azért kell, mert külön megadtuk b vektort nem összevonva
        % A-val
        b(i) = b(i) - b(k)*m;
    end
end

% Visszahelyettesítés, eredményvektor
x = zeros(n,1);

% Az utolsó b vektorbeli elemet elosztom az utolsó diagonális elem
% értékével
x(n) = A(n, n+1)/A(n,n);

% Visszafelé haladunk a LER soraiban n-1-edik sortól 1.-ig
for k=n-1:-1:1
    x(k)=A(k,n+1);
    for j=k+1:n
        x(k)=x(k)-A(k,j)*x(j);
    end
    x(k)=x(k)/A(k,k);
end
end