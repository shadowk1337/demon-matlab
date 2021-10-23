% Пункт 1, составление единого ДУ системы
% https://docs.google.com/document/d/1hvCyU4ntI7h5q_E7bBjpu5ZjoYIeHKde/edit

function [res] = findSystemDifferentialEquation(Data, CalcData, ...
                                                    AdditionalData)
    a0 = (Data('Kd') * Data('Ky') * Data('Kcap') * Data('Kg') * Data('Rk') ...
        * Data('i')) / (Data('Tm') * Data('Te'));

    a1 = 1 / (Data('Tm') * Data('Te'));

    a2 = (Data('Tm') + Data('Te')) / ...
            (Data('Tm')* Data('Te'));
    a3 = 1;
    b0 = a0;

    disp("ДУ в нормальной форме: a3 * d^3/dt^3(N) + a2 * " + ...
        "d^2/dt^2(N) + a1 * d/dt(N) + a0 * N = b0 * Nзад");

    disp("Коэффициенты нормальной формы ДУ системы: ");
    disp('Число a3 = ');
    disp(vpa(a3, 3));

    disp('Число a2 = (Tм+Tэ)/(Tм*Tэ) = ');
    disp(vpa(a2, 3));
    
    disp('Число a1 = 1/(Tм*Tэ) = ');
    disp(vpa(a1, 3));

    disp('Число a0 = (Kд*Kу*Kцап*Kг*Rк*i)/(Tм*Tэ) = ');
    disp(vpa(a0, 3));
    
    disp('Число b0 = (Kд*Kу*Kцап*Kг*Rк*i)/(Tм*Tэ) = ');
    disp(vpa(b0, 3));
    
    CalcData('a0') = vpa(a0, 3);
    CalcData('a1') = vpa(a1, 3);
    CalcData('a2') = vpa(a2, 3);
    CalcData('a3') = vpa(a3, 3);
    CalcData('b0') = vpa(b0, 3);

    res = true;
end