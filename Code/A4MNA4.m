cla;
close all;

R1 = 1;
C = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
R4 = 0.1;
alpha = 100;
RO = 1000;
Cn = 0.00001;
In0 = 0.001;

% V1 is V2 V3 iL ia V4 V5
G = [1 0 0 0 0 0 0 0;
    1/R1 1 -1/R1 0 0 0 0 0;
    0 0 1 -1 0 0 0 0;
    -1/R1 0 1/R1+1/R2 0 1 0 0 0; 
    0 0 0 1/R3 -1 0 0 0;
    0 0 0 -alpha/R3 0 0 1 0;
    0 0 0 0 0 1 1/R4 -1/R4; 
    0 0 0 0 0 0 -1/R4 1/RO+1/R4];
C1 = [0 0 0 0 0 0 0 0;
    C 0 -C 0 0 0 0 0; 
    0 0 0 0 -L 0 0 0; 
    -C 0 C 0 0 0 0 0;
    0 0 0 Cn 0 0 0 0; 
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0];
C2 = [0 0 0 0 0 0 0 0;
    C 0 -C 0 0 0 0 0; 
    0 0 0 0 -L 0 0 0; 
    -C 0 C 0 0 0 0 0;
    0 0 0 Cn*10 0 0 0 0; 
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0];
C3 = [0 0 0 0 0 0 0 0;
    C 0 -C 0 0 0 0 0; 
    0 0 0 0 -L 0 0 0; 
    -C 0 C 0 0 0 0 0;
    0 0 0 Cn*0.1 0 0 0 0; 
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0];

T = 10000;
In = In0*randn(1,T);
Vin = @(t) exp(-(t-0.06).^2/(2*0.03^2));
F = @(t,k) [Vin(t) 0 0 0 In(k) 0 0 0]';
V0 = 0; % All functions give zero voltage at t=0

dt = 1e-3;
A1 = C1/dt + G;
A2 = C2/dt + G;
A3 = C3/dt + G;
t = linspace(0,1,T);

V1 = zeros(T,8);
V1(1,:) = V0;
V2 = zeros(T,8);
V2(1,:) = V0;
V3 = zeros(T,8);
V3(1,:) = V0;
V4 = zeros(T,8);
V4(1,:) = V0;
for k=2:T
  V1(k,:) = A1\(C1*(V1(k-1,:)'/dt)+F(t(k),k));
  V2(k,:) = A2\(C2*(V2(k-1,:)'/dt)+F(t(k),k));
  V3(k,:) = A3\(C3*(V3(k-1,:)'/dt)+F(t(k),k));
end
figure(11);
plot(t,V1(:,8),t,V2(:,8),t,V3(:,8));
xlabel('t (s)');
ylabel('V_{out}');
legend('C_n','10C_n','0.1C_n');
title('Plot of V_{out} for Different C_n');

dt = 1e-4;
A4 = C1/dt + G;
for k=2:T
  V4(k,:) = A1\(C1*(V1(k-1,:)'/dt)+F(t(k),k));
end
figure(12);
plot(t,V1(:,8),t,V4(:,8));
xlabel('t (s)');
ylabel('V_{out}');
legend('1ms','0.1ms');
title('Plot of V_{out} for Different \Delta t');