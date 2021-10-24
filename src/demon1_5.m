% Пункт 5, нахождение передаточной функции разомкнутой системы,
% передаточной функции замкнутой системы и передаточной функции
% системы по ошибке

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findTransferFunction(Data, CalcData, AdditionalData)
    syms s;

    disp("Нахождение передаточной функции разомкнутой " + ...
         "системы, передаточной функции замкнутой системы и " + ...
         "передаточной функции системы по ошибке: ");

    Ws = vpa(findTransferFunctionOpened(Data, CalcData, AdditionalData, ...
                                        Data('tau'), s), 3);
    disp('Передаточная функция разомкнутой системы: ');
    disp(Ws);
    CalcData('Ws') = Ws;

    Wzs = vpa(findTransferFunctionClosed(Data, CalcData, AdditionalData, ...
                                        Data('tau'), s), 3);
    disp('Передаточная функция замкнутой системы: ');
    disp(Wzs);
    CalcData('Wzs') = Wzs;

    Fvs = vpa(findTransferFunctionByMistake(Data, CalcData, ...
                                         AdditionalData, Data('tau'), ...
                                        s), 3);
    disp('Передаточная функция системы по ошибке: ');
    disp(Fvs);
    CalcData('Fvs') = Fvs;

    disp('Реакция системы при тао = 0: ');
    findSystemReaction(Data, CalcData, AdditionalData, s);

    W3s = findTransferFunctionW3s(Data, CalcData, AdditionalData, s);
    CalcData('W3s') = W3s;

    res = true;
end

function [Ws] = findTransferFunctionOpened(Data, CalcData, ...
                                            AdditionalData, t, s)
    Ws = (Data('i') * Data('Kcap') * Data('Ky') * Data('Kd') * ...
          Data('Kg') * Data('Rk') * exp(-t * s)) / ... 
         ((Data('Tm') * Data('Te') * s ^ 2 + (Data('Tm') + ...
           Data('Te')) * s + 1) * s);
end

function [Wzs] = findTransferFunctionClosed(Data, CalcData, ...
                                            AdditionalData, t, s)
    Wzs = 1 / (1 + 1 / findTransferFunctionOpened(Data, CalcData, ...
                                                  AdditionalData, t, s));
end

function [Fvs] = findTransferFunctionByMistake(Data, CalcData, ...
                                                AdditionalData, t, s)
    Fvs = ((Data('Tm') * Data('Te') * s ^ 2) + (Data('Tm') + ...
        Data('Te')) * s + 1) / ...
          ((Data('Tm') * Data('Te') * s ^ 2 + (Data('Tm') + ...
          Data('Te')) * s + 1) * s + ...
            Data('i') * Data('Kcap') * Data('Ky') * Data('Kd') * ...
            Data('Kg') * Data('Rk') * exp(-t * s));
end

function [W3s] = findTransferFunctionW3s(Data, CalcData, AdditionalData, s)
    W3s = Data('Kd') / ((Data('Tm') * s + 1) * ...
        (Data('Te') * s + 1));
end

function findSystemReaction(Data, CalcData, AdditionalData, s)
    Ns = findTransferFunctionClosed(Data, CalcData, AdditionalData, 0, ... 
         s) * (Data('Ng') / s);
    Nt = ilaplace(Ns);
    
    choice = input("Построить график реакции системы на входное " + ...
        "воздействие Nзад? [y/n]: ", 's');

    if (ischar(choice) && lower(choice) == 'y')
        time = 0.001:0.005:1;
        y = zeros(size(time));
        for i = 1:max(size(time))
            y(i) = subs(Nt, time(i));
        end
        plot(time, y);
        title("График реакции системы на входное воздействие Nзад");
        xlabel("t, сек");
        ylabel("N(t)");
        grid on
    end
end