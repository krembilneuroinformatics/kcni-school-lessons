function [meanVolatilityProdromal,stdVolatilityProdromal, meanVolatilityDelusion,stdVolatilityDelusion,...
    meanPredictionsProdromal,stdPredictionsProdromal,meanPredictionsDelusion,stdPredictionsDelusion] = ...
    calculateMeanTrajectories(predictionsProdromal,volatilityProdromal,predictionsDelusion,volatilityDelusion)

meanPredictionsDelusion    = mean(cell2mat(predictionsDelusion),2);
stdPredictionsDelusion     = std(cell2mat(predictionsDelusion),0,2);

meanVolatilityDelusion    = mean(cell2mat(volatilityDelusion),2);
stdVolatilityDelusion     = std(cell2mat(volatilityDelusion),0,2);

meanPredictionsProdromal    = mean(cell2mat(predictionsProdromal),2);
stdPredictionsProdromal     = std(cell2mat(predictionsProdromal),0,2);

meanVolatilityProdromal    = mean(cell2mat(volatilityProdromal),2);
stdVolatilityProdromal     = std(cell2mat(volatilityProdromal),0,2);

end
