clf 
clear
distance = load("datas/speed1_0vs1_3/DISTANCE.txt");
theta = load("datas/speed1_0vs1_3/THETA.txt");
vel_table = load("datas/speed1_0vs1_3/VELTABLE.TXT");
distance2 = load("datas/speed1_0vs1_3/DISTANC2.txt");
theta2 = load("datas/speed1_0vs1_3/THETA2.txt");


% データが有るところだけ抽出
distance = nonzeros(distance); %mm
theta = theta(1:size(distance)); %rad

distance2 = nonzeros(distance2); %mm
theta2 = theta2(1:size(distance2)); %rad

pivot_lenght = 110; %mm
x = 0;
y = 0;
th = 0;
X = [];
Y = [];
X_sens = [];
Y_sens = [];
for i = 1:size(distance)
    x = x + distance(i) * cos(th + theta(i)/2);
    y = y + distance(i) * sin(th + theta(i)/2);
    th = th + theta(i);
    X = [X x];
    Y = [Y y];
    X_sens = [X_sens, x + pivot_lenght * cos(th)];
    Y_sens = [Y_sens, y + pivot_lenght * sin(th)];
end

x2 = 0;
y2 = 0;
th2 = 0;
X2 = [];
Y2 = [];
X_sens2 = [];
Y_sens2 = [];
for i = 1:size(distance2)
    x2 = x2 + distance2(i) * cos(th2 + theta2(i)/2);
    y2 = y2 + distance2(i) * sin(th2 + theta2(i)/2);
    th2 = th2 + theta2(i);
    X2 = [X2 x2];
    Y2 = [Y2 y2];
    X_sens2 = [X_sens2, x2 + pivot_lenght * cos(th2)];
    Y_sens2 = [Y_sens2, y2 + pivot_lenght * sin(th2)];
end


theta(theta==0) = 0.00001;
radius = distance ./ theta;
radius(radius>1500) = 1500;
radius(radius<-1500) = -1500;

theta2(theta2==0) = 0.00001;
radius2 = distance2 ./ theta2;
radius2(radius2>1500) = 1500;
radius2(radius2<-1500) = -1500;

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
hold on
scatter(X, Y, 10, colorAry)
title('1走目')

scatter(X_sens, Y_sens, 10)
hold off
axis equal

subplot(2, 1, 2)
hold on
scatter(X2, Y2, 10, colorAry2)
title('2走目')

scatter(X_sens2, Y_sens2, 10)
hold off
axis equal

% -------X_sens, Y_sensからdistanceとthetaを計算
th = 0;
distance_cor = [];
for i = 1:size(distance)-1
    th = th + theta(i);
    distance_cor = [distance_cor, sqrt((X_sens(i+1) - X_sens(i))^2 + (Y_sens(i+1) - Y_sens(i))^2)];
end
X_cor = [];
Y_cor = [];
for i = 1:size(distance_cor')
    x = x + distance_cor(i) * cos(th + theta(i)/2);
    y = y + distance_cor(i) * sin(th + theta(i)/2);
    th = th + theta(i);
    X_cor = [X_cor x];
    Y_cor = [Y_cor y];
end

figure(4)
hold on
scatter(X_sens, Y_sens)
scatter(X_cor, Y_cor)
hold off
axis('equal')

%---------
figure(2)
subplot(2, 1, 1)
t = 0:radius_size-1;
plot(t, abs(radius))
title('半径')

subplot(2, 1, 2)
t = 0:radius_size2-1;
plot(t, abs(radius2))
title('半径')

figure(3)
vel_table = vel_table(1:size(distance));
t = 0:length(vel_table)-1;
plot(t, vel_table)
