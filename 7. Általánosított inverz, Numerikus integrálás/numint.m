function result = numint(integrand, a, b, n, method)
% Numerikus integrálást elvégző függvény
% Integrand - az integrandus
% a - bal végpont
% b - jobb végpont
% n - osztópontok száma
% method - használt módszer
% Kimenet: Numerikus integrálás eredménye
% Pl. numint('x^2+2*x', 0, 3, 10, 'rectangle')

func = str2func(['@(x) ' integrand]);
if strcmpi(method, 'rectangle')
    result = (b-a)*func((a+b)/2);
elseif strcmpi(method, 'trapezoid')
    result = (b-a)/2 * (func(a)+func(b));
elseif strcmpi(method, 'simpson')
    if mod(n, 2) ~= 0
        error('A Simpson módszerhez páros számú osztópont szükséges.');
    end
    result = (b-a)/6 * (func(a)+4*func((a+b)/2)+func(b));
else
    error('Ismeretlen kvadratúraforma. Választható: rectangle, trapezoid, simpson');
end
end