% Пункт 5, нахождение передаточной функции разомкнутой системы,
% передаточной функции замкнутой системы и передаточной функции
% системы по ошибке

findTransferFunction();

function findTransferFunction()
    Ng = input('Введите Nзад: ');
    Tm = input('Введите Tм: ');
    Te = input('Введите Tе: ');
    Ky = input('Введите Kу: ');
    Kd = input('Введите Kд: ');
    t = input('Введите тао: ');

    iOhm = 0.05;
    Kcap = 0.2;
    Kg = 62500;
    Rk = 0.01;

    syms s;

    disp(newline + "========= Пункт 6 =========" + ...
         newline + "Нахождение передаточной функции разомкнутой " + ...
         "системы, передаточной функции замкнутой системы и " + ...
         "передаточной функции системы по ошибке: ");

    disp('Передаточная функция разомкнутой системы: ');
    disp(vpa(findTransferFunctionOpened(iOhm, Kcap, Ky, Kd, Kg, ...
                                        Rk, t, Tm, Te, s), 5));

    disp('Передаточная функция замкнутой системы: ');
    disp(vpa(findTransferFunctionClosed(iOhm, Kcap, Ky, Kd, Kg, ...
                                        Rk, t, Tm, Te, s), 5));

    disp('Передаточная функция системы по ошибке: ');
    disp(vpa(findTransferFunctionByMistake(iOhm, Kcap, Ky, Kd, Kg, ...
                                           Rk, t, Tm, Te, s), 5));

    disp('Реакция системы при тао = 0: ');
    findSystemReaction(Ng, iOhm, Kcap, Ky, Kd, Kg, ...
                       Rk, Tm, Te, s);
end

function [Ws] = findTransferFunctionOpened(iOhm, Kcap, Ky, Kd, Kg, ...
                                           Rk, t, Tm, Te, s)
    Ws = (iOhm * Kcap * Ky * Kd * Kg * Rk * exp(-t * s)) / ... 
         ((Tm * Te * s^2 + (Tm + Te) * s + 1) * s);
end

function [Wzs] = findTransferFunctionClosed(iOhm, Kcap, Ky, Kd, Kg, ...
                                           Rk, t, Tm, Te, s)
    Wzs = 1 / (1 + 1 / findTransferFunctionOpened(iOhm, Kcap, Ky, Kd, Kg, ...
                                        Rk, t, Tm, Te, s));
end

function [Fvs] = findTransferFunctionByMistake(iOhm, Kcap, Ky, Kd, Kg, ...
                                              Rk, t, Tm, Te, s)
    Fvs = ((Tm * Te * s ^ 2) + (Tm + Te) * s + 1) / ...
          ((Tm * Te * s ^ 2 + (Tm + Te) * s + 1) * s + ...
            iOhm * Kcap * Ky * Kd * Kg * Rk * exp(-t * s));
end

function findSystemReaction(Ng, iOhm, Kcap, Ky, Kd, Kg, ...
                            Rk, Tm, Te, s)
    Ns = findTransferFunctionClosed(iOhm, Kcap, Ky, Kd, Kg, ...
         Rk, 0, Tm, Te, s) * (Ng / s);
    Nt = ilaplace(Ns);
    disp(vpa(Nt, 4));
    time = 0:0.005:1;
    y = zeros(size(time));
    for i = 1:max(size(time))
        y(i) = subs(Nt, time(i));
    end
    plot(time, y);
end