% Пункт 6, на основе матрицы перехода получаются разностные уравнения
% замкнутой системы по т. Котельникова.
% По разностным уравнениям системы получается Z-передаточная функция
% системы, находится Z-преобразование вектора состояния
% Для этого пункта понадобятся пакеты Symbolic Math Toolbox и Control
% System Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"


LA();

function LA()
    inp = input("Построить ЛАЧХ графика? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        buildLogarithmicAmplitudePhaseCharacteristic();
    end
    syms t lambda k Ti;

    disp(newline + "========= Пункт 6 =========" + ...
         newline + "Какая-то херня");
    la = input(['Введите абсциссу пересечения верхнего графика с осью' ...
                ' абсцисс: ']);
    T = input('Введите период дискретизации (0.007с для 52 группы): ');
    b0 = input('Введите b0: ');
    N = input('Введите Nзад: ');

    disp("Теорема Котельникова: ");
    fprintf("T < pi / %f", la);

    n = la / (100 * T);

    K = [           0.09721*exp(-126.73*t) + exp(t*(- 4.6359 - 39.766i))*(0.4514 + 0.20752i) + exp(t*(- 4.6359 + 39.766i))*(0.4514 - 0.20752i), 0.00056233*exp(-126.73*t) - exp(t*(- 4.6359 - 39.766i))*(0.00028116 - 0.013437i) - exp(t*(- 4.6359 + 39.766i))*(0.00028116 + 0.013437i),         0.000060649*exp(-126.73*t) - exp(t*(- 4.6359 - 39.766i))*(0.000030325 - 0.000093106i) - exp(t*(- 4.6359 + 39.766i))*(0.000030325 + 0.000093106i);
            - 12.319*exp(-126.73*t) + exp(t*(- 4.6359 - 39.766i))*(6.1595 - 18.912i) + exp(t*(- 4.6359 + 39.766i))*(6.1595 + 18.912i),       - 0.071261*exp(-126.73*t) + exp(t*(- 4.6359 - 39.766i))*(0.53563 - 0.051107i) + exp(t*(- 4.6359 + 39.766i))*(0.53563 + 0.051107i), - exp(-126.73*t)*(0.0076859 + 4.3368e-19i) + exp(t*(- 4.6359 - 39.766i))*(0.003843 + 0.00077442i) + exp(t*(- 4.6359 + 39.766i))*(0.003843 - 0.00077442i);
exp(-126.73*t)*(1561.2 - 2.1316e-14i) - exp(t*(- 4.6359 - 39.766i))*(780.58 + 157.3i) - exp(t*(- 4.6359 + 39.766i))*(780.58 - 157.3i),  exp(-126.73*t)*(9.031 - 4.4409e-16i) - exp(t*(- 4.6359 - 39.766i))*(4.5155 + 21.063i) - exp(t*(- 4.6359 + 39.766i))*(4.5155 - 21.063i),                           0.97403*exp(-126.73*t) + exp(t*(- 4.6359 - 39.766i))*(0.012986 - 0.15643i) + exp(t*(- 4.6359 + 39.766i))*(0.012986 + 0.15643i)];
    
    A = subs(K, T);

    disp("Av2: ");
    disp(vpa(A, 4));

    B = T * A * (b0 * [0; 0; 1]) * N;

    disp("Bv4: ");
    disp(vpa(B, 4));

    inp = input("Построить дискретный вид графика? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        buildDiscreteView(A, B);
    end

    inp = input("Построить график от z-преобразования? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        zTransform(A, B, n);
    end
end

function buildLogarithmicAmplitudePhaseCharacteristic()
    syms s w;

    Ws = 365.62 / (s*(0.00036*s^2 + 0.049*s + 1.0));
    Ws = subs(Ws, w * 1i);
    wt = 0.1:1:1e3;
    Lw = zeros(size(wt));
    for i = 1:max(size(wt))
        Lw(i) = 20 * log10(abs(subs(Ws, wt(i))));
    end
    semilogx(wt, Lw);
end

function buildDiscreteView(A, B)
    A = vpa(A, 4);
    B = vpa(B, 4);

    disp("----------------------------");
    n = 100;
    y = zeros(n);

    N = [0; 0; 0];
    for i = 1:n
        N = A * N + B;
        y(i) = N(1,:);
    end
 
    figure
    stairs(y);
end

function zTransform(A, B, n)
    syms z;

    A = vpa(A, 4);
    B = vpa(B, 4);

    I = [1 0 0; 
         0 1 0; 
         0 0 1];
    N = inv(z .* I - A) * (B .* (z / (z - 1)));
    N = iztrans(N);

    x = 0:0.1:175;
    y = zeros(size(x));
    for k = 1:max(size(x))
        y(k) = subs(N(1,:), x(k));
        x(k) = x(k) / n;
    end

    plot(x, y);
end