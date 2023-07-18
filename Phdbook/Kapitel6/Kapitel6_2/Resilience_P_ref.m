%% Input Data
clear all

% Parameters for Loading Data
Consumers=["L1","Lb","Lc","La","electricBoiler"];     % Path to the heatPorts of the Consumers in the Modelica model
numberOfConsumers=4;                                                            % Number of Consumers for for-loops
FilewoDisturbance='IES_MA_50_100_normal_DGneuload.mat'; %result file without disturbance
FilewDisturbance='IES_MA_50_100_CHPfail_DGneuload.mat'; %result file with disturbance
Resolution=1;                                                                 % Resolution of data [s]

% Parameter for Normalization and Tolerance Band
rel_tol=0.1;                                                                    % relative Tolerance value for tolerance band
t_norm=25000/3600;                                                                      % normalization time
StartofDisturbance=7000;                                                     %start time of disturbance [s]
EndofDisturbance=32000;                                                        % end time of disturbance [s]

%% Loading Data into workspace

res0=dym_loadResult(FilewoDisturbance);     %0... without disturbance
res1=dym_loadResult(FilewDisturbance);      %1... with disturbance

t0=dym_getResult(res0,'Time');
t1=dym_getResult(res1,'Time');

%% Declaration of heat flow variables 

for k = 1:numberOfConsumers
    P_flow_0(k,:)=dym_getResult(res0,[char(Consumers(k)) '.epp.P']);
    P_flow_1(k,:)=dym_getResult(res1,[char(Consumers(k)) '.epp.P']);
end

%% Calculating Weighting Factors

% Finding start and end indices for mean value calculation
[p,index]=min(abs(t0-StartofDisturbance));  
[p2,index2]=min(abs(t0-EndofDisturbance));

P_M=P_flow_0(:,index:index2);           % Matrix of individual heat flows during disturbance period
P_tot_M=sum(P_M);                       % Vector of total heat flow during disturbance period

Mean_P=mean(P_M');                      % Mean values of individual heat flows during disturbance period
Mean_P_tot=mean(P_tot_M');              % Mean value of total heat flow during disturbance period
Fac=(Mean_P./Mean_P_tot);               % Weighting Factors of Consumers

%% Create Matrices with the same size

for k = 1:numberOfConsumers
    m=1;
    t1r(:,1)=floor(t1(:)/1)*1;                % Round values of t1 to get values that are divideable by the resolution

    for i = t1(1):Resolution:t1(end)        
        for j=t1r(1):t1r(length(t1))
            if j==i                             % if value in t1 is divideable by resolution
                t_(1,m)=i;                      % next value in t=oldvalue+Resolution    
                o=find(t1r==j);                 % find index where value is i
                P1(k,m)=P_flow_1(k,o(1));      % to get value of q_flow
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
                P0(k,m)=P_flow_0(k,o(1));
                m=m+1;
                break
            end
        end
    end
end

%% Resilience Assessment

for k = 1:numberOfConsumers    
    %% Computation of maximum deviation Delta_x in Kelvin
    
    Delta_x(k)=max(abs(P0(k,:)-P1(k,:)))-(rel_tol*Mean_P(k));
    
    if Delta_x(k) <0        % When there is no deviation outside the tolerance band, RI is set to 1
        RI_(k)=1;
    else        
        %% Calculation of normalization factors
        
         j(k)= (find(abs(P0(k,:)-P1(k,:))==Delta_x(k)+rel_tol*Mean_P(k)));     % Find Index where Delta x occurs
        x_norm(k)= P0(k,j(k))*(1-rel_tol);                                                 % x_norm is undisturbed enthalpy flow at the time Delta x occurs
        A_norm(k)=t_norm*x_norm(k);
        
        %% Determination of time intervall [a,b] in which deviation occurs
        
        for i = 7000:length(P0)
            if abs(P0(k,i)-P1(k,i))>rel_tol*P0(k,i)                         % Find Index where characteristic value first leaves tolerance band
                a=i;
                break
            end
            a=length(P0);
        end
        for i = a:length(P0)                                                   % Find Index where characteristic value returns to tolerance band
            if abs(P0(k,i)-P1(k,i))<rel_tol*P0(k,i)
                b=i;
                break
            end
            b=length(P0);
        end
        for i = b:length(P0)                                                   % Another Round for reheating phase
            if abs(P0(k,i)-P1(k,i))>rel_tol*Mean_P(k)
                c=i;
                break
            end
            c=b;                                                                % when there's no Reheating phase values of first loop are used
        end
        for i = c:length(P0)                                                   % Same as above
            if abs(P0(k,i)-P1(k,i))<rel_tol*Mean_P(k)
                d=i;
                break
            end
            d=length(P0);
        end
       Index(k,:) = [a;b;c;d];
     %    Index(k,:) = [a;b];
        %% Calculation of Delta_t and A
        
        Delta_t(k)=abs(t_(Index(k,1))-t_(Index(k,4)))/3600;                      % Compute Delta t
        A(k)=trapz(t_(1,Index(k,1):Index(k,4)),max(((abs(P0(k,Index(k,1):Index(k,4))-P1(k,Index(k,1):Index(k,4))))-rel_tol*Mean_P(k)),0)/3600);  % Compute Integral
        
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