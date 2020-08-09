%% Controlador continuo para Tacomodacao = 1s e %UP = 16%
%Sistema 1
s = tf('s');
sysC1 = 1/((s+1)*(s+2));
C1 = 5*s+61.24;
sys1 = (sysC1*C1)/(1+sysC1*C1);
figure(1);
step(sys1);
%% Sistema 2
sysC2 = 0.5/((s-1)*(s+2));
C2 = pid(32.3, -39.76, 7.46);
sys2 = (sysC2*C2)/(1+sysC2*C2);
figure(2);
step(sys2);

%% Discretização
% Para o sistema 1, utilizemos a ZOH e a Aproximacao bilinear de Tustin
% para gerar a comparacao das nossas discretizacoes
z = tf('z', 0.1);
sysDd1 = 1/((((20*(z-1))/(z+1))+1)*((20*(z-1))/(z+1)+2));
%controlador discretizado (aproximacao bilinear)
Cd1 = 5*((20*(z-1))/(z+1))+61.24;
sysD1 = (sysDd1*Cd1)/(1+sysDd1*Cd1);
figure(3);
step(sysD1);
hold on;
sysD1Zoh = c2d (sys1, 0.1);
step(sysD1Zoh);
deadB = 1/z;
step(deadB);
hold off;
% %% Para o sistema 2
sysD2 = c2d(sysC2, 0.1, 'tustin');
C2d = 32.3 - 39.76*(0.1/2)*((z+1)/(z-1)) + 7.46*(2/0.1)*((z-1)/(z+1));
sysD2 = feedback(C2d*sysD2, 1);
figure(4);
sysD2Zoh = c2d (sys2, 0.1);
step(sysD2);
hold on;
step(sysD2Zoh);
step(deadB);
hold off;
%% Analise da entrada de controle 
figure(5);
PID1 = c2d(pid(61.24, 0, 5), 0.1, 'tustin');
sys1 = PID1/(1+PID1*c2d(sysC1, 0.1, 'tustin'));
step(sys1, 1.5);
hold on;

dB = 1/(c2d(sysC1, 0.1)*(z-1));
sys1 = dB/(1 + dB*c2d(sysC1, 0.1));
step(sys1, 1.5);
hold off

%% Para o sistema 2
figure(6);
PID2 = C2d;
sys2 = PID2/(1+PID2*c2d(sysC2, 0.1, 'tustin'));
step(sys2, 1.5);
hold on;

dB2 = 1/(c2d(sysC2, 0.1)*(z-1));
sys2 = dB2/(1 + dB2*c2d(sysC2, 0.1));
step(sys2, 1.5);
hold off


