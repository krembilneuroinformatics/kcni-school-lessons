function HGFtutorial_generate_learners
%--------------------------------------------------------------------------
% Maybe add a function description or tutorial overview here.
%
%
%
%--------------------------------------------------------------------------


%% Design your task
numberBlocks = 10;
probabilityStructure = [0.8,0.8,0.8,0.10,0.10,0.90,0.10,0.80,0.20,0.5];
nTrials = 21;
meanProb = [tapas_logit(probabilityStructure(1),1) tapas_logit(probabilityStructure(2),1)...
    tapas_logit(probabilityStructure(3),1),tapas_logit(probabilityStructure(4),1)...
    tapas_logit(probabilityStructure(5),1),tapas_logit(probabilityStructure(6),1)...
    tapas_logit(probabilityStructure(7),1),tapas_logit(probabilityStructure(8),1)...
    tapas_logit(probabilityStructure(9),1),tapas_logit(probabilityStructure(10),1)];
u = [];
for iStages = 1:numberBlocks
    inputVector = gen_design(meanProb(iStages), nTrials - 1);
    u = [u;inputVector'];
end


%% Set parameters for plotting
colourBlobArray = {'-b',  '-r'};
probs =[ones(nTrials,1).*probabilityStructure(1);ones(nTrials,1).*probabilityStructure(2);...
    ones(nTrials,1).*probabilityStructure(3);ones(nTrials,1).*probabilityStructure(4);...
    ones(nTrials,1).*probabilityStructure(5); ones(nTrials,1).*probabilityStructure(6);...
    ones(nTrials,1).*probabilityStructure(7); ones(nTrials,1).*probabilityStructure(8);...
    ones(nTrials,1).*probabilityStructure(9);ones(nTrials,1).*probabilityStructure(10)];
trialNumber = size(probs);
tWindow = 0:trialNumber-1;


%% Simulate Optimal Learner
[predictionOptimalLearner1,volatilityOptimalLearner1] = sim_Learner(u,'omega_optimal',1);
[predictionOptimalLearner2,volatilityOptimalLearner2] = sim_Learner(u,'kappa_optimal',2);

[meanVolatilityOptimal1,stdVolatilityOptimal1,meanVolatilityOptimal2,stdVolatilityOptimal2,...
    meanPredictionsOptimal1,stdPredictionsOptimal1,meanPredictionsOptimal2,stdPredictionsOptimal2] = ...
    calculateMeanTrajectories(predictionOptimalLearner1,volatilityOptimalLearner1,predictionOptimalLearner2,volatilityOptimalLearner2);

plotBeliefTrajectories(meanVolatilityOptimal1,stdVolatilityOptimal1,meanVolatilityOptimal2,stdVolatilityOptimal2,...
    meanPredictionsOptimal1,stdPredictionsOptimal1,meanPredictionsOptimal2,stdPredictionsOptimal2,...
    tWindow,trialNumber,probs,colourBlobArray);


%% Simulate MDD
[predictionMDDLearner1,volatilityMDDLearner1] = sim_Learner(u,'theta',1);
[predictionMDDLearner2,volatilityMDDLearner2] = sim_Learner(u,'m3',2);

[meanVolatilityMDD1,stdVolatilityMDD1,meanVolatilityMDD2,stdVolatilityMDD2,...
    meanPredictionsMDD1,stdPredictionsMDD1,meanPredictionsMDD2,stdPredictionsMDD2] = ...
    calculateMeanTrajectories(predictionMDDLearner1,volatilityMDDLearner1,predictionMDDLearner2,volatilityMDDLearner2);

plotBeliefTrajectories(meanVolatilityMDD1,stdVolatilityMDD1,meanVolatilityMDD2,stdVolatilityMDD2,...
    meanPredictionsMDD1,stdPredictionsMDD1,meanPredictionsMDD2,stdPredictionsMDD2,...
    tWindow,trialNumber,probs,colourBlobArray);


end




