function sim = generate_advice_and_PEs
% Generates advice and HGF belief trajectories in response to the advice

% some settings
nstages   = 4;                  % set the number of learning stages for HGF
subtrials = 50;                 % number of trials per learning stage 
ntrials   = subtrials*nstages;  % number of total trials

% set mean probability of correct advice at each stage
adviceProb = [tapas_logit(0.8,1) tapas_logit(0.9,1)...  
              tapas_logit(0.2,1),tapas_logit(0.2,1)];
      
% simulate input u (accurate vs inaccurate advice)
u = [];      
for iStages = 1:nstages
    inputVector = gen_IOIOdesign(adviceProb(iStages), ntrials/nstages - 1);
    u           = [u; inputVector];
end

% simulate HGF model dynamics to obtain PEs
sim = tapas_simModel2(u, 'tapas_hgf_binary2', [NaN 0 1 NaN 1 1 NaN 0 0 NaN 1 NaN -2 -6], 'tapas_unitsq_sgm2', 5);

% plot advice distribution and PEs
figure('WindowStyle', 'docked');

subplot(2,1,1);
scatter(1:numel(u),u,'k');
ylabel('Advice'); ylim([-0.5 1.5])
set(gca,'ytick',0:1,'yticklabel',{'Incorrect','Correct'})

subplot(2,1,2)
plot(abs(sim.traj.epsi(:,2)));                
xlabel('Trial'); ylabel('\epsilon_2','FontSize',16);
box off


end