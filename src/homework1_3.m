% Пункт 3, нахождение матрицы перехода методом Сильвестра
% или методом Кэли-Гамильтона
% Для этого пункта понадобится пакет Symbolic Math Toolbox
% Скачать пакет: Home->Add-ons->"Get Add-Ons"

findTransitionMatrix();

function findTransitionMatrix()
    % Собственные значения матрицы состояния системы
    lambda1 = input('Введите лямбду1: ');
    lambda2 = input('Введите лямбду2: ');
    lambda3 = input('Введите лямбду3: ');

    choice = input("Y - решить методом Сильвестра / " + ...
                   "N - решить методом Кэли-Гамильтона [Y/N]: ", 's');
    if (ischar(choice) && lower(choice) == 'y')
        solveSylvesterMethod(lambda1, lambda2, lambda3);
    else
        solveCayleyMethod(lambda1, lambda2, lambda3);
    end
end

function solveSylvesterMethod(lambda1, lambda2, lambda3)
    % Для метода Сильвестра используется формула: 
    % K(t) = exp(At) = 

    syms t; 

    A = [0       1       0; 
         0       0       1; 
         lambda1 lambda2 lambda3]; % Матрица состояния системы
    I = [1 0 0; 
         0 1 0;
         0 0 1]; % Единичная матрица

    f1 = exp(lambda1 * t);
    f2 = exp(lambda2 * t);
    f3 = exp(lambda3 * t);
    
    MZ1 = MatrixZ(A, lambda2 .* I, lambda3 .* I, lambda1, ...
                  lambda2, lambda3);
    MZ2 = MatrixZ(A, lambda1 .* I, lambda3 .* I, lambda2, ...
                  lambda1, lambda3);
    MZ3 = MatrixZ(A, lambda1 .* I, lambda2 .* I, lambda3, ...
                  lambda1, lambda2);

    disp(newline + "========= Пункт 3 =========" + ...
         newline + "Матрица перехода методом Сильвестра: ");
    disp(vpa(f1 .* MZ1 + f2 .* MZ2 + f3 .* MZ3, 5));
end

function D_Z = MatrixZ(A, MLambdaLeft, MLambdaRight, ...
                       lambda1, lambda2, lambda3)
    ML = (A - MLambdaLeft) / (lambda1 - lambda2);
    MR = (A - MLambdaRight) / (lambda1 - lambda3);
    D_Z = ML * MR;
end

function solveCayleyMethod(lambda1, lambda2, lambda3)
    syms t;

    I = [1 0 0;
         0 1 0;
         0 0 1]; % Единичная матрица

    f1 = exp(lambda1 * t);
    f2 = exp(lambda2 * t);
    f3 = exp(lambda3 * t);

    C = [1 lambda1 lambda1 ^ 2; 
         1 lambda2 lambda2 ^ 2;
         1 lambda3 lambda3 ^ 2];

    E = [f1; 
         f2; 
         f3];

    CInv = inv(C);

    disp(newline + "========= Пункт 3 =========");
    disp('A = C^(-1) * E, где ');
    disp('C^(-1):');
    disp(vpa(CInv, 5));
    disp('E:')
    disp(vpa(E, 5));
    
    K = C \ E;

    disp("Матрица перехода методом Кэли-Гамильтона: ");
    disp(vpa(K, 5));
end
