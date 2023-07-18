%% Input Data
clear all

% Parameters for Loading Data
Consumers=["gCVSensor_chp"];       % Path of the gcV_Sensor in the Modelica model
numberOfConsumers=1;                                                            % Number of Consumers for for-loops
FilewoDisturbance='IES_MA_100_100_normal_DG.mat'; %result file without disturbance
FilewDisturbance='IES_MA_100_100_CHPfail_DG.mat'; %result file with disturbance
                                                                % Resolution of data [s]
% Parameter for Normalization and Tolerance Band
rel_tol=0.1;                                                                    % relative Tolerance value for tolerance band
t_norm=10000/3600;                                                                      % normalization time
StartofDisturbance=3123900;                                                     % start time of disturbance [s]
EndofDisturbance=3174300;                                                       % end time of disturbance [s]

% Parameters for Assessment of On/Off Operation
OperationMode=[1 1 1 1];                                                        % 0... continuous operation; 1... On/Off operation
setPoint=[0 0   25.292 0];                                                      % only used for On/Off operation
Resolution=1;                                                                 % Resolution of data [s]
Delay=[0 0 3600 0];                                                             %Time delay with which on off operated device is shut on again

%% Loading Data into workspace

res0=dym_loadResult(FilewoDisturbance);     %0... without disturbance
res1=dym_loadResult(FilewDisturbance);      %1... with disturbance

t0=dym_getResult(res0,'Time');
t1=dym_getResult(res1,'Time');

%% Declaration of enthalpy and mass flow variables

for k = 1:numberOfConsumers
%     h_0(k,:)=dym_getResult(res0,[char(Consumers(k)) '.GCV']);
%     m_flow_0(k,:)=dym_getResult(res0,[char(Consumers(k)) '.gasPortIn.m_flow']);
%     h_1(k,:)=dym_getResult(res1,[char(Consumers(k)) '.GCV']);
%     m_flow_1(k,:)=dym_getResult(res1,[char(Consumers(k)) '.gasPortIn.m_flow']);
  h_flow_1(k,:)=dym_getResult(res1,[char(Consumers(k)) '.H_flow_GCV'])*(-1);
  h_flow_0(k,:)=dym_getResult(res0,[char(Consumers(k)) '.H_flow_GCV'])*(-1);
end

%% Calculating Enthalpy Flows
% 
% h_flow_0=h_0.*m_flow_0/1e6;
% h_flow_1=h_1.*m_flow_1/1e6;

%% Calculating Weighting Factors

% Finding start and end indices for mean value calculation
[p,index]=min(abs(t0-StartofDisturbance));  
[p2,index2]=min(abs(t0-EndofDisturbance));

h_M=h_flow_0(:,index:index2);               % Matrix of individual enthalpy flows during disturbance period
h_tot_M=sum(h_M);                           % Vector of total enthalpy flow during disturbance period

Mean_h=mean(h_M');                          % Mean values of individual enthalpy flows during disturbance period
Mean_h_tot=mean(h_tot_M');                  % Mean value of total enthalpy flow during disturbance period
Fac=(Mean_h./Mean_h_tot);                   % Weighting Factors of Consumers

%% Create Matrices with the same size

for k = 1:numberOfConsumers
    m=1;
    t1r(:,1)=floor(t1(:)/1)*1;                % Round values of t1 to get values that are divideable by the resolution
    for i = t1(1):Resolution:t1(end)
        for j=t1r(1):t1r(length(t1))
            if j==i                             % if value in t1 is divideable by resolution
                t_(1,m)=i;                      % next value in t=oldvalue+Resolution    
                o=find(t1r==j);                 % find index where value is i
                hf1(k,m)=h_flow_1(k,o(1));      % to get value of h_flow
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
                hf0(k,m)=h_flow_0(k,o(1));
                m=m+1;
                break
            end
        end
    end
end

%% Resilience Assessment

for k = 1:numberOfConsumers
    %% Computation of maximum deviation Delta_x in MW
        Delta_x(k)=-1;
    for i = 500:length(hf0)
    Delta=(abs(hf0(k,i)-hf1(k,i)))-abs((rel_tol*hf0(k,i)));
    if Delta>Delta_x(k)
        Delta_x(k)=Delta;
        h(k)=i;
    end
      end
%         Delta_x(k)=max(abs(hf0(k,:)-hf1(k,:)))-(rel_tol*Mean_h(k));
%     
    if Delta_x(k) <0        % When there is no deviation outside the tolerance band, RI is set to 1
        RI_(k)=1;
    else
            %% Calculation of normalization factors
         j(k)=h(k);   
        %    j(k)= (find(abs(hf0(k,:)-hf1(k,:))==Delta_x(k)+rel_tol*Mean_h(k)));     % Find Index where Delta x occurs
            x_norm(k)=0.9* hf0(k,j(k));                                                 % x_norm is undisturbed enthalpy flow at the time Delta x occurs
            A_norm(k)=t_norm*x_norm(k);
            
            %% Determination of time intervall [a,b] in which deviation occurs
            
            for i = 500:length(hf0)
                if abs(hf0(k,i)-hf1(k,i))>rel_tol*abs(hf0(k,i))                 % Find Index where characteristic value first leaves tolerance band
                    a=i;
                    break
                end
                a=length(hf0);
            end
            for i = a:length(hf0)                                            % Find Index where characteristic value returns to tolerance band
                 if abs(hf0(k,i)-hf1(k,i))<rel_tol*abs(hf0(k,i)) 
                    b=i;
                    break
                end
                b=size(hf0);
            end
            for i = b:length(hf0)                                           % Another Round for reheating phase
                if abs(hf0(k,i)-hf1(k,i))>rel_tol*abs(hf0(k,i)) 
                    c=i;
                    break
                end
                c=b;                                                        % when there's no Reheating phase values of first loop are used
            end
            for i = c:length(hf0)                                           % Same as above
                if abs(hf0(k,i)-hf1(k,i))<rel_tol*abs(hf0(k,i)) 
                    d=i;
                    break
                end
                d=length(hf0);
            end
            Index(k,:) = [a; b;c;d];
            
            %% Calculation of Delta_t and A
            
            Delta_t(k)=abs(t_(Index(k,1))-t_(Index(k,4)))/3600;             % Compute Delta t
        A_tot(k)=trapz(t_(1,Index(k,1):Index(k,4)),max(((abs(hf0(k,Index(k,1):Index(k,4))-hf1(k,Index(k,1):Index(k,4))))),0)/3600);  % Compute Integral
        A_tol(k)=trapz(t_(1,Index(k,1):Index(k,4)),max(((abs(hf0(k,Index(k,1):Index(k,4))*(1-rel_tol)-hf0(k,Index(k,1):Index(k,4))))),0)/3600);  % Compute Integral
        A(k)=A_tot(k)-A_tol(k);
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
RI_