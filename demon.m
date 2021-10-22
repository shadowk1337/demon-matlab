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
    Ng = input('Введите Nзад: ');
    Ky = input('Введите Kу: ');
    La = input('Введите Lя: ');
    Kd = input('Введите Kд: ');
    Tm = input('Введите Tм: ');
    
    Kcap = 0.2; % Kцап
    Ra = 10; % Rя
    Rk = 0.01; % Rк
    Kg = 62500; % Kг
    i = 0.05; % i
    Te = La / Ra; % Тэ

%     disp(pwd);

    inp = input("y - запустить пункт 1, n - завершить работу " + ...
                "программы [y/n]: ", 's');
    [a, b] = homework1_1(Kd, Ky, Kcap, Kg, Rk, i, Tm, Te);
    disp(a);

end

function [ans] = userInputInit(str)
	out = "y - запустить " + str + ", n - завершить работу " + ...
          "программы [y/n]: "
    inp = input(out, 's');
    
    if (ischar(inp) && lower(inp) == 'y')
        return true;
    else
        
    end
end