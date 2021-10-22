% 9 пункт ёпта
% Используя фазовую границу устойчивости найти параметры автоколебаний
% Бля

buildPhaseBorder();

function buildPhaseBorder()
%     syms A;

%     Kcap = input('Введите Kцап: ');
%     T = input('Введите тао: ');

%     Pade = Kcap * (12 - 6 * T * s + T ^ 2 * s ^ 2) / ...
%                   (12 + 6 * T * s + T ^ 2 * s ^ 2);
%     [n, d] = tfdata(Pade);
%     disp(n);
%     disp(d);
    
    buildLogarithmicAmplitudePhaseCharacteristic();

    syms w A s;

    a = 1e-6;

    q1 = 1 / pi * (pi / 2 + asin(1 - (2 * a) / A) + ...
         2 * (1 - (2 * a) / A)) * sqrt((a / A) * (1 - a / A));

    q2 = (4 / (pi * A)) * (1 - a / A);

    Ws = (365.62)/(s*(0.00036*s^2 + 0.049*s + 1.0));
    Ws = subs(Ws, w * 1i);
    sqr = sqrt(q1 ^ 2 + q2 ^ 2);
    at = q2 / q1;

    Aar = [0.01, 0.05, 0.1, 0.2, 0.5, 1, 10];
    Ln = zeros(size(Aar));
    phi = zeros(size(Aar));
%     war = zeros(size(Aar));
    fprintf("A\t\t|Lн(A)\t\t|phi(A)\t\t\n");
    for i = 1:max(size(Aar))
        Ln(i) = vpa(-20 * log10(subs(sqr, A, Aar(i))), 4);
        phi(i) = vpa(-atan(subs(at, A, Aar(i))) - pi / 2, 4);
        fprintf("%f\t|%f\t|%f\n", Aar(i), Ln(i), phi(i));
        % war(i) = max(vpa(solve(Ln(i) == real(Ws), w), 4));
    end
    
%     disp(phi);
%     disp(war);
%     subplot(2, 1, 2);
%     semilogx(war, phi);
end

function buildLogarithmicAmplitudePhaseCharacteristic()
    syms s;

    W = tf(365.62, [0.00036, 0.049, 1, 0]);
    bode(W,1e-1:0.1:1e4); % ЛАФЧХ
    grid on;
%     hold on;
end