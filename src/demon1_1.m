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

    disp("Коэффициенты нормальной формы ДУ системы: ");
    disp('Число a3 = ');
    disp(vpa(a3, 5));

    disp('Число a2 = (Tм+Tэ)/(Tм*Tэ) = ');
    disp(vpa(a2, 5));
    
    disp('Число a1 = 1/(Tм*Tэ) = ');
    disp(vpa(a1, 5));

    disp('Число a0 = (Kд*Kу*Kцап*Kг*Rк*i)/(Tм*Tэ) = ');
    disp(vpa(a0, 5));
    
    disp('Число b0 = (Kд*Kу*Kцап*Kг*Rк*i)/(Tм*Tэ) = ');
    disp(vpa(b0, 5));
    
    CalcData('a0') = a0;
    CalcData('a1') = a1;
    CalcData('a2') = a2;
    CalcData('a3') = a3;
    CalcData('b0') = b0;

    res = true;
end