function DCM = Generate2RegionDCM_epsilon2(DCM,sim)

% space out the trials to make it suitable for fMRI 
duration = 10;                       % Duration of stimulus in seconds
spacing  = 100;                      % Spacing of stimulus in seconds
ntrials  = size(sim.u,1);

indU1               = repmat((1:duration)',1,ntrials) + ...
                      repmat((0:ntrials-1)*spacing,duration,1); 
eps2                = repmat(abs(sim.traj.epsi(:,2))', duration, 1);
DCM.U.u(indU1(:),1) = 2;
DCM.U.u(indU1,2)    = eps2(:);

%% 2) Specify DCM settings 

% set priors
DCM.a = zeros(2,2);    
DCM.b = zeros(2,2,2);
DCM.c = zeros(2,2);
DCM.d = zeros(2,2,0);    

% initialize, set zeros
DCM.Ep.D       = zeros(2,2,0); 
DCM.Ep.transit = sparse(2,1);
DCM.Ep.decay   = sparse(2,1);
DCM.Ep.epsilon = 0;  

DCM.U.dt     = 0.2;          
DCM.U.name   = {'Driving','Modulating'};            

% neuronal 1     = simualate for output of neuronal states (finer time steps)
% neuronal 0     = simualate for output of BOLD states (coarser time steps)
for neuronal = 1:-1:0
        
    if neuronal
        DCM.v    = 5300; % finer time steps
        DCM.Y.dt = 0.2;
    else
        DCM.v    = 530;  % coarser time steps
        DCM.Y.dt = 2;
    end
    
    DCM.delays    = DCM.Y.dt/2*ones(2,1); 
    
    %% 3) Simulate DCM region time courses   
    
    [Y, X] = spm_dcm_generate_jh(DCM,1); % X - neuronal data, Y - BOLD data 
    
    % Assign simulated BOLD data to DCM structure
    DCM.Y.y = Y.yData;
    
    %% 4) Plot Neuronal or BOLD Signal    
    h = figure('WindowStyle', 'docked');    
    
    subplot(3,1,1); hold on;
    scatter((1:length(DCM.U.u(:,1))),DCM.U.u(:,1),'r',...
        'Marker','.','SizeData',20);
    scatter((1:length(DCM.U.u(:,1))),DCM.U.u(:,2),'m',...
        'Marker','.','SizeData',20);
    title('Inputs u');   
    set(gca,'YTick',[],'XTick',[],'FontSize',14);
    axis([0 length(DCM.U.u(:,1)) 0 max(DCM.U.u(:))]);
    legend('u_1 - stimuli','u_2 - context (\epsilon_2)')
    box off;
    
    subplot(3,1,2:3);
    if neuronal       
        plot((1:DCM.v),X.x(:,1),'g','LineWidth',2); hold on;
        plot((1:DCM.v),X.x(:,2),'b','LineWidth',2);
        title('Neuronal activity');
        axis([0 DCM.v min(X.x(:)) max(X.x(:))]);
        set(gca,'YTick',[],'FontSize',14); xlabel('Samples','FontSize',20);
        legend('x_1 - TPJ','x_2 - dmPFC')
        box off;        
    else        
        plot((1:DCM.v),Y.yData(:,1),'g','LineWidth',2); hold on;
        plot((1:DCM.v),Y.yData(:,2),'b','LineWidth',2);
        title('BOLD signal');
        axis([0 DCM.v min(Y.yData(:))-0.01 max(Y.yData(:))+0.01]);
        set(gca,'YTick',[],'FontSize',14); xlabel('Scans','FontSize',20);
        legend('x_1 - TPJ','x_2 - dmPFC')
        box off;        
    end
end

end