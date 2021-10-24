% Пункт 8, построение фаозового портрета нелинейной системы.

function [res] = buildPhasePortrait(Data, CalcData, AdditionalData)
    disp("Откройте окно Simulink");

    % Костыль
    [n, d] = numden(CalcData('W3s'));
    num = coeffs(n);
    den = coeffs(d);

    numArr = zeros(1);
    denArr = zeros(1, 3); 

    numArr(1) = num(1) / den(1);
    denArr(1) = den(3) / den(1);
    denArr(2) = den(2) / den(1);
    denArr(3) = den(1) / den(1);

    simGain = Data('Ky');
    simNum  = mat2str(numArr);
    simDen = mat2str(denArr);
    simInit = Data('Ng');
    simTau  = Data('tau'); 

    set_param('demon_sim1/GainNoLatency2', 'Gain', num2str(simGain));
    set_param('demon_sim1/GainLatency2', 'Gain', num2str(simGain));
    set_param('demon_sim1/TransferFcnNoLatency', 'Numerator', ...
        num2str(simNum));
    set_param('demon_sim1/TransferFcnLatency', 'Numerator', ...
        num2str(simNum));
    set_param('demon_sim1/TransferFcnNoLatency', 'Denominator', simDen);
    set_param('demon_sim1/TransferFcnLatency', 'Denominator', simDen);
    set_param('demon_sim1/IntegratorNoLatency', 'InitialCondition', ...
        num2str(simInit));
    set_param('demon_sim1/IntegratorLatency', 'InitialCondition', ...
        num2str(simInit));
    set_param('demon_sim1/TransportDelayLatency', 'DelayTime', ...
        num2str(simTau));

    sim("demon_sim1");
    
    res = true;
end
