%% Input Data
clear all

% Parameters for Loading Data
Consumers=["thermalHeatConsumer_CHP.port_HeatDemand"];     % Path to the heatPorts of the Consumers in the Modelica model
numberOfConsumers=1;                                                            % Number of Consumers for for-loops
FilewoDisturbance='IES_MA_100_100_normal_DG.mat'; %result file without disturbance
FilewDisturbance='IES_MA_100_100_CHPfail_DG.mat'; %result file with disturbance
Resolution=1;                                                                 % Resolution of data [s]

% Parameter for Normalization and Tolerance Band
rel_tol=0.1;                                                                    % relative Tolerance value for tolerance band
t_norm=10000/3600;                                                                      % normalization time
StartofDisturbance=7000;                                                     % start time of disturbance [s]
EndofDisturbance=17000;                                                       % end time of disturbance [s]

%% Loading Data into workspace

res0=dym_loadResult(FilewoDisturbance);     %0... without disturbance
res1=dym_loadResult(FilewDisturbance);      %1... with disturbance

t0=dym_getResult(res0,'Time');
t1=dym_getResult(res1,'Time');

%% Declaration of heat flow variables 

for k = 1:numberOfConsumers
    q_flow_0(k,:)=dym_getResult(res0,[char(Consumers(k)) '.Q_flow'])*(1);
    q_flow_1(k,:)=dym_getResult(res1,[char(Consumers(k)) '.Q_flow'])*(1);
end

%% Calculating Weighting Factors

% Finding start and end indices for mean value calculation
[p,index]=min(abs(t0-StartofDisturbance));  
[p2,index2]=min(abs(t0-EndofDisturbance));

q_M=q_flow_0(:,index:index2);           % Matrix of individual heat flows during disturbance period
if numberOfConsumers==1 
    q_tot_M=q_M ;                       % Vector of total heat flow during disturbance period
else 
    q_tot_M=sum(q_M);
end;
Mean_q=(mean(q_M'));                      % Mean values of individual heat flows during disturbance period
Mean_q_tot=mean(q_tot_M');              % Mean value of total heat flow during disturbance period
Fac=(Mean_q./Mean_q_tot);               % Weighting Factors of Consumer

%% Create Matrices with the same size

for k = 1:numberOfConsumers
    m=1;
    t1r(:,1)=floor(t1(:)/1)*1;                % Round values of t1 to get values that are divideable by the resolution

    for i = t1(1):Resolution:t1(end)        
        for j=t1r(1):t1r(length(t1))
            if j==i                             % if value in t1 is divideable by resolution
                t_(1,m)=i;                      % next value in t=oldvalue+Resolution    
                o=find(t1r==j);                 % find index where value is i
                qf1(k,m)=q_flow_1(k,o(1));      % to get value of q_flow
                m=m+1;
                break
            end
        end
    end
    
    m=1;    
    t0r(:,1)=floor(t0(:)/1)*1;                % Same Procedure as above
    for i = t0(1):Resolution:t0(end)
        for j=t0r(1):t0r(length(t0))
            if j==i
                o=find(t0r==j);
                qf0(k,m)=q_flow_0(k,o(1));
                m=m+1;
                break
            end
        end
    end
end

%% Resilience Assessment

for k = 1:numberOfConsumers    
    %% Computation of maximum deviation Delta_x in Kelvin
 Delta_x(k)=-1;
    for i = 7000:length(qf0)
    Delta=(abs(qf0(k,i)-qf1(k,i)))-abs((rel_tol*qf0(k,i)));
    if Delta>Delta_x(k)
        Delta_x(k)=Delta;
        h(k)=i;
    end
    end
        if Delta_x(k) <0        % When there is no deviation outside the tolerance band, RI is set to 1
        RI_(k)=1;
    else        
        %% Calculation of normalization factors
        
        j(k)= h(k);     % Find Index where Delta x occurs
        x_norm(k)= qf0(k,j(k))*(1-rel_tol);                                                 % x_norm is undisturbed enthalpy flow at the time Delta x occurs
        A_norm(k)=t_norm*x_norm(k);
        
        %% Determination of time intervall [a,b] in which deviation occurs
        
        for i = 2:length(qf0)
            if abs(qf0(k,i)-qf1(k,i))>rel_tol*abs(qf0(k,i))                         % Find Index where characteristic value first leaves tolerance band
                a=i;
                break
            end
            a=length(qf0);
        end
        for i = a:length(qf0)                                                   % Find Index where characteristic value returns to tolerance band
            if abs(qf0(k,i)-qf1(k,i))<rel_tol*abs(qf0(k,i))
                b=i;
                break
            end
            b=length(qf0);
        end
        for i = b:length(qf0)                                                   % Another Round for reheating phase
            if abs(qf0(k,i)-qf1(k,i))>rel_tol*abs(qf0(k,i))
                c=i;
                break
            end
            c=b;                                                                % when there's no Reheating phase values of first loop are used
        end
        for i = c:length(qf0)                                                   % Same as above
            if abs(qf0(k,i)-qf1(k,i))<rel_tol*abs(qf0(k,i))
                d=i;
                break
            end
            d=length(qf0);
        end
        Index(k,:) = [a;b;c;d];
        
        %% Calculation of Delta_t and A
        
        Delta_t(k)=abs(t_(Index(k,1))-t_(Index(k,4)))/3600;                      % Compute Delta t
        A(k)=trapz(t_(1,Index(k,1):Index(k,4)),max(((abs(qf0(k,Index(k,1):Index(k,4))-qf1(k,Index(k,1):Index(k,4))))-rel_tol*abs(Mean_q(k))),0)/3600);  % Compute Integral
        
        %% Computation of Resilience Characteristics
        
        PL(k)=A(k)/A_norm(k);               % Performance Loss
        MD(k)=Delta_x(k)/x_norm(k);         % Maximum Deviation
        RT(k)=Delta_t(k)/t_norm;            % Recovery Time
        
        %% Computation of Irresilience and Resilience Index
        
        IR(k)=Delta_x(k)/x_norm(k)*Delta_t(k)/t_norm*A(k)/A_norm(k);        % Compute Irresilience Index
        RI_(k)=1/(1+IR(k));                                                 % Compute Resilience Index
        
    end
end
%% Computation of Total Resilience Index (Using Weighting Factors)

RI=sum(RI_.*Fac)
