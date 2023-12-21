function [B] = geninv(A)
% Mátrix általánosított mátrixát elkészítő függvény
% Bemenet: A mátrix
% Kimenet: B általánosított mátrix
% geninv([1 0 2 -1; 2 1 5 0; 3 0 6 -3])
format rat;
% Teljes rangú mátrix
if rank(A) == min(size(A))
    % Négyzetes mátrix
    if size(A,1) == size(A,2)
        B = inv(A);
    end

    % Túlhatározott mátrix
    if size(A,1) > size(A,2)
        B = inv(A'*A)*A';
    end

    % Alulhatározott mátrix
    if size(A,1) < size(A,2)
        B = A'*inv(A*A');
    end
    % Nem teljes rangú mátrix => rangfaktorizáció
else
    %B = pinv(A);

    % F és a G mátrix dimenzióját határozza meg
    r = rank(A);
   
    % A mátrix az mxn-es mátrix
    % A = F*G felbontás, ahol
    % F mxr-es és G rxn-es mátrixok

    % F mátrix - válasszunk r db független oszlopvektort
    [R, RB] = rref(A);
    
    F = zeros(size(A, 1), r);

    for i=1:r
        F(:, i) = A(:, RB(i));
    end
    
    % G mátrix - többi elemet GE-vel számoljuk
    G = zeros(r, size(A, 2));

    for i=1:size(A,2)
        G(:, i) = R(1:r, i);
    end

    Fplus = inv(F'*F)*F';
    Gplus = G'*inv(G*G');

    B = Gplus * Fplus;
end
end