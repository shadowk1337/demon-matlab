% Пункт 8, построение фаозового портрета нелинейной системы.

function [res] = buildPhasePortrait(Data, CalcData, AdditionalData)
%     addpath("demon_simulink");
    
    simGain = Data('Ky');
    simNum  = [0.56];
    simDen  = '[0.000224 0.039 1]';
    simInit = Data('Ng');
    simTau  = Data('tau'); 

    set_param('sheet/GainNoLatency2', 'Gain', num2str(simGain));
    set_param('sheet/GainLatency2', 'Gain', num2str(simGain));
    set_param('sheet/TransferFcnNoLatency', 'Numerator', num2str(simNum));
    set_param('sheet/TransferFcnLatency', 'Numerator', num2str(simNum));
    set_param('sheet/TransferFcnNoLatency', 'Denominator', simDen);
    set_param('sheet/TransferFcnLatency', 'Denominator', simDen);
    set_param('sheet/IntegratorNoLatency', 'InitialCondition', ...
        num2str(simInit));
    set_param('sheet/IntegratorLatency', 'InitialCondition', ...
        num2str(simInit));
    set_param('sheet/TransportDelayLatency', 'DelayTime', num2str(simTau));

    sim("sheet");
    
    res = true;
end