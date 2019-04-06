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

% V1 is V2 V3 iL ia V4 V5
G = [1 0 0 0 0 0 0 0;
    1/R1 1 -1/R1 0 0 0 0 0;
    0 0 1 -1 0 0 0 0;
    -1/R1 0 1/R1+1/R2 0 1 0 0 0; 
    0 0 0 1/R3 -1 0 0 0;
    0 0 0 -alpha/R3 0 0 1 0;
    0 0 0 0 0 1 1/R4 -1/R4; 
    0 0 0 0 0 0 -1/R4 1/RO+1/R4];
C = [0 0 0 0 0 0 0 0;
    C 0 -C 0 0 0 0 0; 
    0 0 0 0 -L 0 0 0; 
    -C 0 C 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0];
%Ginv = inv(G)

F = [1 0 0 0 0 0 0 0];

V = G\F';

Vin = linspace(-10,10,20);
VOPlot = zeros(1,20);
V3Plot = zeros(1,20);
for i = 1:20
    V = G\(Vin(i)*F');
    V3Plot(i) = V(4);
    VOPlot(i) = V(8);
end
figure(1);
plot(Vin,V3Plot,Vin,VOPlot);
xlabel('V_{in} (V)');
ylabel('V (V)');
legend('V_3', 'V_{out}');
title('Plot of Node Voltages, DC Case')

omega = 2*pi*logspace(-1,3,20);
VOPlot2 = zeros(1,20);
for i = 1:20
    V = (G+1i*omega(i)*C)\(F');
    VOPlot2(i) = V(8);
end
figure(2);
semilogx(omega,abs(VOPlot2));
xlabel('\omega (rad/s)');
ylabel('V_{out} (V)');
title('Plot of Output Voltage, AC Case');