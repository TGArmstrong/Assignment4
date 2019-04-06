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
C = [0 0 0 0 0 0 0 0;
    C 0 -C 0 0 0 0 0; 
    0 0 0 0 -L 0 0 0; 
    -C 0 C 0 0 0 0 0;
    0 0 0 Cn 0 0 0 0; 
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0; 
    0 0 0 0 0 0 0 0];

T = 10000;
In = In0*randn(1,T);
Vin = @(t) exp(-(t-0.06).^2/(2*0.03^2));
F = @(t,k) [Vin(t) 0 0 0 In(k) 0 0 0]';
V0 = 0; % All functions give zero voltage at t=0

dt = 1e-3;
A = C/dt + G;
t = linspace(0,1,T);

V = zeros(T,8);
V(1,:) = V0;
for k=2:T
  V(k,:) = A\(C*(V(k-1,:)'/dt)+F(t(k),k));
end
figure(9);
plot(t,V(:,8));
xlabel('t (s)');
ylabel('V_{out}');
title('Plot of V_{out} for a Gaussian Pulse, w/ Noise');

Fmax = 1/(2*dt); 
Vf = fftshift(abs(fft(V(:,8))));
f = linspace(-Fmax,Fmax,T);
figure(10);
semilogy(f,Vf);
xlabel('f (Hz)');
ylabel('P');
title('Plot of Frequency Spectrum for a Gaussian Pulse, w/ Noise');
