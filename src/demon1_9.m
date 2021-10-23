% Пункт 9

function [res] = buildPhaseBorder(Data, CalcData, AdditionalData)    
    buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
        AdditionalData);

    syms w A s;

    a = Data('a');

    q1 = 1 / pi * (pi / 2 + asin(1 - (2 * a) / A) + ...
         2 * (1 - (2 * a) / A) * sqrt((a / A) * (1 - a / A)));

    q2 = (4 / (pi * A)) * (1 - a / A);

    Ws = CalcData('Ws') / exp(-Data('tau') * s);
    Ws = subs(Ws, w * 1i);
    sqr = sqrt(q1 ^ 2 + q2 ^ 2);
    at = q2 / q1;

    Aar = [0.01, 0.05, 0.1, 0.2, 0.5, 1, 10, 20, 100];
    Ln = zeros(size(Aar));
    phi = zeros(size(Aar));
    fprintf("A\t\t|Lн(A)\t\t|phi(A), град.\t\t\n");
    for i = 1:max(size(Aar))
        Ln(i) = vpa(-20 * log10(subs(sqr, A, Aar(i))), 4);
        phi(i) = vpa(180 * (-atan(subs(at, A, Aar(i))) - pi) / pi, 4);
        fprintf("%f\t|%f\t|%f\n", Aar(i), Ln(i), phi(i));
    end

    res = true;
end

function buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
    AdditionalData)
    % Построение ЛАФЧХ
    [n, d] = numden(CalcData('Ws'));

    num = coeffs(n);
    den = coeffs(d);

    numArr = zeros(1);
    denArr = zeros(1, 4); 

    numArr(1) = num(1) / den(1);
    denArr(2) = den(2) / den(1);
    denArr(1) = den(3) / den(1);
    denArr(3) = 1;
    denArr(4) = 0;

    W = tf(numArr, denArr);
    bode(W,1e-1:0.1:1e4); % ЛАФЧХ
    grid on
end

function [Ws] = findTransferFunctionOpened(Data, CalcData, ...
                                            AdditionalData, t, s)
    Ws = (Data('i') * Data('Kcap') * Data('Ky') * Data('Kd') * ...
          Data('Kg') * Data('Rk') * exp(-t * s)) / ... 
         ((Data('Tm') * Data('Te') * s ^ 2 + (Data('Tm') + ...
           Data('Te')) * s + 1) * s);
end