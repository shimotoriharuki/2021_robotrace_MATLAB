clf
clear
distance = load("datas2/DISTANCE.txt");
theta = load("datas2/THETA.txt");
distance2 = load("datas2/DISTANC2.txt");
theta2 = load("datas2/THETA2.txt");
vel_table = load("datas2/VELTABLE.TXT");


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
radius = distance ./ theta;
radius(radius>5000) = 5000;
radius(radius<-5000) = -5000;

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
scatter(X, Y, 10, colorAry)
title('1走目')
axis equal

subplot(2, 1, 2)
t = 0:radius_size-1;
plot(t, abs(radius))
title('半径')

figure(2)
vel_table = vel_table(1:size(distance));
subplot(2, 1, 1)
t = 0:length(vel_table)-1;
plot(t, vel_table)
% ylim([1.2 1.9])

decelerate_table = vel_table;
idx = length(vel_table);

am = 1;
while idx > 1
    if decelerate_table(idx-1) - decelerate_table(idx) > 0 % 正のとき
        t = 10e-3 / (decelerate_table(idx-1) - decelerate_table(idx));
        a = (decelerate_table(idx-1) - decelerate_table(idx)) / t;
        if a > am
%             decelerate_table(idx-1) = decelerate_table(idx) + am * t;%  
%             decelerate_table(idx-1) = decelerate_table(idx) + sqrt(am*10e-3);
            decelerate_table(idx-1) = decelerate_table(idx) + am*10e-3;

        end
    end
    idx = idx - 1;
end

subplot(2, 1, 2)
t = 0:length(decelerate_table)-1;
plot(t, decelerate_table)
% ylim([1.2 1.9])


%---------------------------------------%
figure(3)
first_distance = [0];
for i = 1:size(distance)
    first_distance = [first_distance, first_distance(i) + distance(i)];
end

t = 0:length(first_distance)-1;
plot(t, first_distance)
hold on

t = 0:length(distance2)-1;
plot(t, distance2./0.9663)
hold off
