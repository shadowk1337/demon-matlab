% Калькулятор для решения домашнего задания номер 1 Деменкова Н.П.,
% выдаваемого на 5 семестре студентам кафедры ИУ4

addpath("./src");
% addpath("src/homework1_2");
% addpath("src/homework1_3");
% addpath("src/homework1_4");
% addpath("src/homework1_5");
% addpath("src/homework1_6");
% addpath("src/homework1_7");
% addpath("src/homework1_8");
% addpath("src/homework1_9");

main();

function main()
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

    disp(pwd);

    findSystemDifferentialEquation();

end

% findSystemDifferentialEquation();