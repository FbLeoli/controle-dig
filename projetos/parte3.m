%% identificacao de sistemas
sysC1 = tf(1, [1 3 2]);
N = 500;
sysD1 = c2d(ss(sysC1), 0.1);
u = -10 + (20)*rand(N, 1);
x1 = zeros(2, N);
[y1,y1obtido] = deal(zeros(1, N));
n = 2;
m = 2;
y1m = zeros(1, N+m);
um = zeros(1, N+n);
p = 1:N;
for i = 1:N-1
    x1(:,i+1) = sysD1.A*x1(:,i) + sysD1.B*u(i);
    y1(i) = sysD1.C*x1(:,i) + sysD1.D*u(i);
end
y1(N) = sysD1.C*x1(:,N) + sysD1.D*u(N);
A = zeros(N, 4);
for i = 1+m:N+m
    y1m(1, i) = y1(1, i-m);
    um(1, i) = u(i-n, 1);
end    
A(:, 1) = um(1, 2:N+1);
A(:, 2) = um(1, 3:N+2);
A(:, 4) = -y1m(1, 1:N);
A(:, 3) = -y1m(1, 2:N+1);

Mat = ((A'*A)\A');
coef = Mat*y1';
%% plotando
for i = 3:N-2
    y1obtido(1, i) = coef(1, 1)*u(i-1, 1) + coef(2, 1)*u(i-2, 1) - coef(3,1)*y1obtido(1, i-1) - coef(4,1)*y1obtido(1, i-2); 
end
figure(1);
plot(p, y1);
hold on;
plot(p, y1obtido);
hold off;
%% para o sistema 2
s = tf('s');
sysC2 = 0.5/((s-1)*(s+2));
sysC2 = (5*sysC2)/(1+5*sysC2);
sysD2 = c2d(ss(sysC2), 0.1);
N = 100;
x2 = zeros(4, N);
[y2,y2obtido] = deal(zeros(1, N));
n = 4;
m = 4;
y2m = zeros(1, N+m);
um = zeros(1, N+n);
p = 1:N;
u = randn(N, 1);
for i = 1:N-1
    x2(:,i+1) = sysD2.A*x2(:,i) + sysD2.B*u(i);
    y2(i) = sysD2.C*x2(:,i) + sysD2.D*u(i);
end
y2(N) = sysD2.C*x2(:,N) + sysD2.D*u(N);
A = zeros(N, 8);
for i = 1+m:N+m
    y2m(1, i) = y2(1, i-m);
    um(1, i) = u(i-n, 1);
end  
A(:, 1) = um(1, 2:N+1);
A(:, 2) = um(1, 3:N+2);
A(:, 3) = um(1, 4:N+3);
A(:, 4) = um(1, 5:N+4);
A(:, 8) = -y2m(1, 1:N);
A(:, 7) = -y2m(1, 2:N+1);
A(:, 6) = -y2m(1, 3:N+2);
A(:, 5) = -y2m(1, 4:N+3);

Mat = ((A'*A)\A');
coef = Mat*y2';
%% plotando
for i = 6:N
    y2obtido(1, i) = coef(1, 1)*(u(i-1, 1)) + coef(2, 1)*(u(i-2, 1)) + coef(3, 1)*(u(i-3, 1)) + coef(4, 1)*(u(i-4, 1)) - coef(5,1)*y2obtido(1, i-1) - coef(6,1)*y2obtido(1, i-2) - coef(7,1)*y2obtido(1, i-3) - coef(8,1)*y2obtido(1, i-4); 
end
sysC2 = 5*0.5/((s-1)*(s+2));
sysD2 = c2d(ss(sysC2), 0.1);

figure(2);
plot(p, y2);
hold on;
plot(p, y2obtido);
hold off;

%% identificacao de sistemas
sysC1 = 0.5/((s-1)*(s+2));
N = 100;
sysD1 = c2d(ss(sysC1), 0.1);
u = -10 + (20)*rand(N, 1);
x1 = zeros(2, N);
[y1,y1obtido] = deal(zeros(1, N));
n = 2;
m = 2;
y1m = zeros(1, N+m);
um = zeros(1, N+n);
p = 1:N;
for i = 1:N-1
    x1(:,i+1) = sysD1.A*x1(:,i) + sysD1.B*u(i);
    y1(i) = sysD1.C*x1(:,i) + sysD1.D*u(i);
end
y1(N) = sysD1.C*x1(:,N) + sysD1.D*u(N);
A = zeros(N, 4);
for i = 1+m:N+m
    y1m(1, i) = y1(1, i-m);
    um(1, i) = u(i-n, 1);
end    
A(:, 1) = um(1, 2:N+1);
A(:, 2) = um(1, 3:N+2);
A(:, 4) = -y1m(1, 1:N);
A(:, 3) = -y1m(1, 2:N+1);

Mat = ((A'*A)\A');
coef = Mat*y1';
%% plotando
for i = 3:N-2
    y1obtido(1, i) = coef(1, 1)*u(i-1, 1) + coef(2, 1)*u(i-2, 1) - coef(3,1)*y1obtido(1, i-1) - coef(4,1)*y1obtido(1, i-2); 
end
figure(3);
plot(p, y1);
hold on;
plot(p, y1obtido);
hold off;