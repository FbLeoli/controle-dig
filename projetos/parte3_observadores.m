sysC1 = tf(1, [1 3 2]);
sysD1 = c2d(ss(sysC1), 0.1);
% Realizando os calculos para polos em 0.3 e 0.4:
L=place(sysD1.A',sysD1.C',[0.3 0.4])';
N = 30;
n = 1:N;
u = ones(N, 1);
[x1,x2, x1O, x2O] = deal(zeros(2, N));
x1(:, 1) = [1, 1];
[y1,y2, y1O, y2O] = deal(zeros(1, N));
for i = 1:N-1
    y1(i) = sysD1.C*x1(:,i) + sysD1.D*u(i) -0.01 + (0.02)*rand(1);
    x1(:,i+1) = sysD1.A*x1(:,i) + sysD1.B*u(i);
end
for i = 1:N-1
    y1O(i) = sysD1.C*x1O(:,i) + sysD1.D*u(i);
    x1O(:,i+1) = sysD1.A*x1O(:,i) + sysD1.B*u(i) + L*(y1(i) - y1O(i));
end
figure(1);
stem(n, x1(1,:));
hold on;
stem(n, x1O(1,:));
hold off;
figure(2);
stem(n, x1(2,:));
hold on;
stem(n, x1O(2,:));
hold off;
%% Para o segundo estado
sysC2 = tf(1, [1 1 -2]);
sysD2 = c2d(ss(sysC2), 0.1);
% Realizando os calculos para polos em 0.3 e 0.4:
L2=place(sysD2.A',sysD2.C',[0.3 0.4])';
N = 30;
n = 1:N;
u = ones(N, 1);
x2(:, 1) = [1, 1];
for i = 1:N-1
    y2(i) = sysD2.C*x2(:,i) + sysD2.D*u(i) -0.01 + (0.02)*rand(1);
    x2(:,i+1) = sysD2.A*x2(:,i) + sysD2.B*u(i);
end
for i = 1:N-1
    y2O(i) = sysD2.C*x2O(:,i) + sysD2.D*u(i);
    x2O(:,i+1) = sysD2.A*x2O(:,i) + sysD2.B*u(i) + L2*(y2(i) - y2O(i));
end
figure(3);
stem(n, x2(1,:));
hold on;
stem(n, x2O(1,:));
hold off;
figure(4);
stem(n, x1(2,:));
hold on;
stem(n, x1O(2,:));
hold off;
