function design = mmn_create_design_file( sim, designType )
%mmn_CREATE_DESIGN_FILE Creates the design file which holds the subject-specific EEG regressors
%(before removing artifactual trials) from the belief simulation for this subject
%   IN:     sim         - the struct which is the output of the HGF simulation and already holds the
%                       relevant regressors
%           designType  - string indicating which design to use
%   OUT:    design      - a struct with as many fields as regressors in the first level modelbased
%                       analysis

switch designType
    case 'epsilon'
        design.epsilon2 = sim.reg.epsi2;
        design.epsilon3 = sim.reg.epsi3;
        
    case 'plustime'
        design.epsilon2 = sim.reg.bayesian;
        design.epsilon3 = sim.reg.epsi3;
        design.time = [1: length(design.epsilon3)]';
        
    case 'HGF'
        design.delta1 = sim.reg.delta1;
        design.sigma2 = sim.reg.sigma2;
        design.delta2 = sim.reg.delta2;
        design.sigma3 = sim.reg.sigma3;
    
    case 'epsilonS'
        design.transPE = sim.reg.repetition;
        design.repetPE = sim.reg.bayesian;
        design.epsilon3 = sim.reg.epsi3;
        
    case 'shannon'
        design.epsilon2 = sim.reg.bayesian;
        design.epsilon3 = sim.reg.epsi3;
        design.shannon = sim.reg.shannon;
end


end

