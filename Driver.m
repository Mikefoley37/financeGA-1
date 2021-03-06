close all
clear all

% This is the driver program which will make calls to other subprograms and
% iterate through time. Default settings are determined here.

% Uses matrix representation to store conditions
% each first dimension (row) represents an individual strategy
% each second dimension (column) represents a binary state of the market
% Each third dimension represents an agent and all his strategies

%Global variables that we might want to access in different parts of code
%so we don't need to pass it every time we call the function.

%global conditions   % conditions that agents hold that they try to match to strategies
%global actions      % Buy/sell and strengths
%global prices        % History of prices
global agent
global market


%Constants that don't ever change throughout run:

Lstrats = 3;     % first dimension
Ntraders = 4;   % second dimension
Nstrats = 5;     % third dimension
tmax = 2;

%Initialization:

%conditions = randi([-1 1],Nstrats,Lstrats,Ntraders); %Create random strategies
%actions = ones(Nstrats,2,Ntraders);
%actions(:,1,:) = randi([0 1],Nstrats,1,Ntraders);
%state = getMarketState(Lstrats);         
t = 0;

agent = struct('conditions',randi([-1 1],Nstrats,Lstrats,Ntraders),...
    'actions',randi([0 1],Nstrats,1,Ntraders),...
    'strengths',ones(Nstrats,2,Ntraders));

market = struct('state',getMarketState(Lstrats),...
    'price',zeros(100,1));


% To test if match, 0's mean strategy matches market
test = sum(agent.conditions == market.state(ones(1,Nstrats),:,ones(1,Ntraders)),2) - sum(abs(agent.conditions),2)


%to extract only the strategy that each agent should use
%    NOT EXACTLY RIGHT

[cond nagent] = find(test ==0)
[useless ind] = unique(nagent,'first');  %Need better method for this

cond = cond(ind)
nagent = nagent(ind)

% Now index into actions matrix into (agent,cond) and somehow use 
% that action
agent.actions(cond,nagent)




%while t < tmax
%    state = getMarketState(Lstrats);
%    
%    
%    
%end


