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

    la = input("Введите абсциссу пересечения графика с осью абсцисс: ");

    disp("Теорема Котельникова: ");
    fprintf("τ (тао) < pi / %u\n", la);
    fprintf("τ (тао) = %u\n", Data('tau'));

    n = la / (100 * Data('tau'));
    fprintf("n = %u\n", n);        

    A = subs(CalcData('TrM'), Data('tau'));

    disp('Разностные уравнения: ');

    disp("A(T) = K(T) = ");
    disp(vpa(A, 3));

    B = Data('tau') * A * AdditionalData('B');

    disp("B(k, T) = T * A(T) * B = ");
    disp(vpa(B, 3));

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
        zero = zeros(size(wt));
        for i = 1:max(size(wt))
            Lw(i) = 20 * log10(abs(subs(Ws, wt(i))));
            zero(i) = 0;
        end
        semilogx(wt, Lw);
        hold on
        grid on
        title('ЛАЧХ')
        xlabel('w');
        ylabel('L(w)');
        semilogx(wt, zero);
    end
end

function buildDiscreteView(Data, CalcData, AdditionalData, A, B, n)
    A = vpa(A, 3);
    B = vpa(B, 3);

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

        stairs(y);
        title("Линейная амплитудная характеристика системы " + ...
            "(дискретный вид)");
        grid on
    end
end

function zTransform(Data, CalcData, AdditionalData, A, B, n)
    syms z;

    A = vpa(A, 3);
    B = vpa(B, 3);    

    inp = input("Построить линейную амплитудную характеристику " + ...
        "системы? [y/n]: ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        N = inv(z .* AdditionalData('I') - A) * (B .* (z / (z - 1)));

        disp("Вектор состояния N = ");
        disp(vpa(N, 3));

        N = vpa(iztrans(N), 3);

        x = 0:0.1:n;
        y = zeros(size(x));
        zero = zeros(size(x));
        for k = 1:max(size(x))
            y(k) = subs(N(1,:), x(k));
            x(k) = x(k) / n;
            zero(k) = Data('Ng');
        end

        plot(x, y);
        xlabel("t, с");
        title("Линейная амплитудная характеристика системы");
        grid on
        hold on
        plot(x, zero);

        disp("N после обратного z-преобразования =");
        disp(N);
    end
end
