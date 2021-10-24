% Пункт 4, получение аналитического выражения при 
% ступенчатом входном воздействии

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findAnalyticalExpression(Data, CalcData, AdditionalData)
    syms t lambda;

    K = subs(CalcData("TrM"), t, t - lambda); % преобразованная матрица 
                                              % перехода

    disp("Преобразованная матрица перехода =");
    disp(vpa(K, 3));

    integEq = K * AdditionalData('B');
    
    N = int(integEq, lambda, 0, t) * Data('Ng');

    disp("Вектор состояния:");
    disp("N(t) = integral(0, t)((K(t - lambda) * B * Nзад)dlambda) =");
    disp(vpa(N, 3));

    choice = input("\nПостроить график реакции системы на входное " + ...
        "ступенчатое воздействие? [y/n]: ", 's');

    if (ischar(choice) && lower(choice) == 'y')
        time = 0:0.005:1;
        y = zeros(size(time));
        for i = 1:max(size(time))
            y(i) = subs(N(1,:), time(i));
        end

        plot(time, y);
        title("График реакции системы на входное ступенчатое воздействие");
        xlabel("t, сек");
        ylabel("N(t)");
        grid on
    end

    res = true;
end
