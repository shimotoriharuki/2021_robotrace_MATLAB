clf
clear
% distance = load("COURSLOG/DISTANCE.txt");
% theta = load("COURSLOG/THETA.txt");
% distance2 = load("COURSLOG/DISTANC2.txt");
% theta2 = load("COURSLOG/THETA2.txt");
% vel_table = load("COURSLOG/VELTABLE.TXT");
distance = load("student/DISTANCE.txt");
theta = load("student/THETA.txt");
distance2 = load("student/DISTANC2.txt");
theta2 = load("student/THETA2.txt");
vel_table = load("student/VELTABLE.TXT");


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
pre_distance = 0;
for i = 1:size(distance)
%     x = x + (distance(i) - pre_distance) * cos(th + theta(i)/2);
%     y = y + (distance(i) - pre_distance) * sin(th + theta(i)/2);
    x = x + (distance(i)) * cos(th + theta(i)/2);
    y = y + (distance(i)) * sin(th + theta(i)/2);

    th = th + theta(i);
    X = [X x];
    Y = [Y y];

    pre_distance = distance(i);
end

x2 = 0;
y2 = 0;
th2 = 0;
X2 = [];
Y2 = [];
pre_distance = 0;
for i = 1:size(distance2)
%     x2 = x2 + (distance2(i) - pre_distance) * cos(th2 + theta2(i)/2);
%     y2 = y2 + (distance2(i) - pre_distance) * sin(th2 + theta2(i)/2);
    x2 = x2 + (distance2(i)) * cos(th2 + theta2(i)/2);
    y2 = y2 + (distance2(i)) * sin(th2 + theta2(i)/2);    
    th2 = th2 + theta2(i);
    X2 = [X2 x2];
    Y2 = [Y2 y2];
    pre_distance = distance2(i);
end

distance_shift = circshift(distance, 1);
distance_shift(1) = 0;
theta(theta==0) = 0.00001;
radius = abs((distance-distance_shift) ./ theta);
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
t = 0:radius_size-1;
plot(t, abs(radius))
title('半径')


figure(3)
vel_table = vel_table(1:size(distance));
t = 0:length(vel_table)-1;
plot(t, vel_table)
