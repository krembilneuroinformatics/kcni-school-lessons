function [inputVector, theta_t] = gen_design(meanProb, nTrials)
%
% This code generates sequences according to the Hierarchical Gaussian Filter model: 
% theta_r and theta_t are probabilities drawn from a Bernoulli
% distribution pertaining to the tone category(x1 in the HGF).
% The thetas are the sigmoid transformation of x2_r and x2_t, respectively: a
% state that performs a Gaussian random walk (with variable drift). Its
% step size is determined by kappa and omega (fixed) and x_3 (which is
% fixed, the variable name is th).

%
% --------------------------------------------------------------------------------------------------
% Andreea Diaconescu and Falk Lieder, TNU, UZH & ETHZ

stream=RandStream('mrg32k3a', 'Seed', 12345678);
RandStream.setGlobalStream(stream);

pathname = fileparts(mfilename('fullpath'));

%initialize values
if nargin < 2
nTrials = 99;
end
th_t=3.5; %log(0.2); %5 %% Change volatility (high to low)
ka_t=1;
om_t=-2.5;
sigma2_t=exp(ka_t.*th_t+om_t);
inputVector=nan(1,nTrials);
inputVector(1)=0;
x2_t(1)=0;

%add drift, phi is the speed of the drift 0.1
%m value that the state fluctuates around, which we can set to 1 (sigmoid
%of 0 is 0.5, 1.5 is 81.8%)
m_t=meanProb;
phi = 1; % set to 0 for no drift; set to negative values to drift away from the mean

for k=1:nTrials
    x2_t(k+1)=x2_t(k)+phi.*(m_t-x2_t(k))+randn().*sigma2_t;
    theta_t(k+1) = tapas_sgm(x2_t(k+1), 1);      
       inputVector(k+1)=(rand()<=theta_t(k+1));      
end
% figure;
% hs(1) = subplot(2,1,1);
% stem(inputVector, 'm--');
% ylim=([-0.3 1.1]);
% hold all
% plot(theta_t, 'r', 'LineWidth', 3);
% legend('t', '\theta_t');
% hs(2) = subplot(2,1,2);
% plot(x2_t); hold all
% legend('x_{2,t}')
% linkaxes(hs, 'x');
% inputVector=inputVector';
end