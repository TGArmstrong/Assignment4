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

F = [1 0 0 0 0 0 0 0]';
F1 = @(t) (t > 0.03);
F2 = @(t) sin(2*pi/0.03*t);
F3 = @(t) exp(-(t-0.06).^2/(2*0.03^2));
V0 = 0; % All functions give zero voltage at t=0

dt = 1e-3;
T = 1000;
A = C/dt + G;
t = linspace(0,1,T);

V1 = zeros(T,8);
V1(1,:) = V0;
V2 = zeros(T,8);
V2(1,:) = V0;
V3 = zeros(T,8);
V3(1,:) = V0;
for k=2:T
  V1(k,:) = A\(C*(V1(k-1,:)'/dt)+F*F1(t(k)));
  V2(k,:) = A\(C*(V2(k-1,:)'/dt)+F*F2(t(k)));
  V3(k,:) = A\(C*(V3(k-1,:)'/dt)+F*F3(t(k)));
end
figure(3);
plot(t,F1(t),t,V1(:,8));
xlabel('t (s)');
ylabel('V_{out}');
title('Plot of V_{out} for a Step Function');

figure(4);
plot(t,F2(t),t,V2(:,8));
xlabel('t (s)');
ylabel('V_{out}');
title('Plot of V_{out} for a Sine Wave');

figure(5);
plot(t,F3(t),t,V3(:,8));
xlabel('t (s)');
ylabel('V_{out}');
title('Plot of V_{out} for a Gaussian Pulse');

Fmax = 1/(2*dt); 
Vf1 = fft(V1);
Vf1 = fftshift(abs(Vf1(:,8)));
Vf2 = fft(V2);
Vf2 = fftshift(abs(Vf2(:,8)));
Vf3 = fft(V3);
Vf3 = fftshift(abs(Vf3(:,8)));
f = linspace(-Fmax,Fmax,T);

figure(6);
semilogy(f,Vf1);
xlabel('f (Hz)');
ylabel('P');
title('Plot of Frequency Spectrum for a Step Function');

figure(7);
semilogy(f,Vf2);
xlabel('f (Hz)');
ylabel('P');
title('Plot of Frequency Spectrum for a Sine Wave');

figure(8);
semilogy(f,Vf3);
xlabel('f (Hz)');
ylabel('P');
title('Plot of Frequency Spectrum for a Gaussian Pulse');