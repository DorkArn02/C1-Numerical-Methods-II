function [M] = affin1(a1,a2)
% Tetszőleges, origót fixen hagyó affin transzformáció mátrixa
% Bemenő paraméterek: a (0; 1) és (1; 0) pontok képei a transzformációban.
% Visszatérési érték: a transzformáció mátrixa.
% Példa bemenet: affin1([1,2], [3,4])

% Affin transzformáció = A sík (a tér) önmagába való egyenestartó
% transzformációját affin transzformációnak nevezzük

%      ([a]  [c])
%affin1([b], [d])

% M = [a c]
%     [b d]
switch nargin
    % Ha a user megadja a két pontot
    case 2
        M = zeros(2);
        M(1,1) = a1(1);
        M(1,2) = a2(1);
        M(2,1) = a1(2);
        M(2,2) = a2(2);
        % Ha nem ad be pontot grafikusan kérje be
    case 0
        line([-8,8],[0,0]);
        line([0,0],[-8,8]);
        [x,y] = ginput(2);
        M(1,1) = x(1);
        M(2,1) = y(1);
        M(1,2) = x(2);
        M(2,2) = y(2);
        % Más esetben pedig hiba
    otherwise
        disp('Hiba!');
end
end