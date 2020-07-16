%% Controlador continuo para Tacomodacao = 1s e %UP = 16%
%Sistema 1
s = tf('s');
sysC1 = 1/((s+1)*(s+2));
C1 = 5*s+61.24;
sys1 = (sysC1*C1)/(1+sysC1*C1);
figure(1);
step(sys1);
%% Sistema 1
sysC2 = 0.5/((s-1)*(s+2));
C2 = (125*(s-1)*(s+2))/(s*(s+8));
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
%% Para o sistema 2
sysD2 = 1/((((20*(z-1))/(z+1))-1)*((20*(z-1))/(z+1)+2));
%controlador discretizado (aproximacao bilinear)
Cd2 = (125*(((20*(z-1))/(z+1))-1)*(((20*(z-1))/(z+1))+2))/(((20*(z-1))/(z+1))*(((20*(z-1))/(z+1))+8));
sysD2 = (sysD2*Cd2)/(1+sysD2*Cd2);
figure(4);
step(sysD2);
hold on;
sysD2Zoh = c2d (sys2, 0.1);
step(sysD2Zoh);
step(deadB);
hold off;

