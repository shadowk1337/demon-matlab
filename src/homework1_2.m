% Пункт 2, определение матрицы состояния
% системы и нахождение корней характеристического
% уравнения
% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

% findCharacteristicEquationRoots();

function findCharacteristicEquationRoots()
    a0 = input('Введите a0: ');
    a1 = input('Введите a1: ');
    a2 = input('Введите a2: ');
    a3 = input('Введите a3: ');
    b0 = input('Введите b0: ');

    I = [1 0 0;
         0 1 0;
         0 0 1]; % Единичная матрица
    A = [0   1   0; 
         0   0   1; 
         -a0 -a1 -a2];
    B = b0 * [0; 
              0; 
              1];

    syms lambda;

    disp(newline + "========= Пункт 2 =========" + ...
         newline + "Определение матрицы состояния " + ...
         "системы и нахождение корней характеристического" + ...
         "уравнения: ");
    SM = lambda * I - A;
    disp('Матрица состояния системы:');
    disp(vpa(SM, 5));

    charEquation = det(SM);
    disp('Характеристическое уравнение:');
    disp(vpa(charEquation, 5));

    eqn = charEquation == 0;
    disp('Корни характеристического уравнения:');
    disp(vpa(solve(eqn, lambda), 5));
end
