% Пункт 8, построение фаозового портрета нелинейной системы.

buildPhasePortrait();

function buildPhasePortrait()
    syms p;

    Wp = 262 / (p * (0.0065 * p + 1) * (0.03 * p + 1));
    y = Wp;
    
end