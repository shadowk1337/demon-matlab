% Пункт 4, получение аналитического выражения при 
% ступенчатом входном воздействии

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findAnalyticalExpression(Data, CalcData, AdditionalData)
    syms t lambda;

    K = subs(CalcData("TrM"), t, t - lambda); % преобразованная матрица 
                                              % перехода

    integEq = K * AdditionalData('B');
    
    MInt = int(integEq, lambda, 0, t) * Data('Ng');

    choice = input("Построить график реакции системы на входное " + ...
        "ступенчатое воздействие? [y/n]: ", 's');

    if (ischar(choice) && lower(choice) == 'y')
        time = 0:0.005:1;
        y = zeros(size(time));
        for i = 1:max(size(time))
            y(i) = subs(MInt(1,:), time(i));
        end

        plot(time, y);
        title("График реакции системы на входное ступенчатое воздействие");
        xlabel("t, сек");
        ylabel("N(t)");
        grid on
    end

    res = true;
end