function [B] = geninv(A)
% Mátrix általánosított mátrixát elkészítő függvény
% Bemenet: A mátrix
% Kimenet: B általánosított mátrix
% geninv([1 0 2 -1; 2 1 5 0; 3 0 6 -3])

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
    B = pinv(A);
end
end