% Пункт 2, определение матрицы состояния
% системы и нахождение корней характеристического
% уравнения

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findCharacteristicEquationRoots(Data, CalcData, ...
                                                 AdditionalData)
    AdditionalData('A') = [ 0               1               0; 
                            0               0               1; 
                           -CalcData('a0') -CalcData('a1') -CalcData('a2')];

    AdditionalData('B') = [0;
                           0;
                           CalcData('b0')];

    syms lambda;

    disp("Определение матрицы состояния " + ...
         "системы и нахождение корней характеристического " + ...
         "уравнения: ");
    SM = lambda * AdditionalData('I') - AdditionalData('A');
    disp('Матрица состояния системы:');
    disp(vpa(SM, 5));

    charEquation = det(SM);
    disp('Характеристическое уравнение:');
    disp(vpa(charEquation, 5));

    eqn = charEquation == 0;
    eqnRoots = vpa(solve(eqn, lambda), 5);
    disp('Корни характеристического уравнения:');
    if (max(size(eqnRoots)) ~= 3)
        disp("Количество корней характеристического уравнения не" + ...
            " равняется трем");
        res = false;
        return;
    end
    disp(eqnRoots);
    
    CalcData('roots') = eqnRoots;

    res = true;
end
