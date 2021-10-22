% Калькулятор для решения домашнего задания номер 1 Деменкова Н.П.,
% выдаваемого на 5 семестре студентам кафедры ИУ4

addpath("src");

main();

function main()
    % Данные значения
    Data            = containers.Map('KeyType', 'char', ...
                                    'ValueType', 'double');

    % Расчетные значения
    CalcData        = containers.Map('KeyType', 'char', ...
                                    'ValueType', 'any');

    % Дополнительные значения
    AdditionalData  = containers.Map('KeyType', 'char', ...
                                    'ValueType', 'any');

    Data('Ng')  = input('Введите Nзад: ');
    Data('Ky')  = input('Введите Kу: ');
    Data('La')  = input('Введите Lя: ');
    Data('Kd')  = input('Введите Kд: ');
    Data('Tm')  = input('Введите Tм: ');
    Data('tau') = input('Введите τ (тао): ');
    
    Data('Kcap')    = 0.2;      % Kцап
    Data('Ra')      = 10;       % Rя
    Data('Rk')      = 0.01;     % Rк
    Data('Kg')      = 62500;    % Kг
    Data('i')       = 0.05;     % i
    Data('Te')      = Data('La') / Data('Ra');  % Тэ

    AdditionalData('I') = [1 0 0;
                           0 1 0;
                           0 0 1];
    
    invStrs = [
        "пункт 1";
        "пункт 2";
        "пункт 3";
        "пункт 4";
        "пункт 5";
        "пункт 6";
        "пункт 7";
        "пункт 8";
        "пункт 9";
    ];

    filenames = [
        "demon1_1";
        "demon1_2";
        "demon1_3";
        "demon1_4";
        "demon1_5",
        "demon1_6",
%         "demon1_7",
%         "demon1_8",
%         "demon1_9",
    ];

    for i = 1:size(filenames)
        if (userInputInit(invStrs(i)))
            fprintf("\n*********%s*********\n", upper(invStrs(i)));
            if (~feval(filenames(i), Data, CalcData, AdditionalData))
                disp("Ошибка!");
                break;
            end
            fprintf("\n*********Конец %s*********\n", upper(invStrs(i)));
        else
            break;
        end
    end
end

function [userAns] = userInputInit(str)
	out = "y - запустить " + str + ", n - завершить работу " + ...
          "программы [y/n]: ";
    inp = input(out, 's');
    
    if (ischar(inp) && lower(inp) == 'y')
        userAns = true;
    else
        userAns = false;
    end
end