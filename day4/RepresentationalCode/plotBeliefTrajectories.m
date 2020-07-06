function plotBeliefTrajectories(meanVolatilityProdromal,stdVolatilityProdromal, ...
    meanVolatilityDelusion,stdVolatilityDelusion,meanPredictionsProdromal, stdPredictionsProdromal,...
    meanPredictionsDelusion,stdPredictionsDelusion,tWindow,trialNumber,probs,colourBlobArray)

figure; 

subplot(2,2,1)
tnueeg_line_with_shaded_errorbar(tWindow, meanVolatilityProdromal,stdVolatilityProdromal, colourBlobArray{1},1);
xlim([tWindow(1) tWindow(end)])
subplot(2,2,2)
tnueeg_line_with_shaded_errorbar(tWindow, meanVolatilityDelusion,stdVolatilityDelusion, colourBlobArray{1},1);
xlim([tWindow(1) tWindow(end)])


subplot(2,2,3)
plot(0:trialNumber-1,probs,'Color',[0.5 0.5 0.5], 'LineWidth', 2);
hold on;
tnueeg_line_with_shaded_errorbar(tWindow, meanPredictionsProdromal,stdPredictionsProdromal, colourBlobArray{2},1);
xlim([tWindow(1) tWindow(end)])

subplot(2,2,4)
plot(0:trialNumber-1,probs,'Color',[0.5 0.5 0.5], 'LineWidth', 2);
hold on;
tnueeg_line_with_shaded_errorbar(tWindow, meanPredictionsDelusion,stdPredictionsDelusion, colourBlobArray{2},1);
xlim([tWindow(1) tWindow(end)])
end