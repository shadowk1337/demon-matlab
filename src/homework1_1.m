% Пункт 1, составление единого ДУ системы
% https://docs.google.com/document/d/1hvCyU4ntI7h5q_E7bBjpu5ZjoYIeHKde/edit

function [a, b] = findSystemDifferentialEquation(Kd, Ky, Kcap, Kg, ...
                                             Rk, i, Tm, Te)
%     Ng = input('Введите Nзад: ');
%     Ky = input('Введите Kу: ');
%     La = input('Введите Lя: ');
%     Kd = input('Введите Kд: ');
%     Tm = input('Введите Tм: ');
% 
%     Kcap = 0.2; % Kцап
%     Ra = 10; % Rя
%     Rk = 0.01; % Rк
%     Kg = 62500; % Kг
%     i = 0.05; % i
%     Te = La / Ra; % Тэ

    a0 = (Kd * Ky * Kcap * Kg * Rk * i) / (Tm * Te);
    a1 = 1 / (Tm * Te);
    a2 = (Tm + Te) / (Tm * Te);
    a3 = 1;
    b0 = a0;

    disp(newline + "========= Пункт 1 =========" + ...
         newline + "Коэффициенты нормальной формы ДУ системы: ");
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
    
    a = [a0 a1 a2 a3];
    b = b0;
end