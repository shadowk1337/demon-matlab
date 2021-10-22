% Пункт 7, исследование системы по критериям Рауса и Михайлова или по
% по критериям Гурвица и Найквиста. 

findSystemStability();

function findSystemStability(Data, CalcData, AdditionalData)
    buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
        AdditionalData);

    choice = input("y - решить по критериям Рауса и Михайлова/ " + ...
                   "n - решить по критериям Гурвица и Найквиста" + ...
                   " [y/n]: ", 's');

    if (ischar(choice) && lower(choice) == 'y')
        rouseCriteria(Data, CalcData, AdditionalData);
        mikhailovCriteria(Data, CalcData, AdditionalData);
    else
        hurwitzCriteria(Data, CalcData, AdditionalData);
        nyquistCriteria(Data, CalcData, AdditionalData);
    end
end

function buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
    AdditionalData)
    syms s;

    Ws = (365.62*exp(-0.009*s))/(s*(0.00036*s^2 + 0.049*s + 1.0));
    [n, d] = numden(Ws);
    div = d(3);
    num = num(1) / div;
    den(1) = d(1) / div;
    den(2) = d(2) / div;
    den(3) = 1;
%     W = tf(365.62, [0.00036, 0.049, 1, 0]);
    disp(num);
    disp(den);
    W = tf(num, den);
    bode(W,1e-1:0.1:1e4); % ЛАФЧХ
end

function rouseCriteria(Data, CalcData, AdditionalData)
    disp(newline + "Метод Рауса");

    syms s;

%     Fs = 1/(0.013675*s*(0.00036*s^2 + 0.049*s + 1.0) + 1.0); % при t = 0
%     Fs = 1/(0.0071111*s*(0.000312*s^2 + 0.038*s + 1.0) + 1.0)
%     Fs = 1/(0.00625*s*exp(0.007*s)*(0.00035*s^2 + 0.0405*s + 1.0) + 1.0);

    Ds = vpa(1 / Fs, 4);
    DsCoeffs = vpa(coeffs(Ds), 4);

    MSize = max(size(DsCoeffs));

    c11 = DsCoeffs(MSize);
    c21 = DsCoeffs(MSize - 2);
    c31 = 0;
    c12 = DsCoeffs(MSize - 1);
    c22 = DsCoeffs(1);
    c32 = 0;
    c13 = c21 - (c11 / c12) * c22;
    c23 = c31 - (c11 / c12) * c32;
    c33 = 0;
    c14  = c22 - (c12 / c13) * c23;
    c24 = 0;
    c34 = 0;

    fprintf("i\t|1\t\t|2\t\t|3\t\t\n");
    fprintf("1\t|%f\t|%f\t|%f\n", c11, c21, c31);
    fprintf("2\t|%f\t|%f\t|%f\n", c12, c22, c32);
    fprintf("3\t|%f\t|%f\t|%f\n", c13, c23, c33);
    fprintf("4\t|%f\t|%f\t|%f\n", c14, c24, c34);

    if ((c11 >= 0 && c12 >= 0 && c13 >= 0 && c14 >= 0) ||...
        (c11 < 0 && c12 < 0 && c13 < 0 && c14 < 0))
        disp("Все элементы первого столбца одного знака - система устойчива");
    else
        disp("Элементы первого столбца не одного знака - система неустойчива");
    end
end

function hurwitzCriteria(Data, CalcData, AdditionalData)
    disp(newline + "Метод Гурвица");

    disp("Характеристическое уравнение: ");
    fprintf("lambda ^ 3 + %f * lambda ^ 2 + %f * lambda + %f", ...
        a2, a1, a0);

    M = [a2 a0 0;
         a3 a1 0;
         0  a2 a0];
    
    disp("Матрица Гурвица: ");
    disp(M);

    det1 = det(M(1));
    det2 = det(M(1:2,1:2));
    det3 = det(M);

    fprintf("det1 = %f\n", det1);
    fprintf("det2 = %f\n", det2);
    fprintf("det3 = %f\n", det3);

    if (det1 < 0 || det2 < 0 || det3 < 0) 
        disp("Система неустойчива, так как один или несколько определителей" + ...
            " меньше нуля");
    else 
        disp("Система устойчива");
    end
end

function mikhailovCriteria(Data, CalcData, AdditionalData)
    disp(newline + "Метод Михайлова");
    
    disp("Характеристическое уравнение: ");
    fprintf("lambda ^ 3 + %f * lambda ^ 2 + %f * lambda + %f\n", ...
        a2, a1, a0);

    syms w;
    
    realEqn = a0 - a2 * w ^ 2 == 0;
    imagEqn = a1 * w - w ^ 3 == 0;

    disp(realEqn);
    disp(imagEqn);

    Pw = solve(realEqn, w);
    Qw = solve(imagEqn, w);

    if (max(Pw) > max(Qw))
        fprintf("%f > %f - система неустойчива\n", max(Pw), max(Qw));
    else 
        fprintf("%f <= %f - система устойчива\n", max(Pw), max(Qw));
    end
end

function nyquistCriteria(Data, CalcData, AdditionalData)
    disp(newline + "Метод Найквиста");

    syms s;

    
%     Fs = 1/(0.013675*s*(0.00036*s^2 + 0.049*s + 1.0) + 1.0);
%     Fs = 1/(0.0071111*s*exp(0.007*s)*(0.000312*s^2 + 0.038*s + 1.0) + 1.0);
%     Fs = 1/(0.00625*s*exp(0.007*s)*(0.00035*s^2 + 0.0405*s + 1.0) + 1.0);

    nCoef = 1;

    Ds = vpa(1 / Fs, 4);
    dCoef = vpa(coeffs(Ds), 4);

    inp = input("Построить график Найквиста? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        l = toCell(nCoef);
        r = toCell(dCoef);
        nyquist(tf(l, r));
        disp("Если на графике точка (-1; 0)" + ...
            " лежит внутри фигуры Найквиста, то система устойчива, если не " + ...
            "лежит внутри - то система неустойчива");
    end
end

function [v] = toCell(D)
    ve = size(max(size(D)));
    for i = 1:max(size(D))
        ve(i) = D(i);
    end
    v = ve;
end