clf
clear
distance = load("datas/DISTANCE.txt");
theta = load("datas/THETA.txt");
vel_table = load("datas/VELTABLE.TXT");
distance2 = load("datas/DISTANC2.txt");
theta2 = load("datas/THETA2.txt");


% データが有るところだけ抽出
distance = nonzeros(distance); %mm
theta = theta(1:size(distance)); %rad

distance2 = nonzeros(distance2); %mm
theta2 = theta2(1:size(distance2)); %rad


x = 0;
y = 0;
th = 0;
X = [];
Y = [];
for i = 1:size(distance)
    x = x + distance(i) * cos(th + theta(i)/2);
    y = y + distance(i) * sin(th + theta(i)/2);
    th = th + theta(i);
    X = [X x];
    Y = [Y y];
end

x2 = 0;
y2 = 0;
th2 = 0;
X2 = [];
Y2 = [];
for i = 1:size(distance2)
    x2 = x2 + distance2(i) * cos(th2 + theta2(i)/2);
    y2 = y2 + distance2(i) * sin(th2 + theta2(i)/2);
    th2 = th2 + theta2(i);
    X2 = [X2 x2];
    Y2 = [Y2 y2];
end


theta(theta==0) = 0.00001;
radius = abs(distance ./ theta);
radius(radius>5000) = 5000;
radius(radius<-5000) = -5000;

theta2(theta2==0) = 0.00001;
radius2 = abs(distance2 ./ theta2);
radius2(radius2>5000) = 5000;
radius2(radius2<-5000) = -5000;

radius_size = length(radius);
radius_size2 = length(radius2);


colorAry = [0, 0, 0];
for i = 1 : radius_size-1
    colorAry = [colorAry;  [abs(radius(i))/1000 0 0]];
end

colorAry2 = [0, 0, 0];
for i = 1 : radius_size2-1
    colorAry2 = [colorAry2;  [abs(radius2(i))/1000 0 0]];
end

figure(1)
subplot(2, 1, 1)
scatter(X, Y, 10, colorAry)
title('1走目')
axis equal

subplot(2, 1, 2)
scatter(X2, Y2, 10, colorAry2)
title('2走目')
axis equal

figure(2)
% subplot(2, 1, 1)
t = 0:radius_size-1;
% hold on
plot(t, abs(radius))
title('半径')

% subplot(2, 1, 2)
% radius_f = medfilt1(radius, 30);
% radius_f= lowpass(radius, 1e-5);

t = 0:length(radius)-1;
plot(t, abs(radius))
title('半径 ')
hold off

figure(3)
vel_table = vel_table(1:size(distance));
% subplot(2, 1, 1)
hold on
t = 0:length(vel_table)-1;
plot(t, vel_table)
% ylim([0.9 1.8])
% vel_table_med = medfilt1(vel_table, 20);
% t = 0:length(vel_table)-1;
% plot(t, vel_table_med)
% hold off
% subplot(2, 1, 2)
t = 0:length(distance2)-1;
plot(t, distance2)
hold off
% ylim([0.9 1.8])
