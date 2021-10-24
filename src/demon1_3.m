% Пункт 3, нахождение матрицы перехода методом Сильвестра
% или методом Кэли-Гамильтона

% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

function [res] = findTransitionMatrix(Data, CalcData, AdditionalData)
    choice = input("y - решить методом Сильвестра / " + ...
                   "n - решить методом Кэли-Гамильтона [y/n]: ", 's');
    if (ischar(choice) && lower(choice) == 'y')
        CalcData("TrM") = solveSylvesterMethod(Data, CalcData, AdditionalData);
    else
        CalcData("TrM") = solveCayleyMethod(Data, CalcData, AdditionalData);
    end

    res = true;
end

function [TrM] = solveSylvesterMethod(Data, CalcData, AdditionalData)
    syms t; 

    roots = CalcData('roots');

    f1 = exp(roots(1) * t);
    f2 = exp(roots(2) * t);
    f3 = exp(roots(3) * t);
    
    disp("Собственные значения матрицы A: ");
    disp("f(lambda1) =");
    disp(vpa(f1, 3));
    disp("f(lambda2) =");
    disp(vpa(f2, 3));
    disp("f(lambda3) =");
    disp(vpa(f3, 3));

    MZ1 = MatrixZ(AdditionalData('A'), roots(2) .* AdditionalData('I'), ...
        roots(3) .* AdditionalData('I'), roots(1), roots(2), roots(3));
    MZ2 = MatrixZ(AdditionalData('A'), roots(1) .* AdditionalData('I'), ...
        roots(3) .* AdditionalData('I'), roots(2), roots(1), roots(3));
    MZ3 = MatrixZ(AdditionalData('A'), roots(1) .* AdditionalData('I'), ...
        roots(2) .* AdditionalData('I'), roots(3), roots(1), roots(2));

    disp("Z(lambda1) =");
    disp(vpa(MZ1, 3));
    disp("Z(lambda2) =");
    disp(vpa(MZ2, 3));
    disp("Z(lambda3) =");
    disp(vpa(MZ3, 3));

    MSylvester = vpa(f1 .* MZ1 + f2 .* MZ2 + f3 .* MZ3, 3);
    disp("Матрица перехода методом Сильвестра: ");
    disp("K(t) = f(lambda1) * Z(lambda1) + f(lambda2) * " + ...
        "Z(lambda2) + f(lambda3) * Z(lambda3) =");
    disp(MSylvester);

    TrM = MSylvester; % Матрица перехода
end

function D_Z = MatrixZ(A, MLambdaLeft, MLambdaRight, ...
                       lambda1, lambda2, lambda3)
    ML = (A - MLambdaLeft) / (lambda1 - lambda2);
    MR = (A - MLambdaRight) / (lambda1 - lambda3);
    D_Z = ML * MR;
end

function [TrM] = solveCayleyMethod(Data, CalcData, AdditionalData)
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
    disp('C^(-1) =');
    disp(vpa(CInv, 3));
    disp('E =')
    disp(vpa(E, 3));
    
    AInv = CInv * E;

    disp('A =')
    disp(vpa(AInv, 3));

    MCayley = vpa(AInv(1,:) * AdditionalData('I') + AInv(2,:) * ...
        AdditionalData('A') + AInv(3,:) * ...
        (AdditionalData('A') * AdditionalData('A')), 3);

    disp("Матрица перехода методом Кэли-Гамильтона: ");
    disp("K(t) = a0 * I + a1 * A + a2 * A ^ 2 =");
    disp(vpa(MCayley, 3));

    TrM = MCayley; % Матрица перехода
end
