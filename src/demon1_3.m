% Пункт 3, нахождение матрицы перехода методом Сильвестра
% или методом Кэли-Гамильтона

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findTransitionMatrix(Data, CalcData, AdditionalData)
    choice = input("y - решить методом Сильвестра / " + ...
                   "n - решить методом Кэли-Гамильтона [y/n]: ", 's');
    if (ischar(choice) && lower(choice) == 'y')
        solveSylvesterMethod(Data, CalcData, AdditionalData);
    else
        solveCayleyMethod(Data, CalcData, AdditionalData);
    end

    res = true;
end

function solveSylvesterMethod(Data, CalcData, AdditionalData)
    syms t; 

    roots = CalcData('roots');

    f1 = exp(roots(1) * t);
    f2 = exp(roots(2) * t);
    f3 = exp(roots(3) * t);
    
    MZ1 = MatrixZ(AdditionalData('A'), roots(2) .* AdditionalData('I'), ...
        roots(3) .* AdditionalData('I'), roots(1), roots(2), roots(3));
    MZ2 = MatrixZ(AdditionalData('A'), roots(1) .* AdditionalData('I'), ...
        roots(3) .* AdditionalData('I'), roots(2), roots(1), roots(3));
    MZ3 = MatrixZ(AdditionalData('A'), roots(1) .* AdditionalData('I'), ...
        roots(2) .* AdditionalData('I'), roots(3), roots(1), roots(2));

    MSylvester = vpa(f1 .* MZ1 + f2 .* MZ2 + f3 .* MZ3, 5);
    disp("Матрица перехода методом Сильвестра: ");
    disp(MSylvester);

    CalcData("TrM") = MSylvester; % Матрица перехода
end

function D_Z = MatrixZ(A, MLambdaLeft, MLambdaRight, ...
                       lambda1, lambda2, lambda3)
    ML = (A - MLambdaLeft) / (lambda1 - lambda2);
    MR = (A - MLambdaRight) / (lambda1 - lambda3);
    D_Z = ML * MR;
end

function solveCayleyMethod(Data, CalcData, AdditionalData)
    syms t;

    roots = CalcData('roots');

    f1 = exp(roots(1) * t);
    f2 = exp(roots(2) * t);
    f3 = exp(roots(3) * t);

    C = [1 roots(1) roots(1) ^ 2; 
         1 roots(2) roots(2) ^ 2;
         1 roots(3) roots(3) ^ 2];

    E = [f1; 
         f2; 
         f3];

    CInv = inv(C);

    disp('A = C^(-1) * E, где ');
    disp('C^(-1):');
    disp(vpa(CInv, 5));
    disp('E:')
    disp(vpa(E, 5));
    
    AInv = inv(C) * E;

    MCayley = vpa(AInv(1,:) * AdditionalData('I') + AInv(2,:) * ...
        AdditionalData('A') + AInv(3,:) * ...
        (AdditionalData('A') * AdditionalData('A')), 5);

    disp("Матрица перехода методом Кэли-Гамильтона: ");
    disp(MCayley);

    CalcData("TrM") = MCayley; % Матрица перехода
end
