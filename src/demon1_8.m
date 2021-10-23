% Пункт 8, построение фаозового портрета нелинейной системы.

function [res] = buildPhasePortrait(Data, CalcData, AdditionalData)
%     addpath("demon_simulink");
    
    gain = Data('Ky');
    num = 0.56;
    den = [0.000224, 0.039, 1];
    init = Data('Ng');

    sim(pwd + "/src/demon_simulink/sheet.slx");
    res = true;
end

% function snapshotModel(model)
%     open_system(model)
%     import slreportgen.report.*
%     r = Report(tempname, 'html');
%     D = Diagram(model);
%     D.SnapshotFormat = 'png';
%     add(r, D);
%     imshow(imread(char(D.Snapshot.Image)));
%     close(r);
%     delete(r.OutputPath);
% end