% Пункт 6, на основе матрицы перехода получаются разностные уравнения
% замкнутой системы по т. Котельникова.
% По разностным уравнениям системы получается Z-передаточная функция
% системы, находится Z-преобразование вектора состояния

% Для этого пункта понадобятся пакеты Symbolic Math Toolbox и Control
% System Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findLA(Data, CalcData, AdditionalData)
    buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
                                                    AdditionalData);
    
    syms t lambda k Ti;

    la = input("Введите абсциссу пересечения верхнего графика с осью " + ...
        "абсцисс: ");

    disp("Теорема Котельникова: ");
    fprintf("τ (тао) < pi / %f\n", la);

    n = la / (100 * Data('tau'));
    fprintf("n = %d\n", n);        

    A = subs(CalcData('TrM'), Data('tau'));

    disp('Разностные уравнения: ');
    disp("N(kT) = A(T) * N(kT - T) + B(k, T) * Nзад, где ")

    disp("A(T) = K(T) = ");
    disp(vpa(A, 4));

    B = Data('tau') * A * AdditionalData('B');

    disp("B(k, T) = T * A(T) * B = ");
    disp(vpa(B, 4));

    B = B * Data('Ng');

    
    buildDiscreteView(Data, CalcData, AdditionalData, A, B, n);
    zTransform(Data, CalcData, AdditionalData, A, B, n);
    
    res = true;
end

function buildLogarithmicAmplitudePhaseCharacteristic(Data, CalcData, ...
                                                        AdditionalData)
    syms s w;


    inp = input("Построить ЛАЧХ графика? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        Ws = subs(CalcData('Ws'), w * 1i);
        wt = 0.1:1:1e3;
        Lw = zeros(size(wt));
        for i = 1:max(size(wt))
            Lw(i) = 20 * log10(abs(subs(Ws, wt(i))));
        end
        semilogx(wt, Lw);
        grid on
    end
end

function buildDiscreteView(Data, CalcData, AdditionalData, A, B, n)
    A = vpa(A, 4);
    B = vpa(B, 4);

    inp = input("Построить линейную амплитудную характеристику " + ...
        "системы (дискретный вид)? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        n = int32(n);
        y = zeros(n);
        N = [0; 0; 0];
        for i = 1:n
            N = A * N + B;
            y(i) = N(1,:);
        end
     
        figure
        stairs(y);
        title("Линейная амплитудная характеристика системы " + ...
            "(дискретный вид)");
        grid on
    end
end

function zTransform(Data, CalcData, AdditionalData, A, B, n)
    syms z;

    A = vpa(A, 4);
    B = vpa(B, 4);    

    inp = input("Построить линейную амплитудную характеристику " + ...
        "системы? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        N = inv(z .* AdditionalData('I') - A) * (B .* (z / (z - 1)));
        N = vpa(iztrans(N), 4);

        x = 0:0.1:n;
        y = zeros(size(x));
        for k = 1:max(size(x))
            y(k) = subs(N(1,:), x(k));
            x(k) = x(k) / n;
        end
        disp(6);

        plot(x, y);
        xlabel("t, с");
        title("Линейная амплитудная характеристика системы");
        grid on
    end
end