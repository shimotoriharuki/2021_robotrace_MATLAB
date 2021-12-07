clf
clear
distance = load("datas/DISTANCE.txt");
theta = load("datas/THETA.txt");

% データが有るところだけ抽出
distance = nonzeros(distance); %mm
theta = theta(1:size(distance)); %rad

x = 0;
y = 0;
th = 0;

X = [];
Y = [];
X_sens = [];
Y_sens = [];
pivot_lenght = 110; %mm
for i = 1:size(distance)
    x = x + distance(i) * cos(th + theta(i)/2);
    y = y + distance(i) * sin(th + theta(i)/2);
    th = th + theta(i);
    X = [X x];
    Y = [Y y];
    X_sens = [X_sens, x + pivot_lenght * cos(th)];
    Y_sens = [Y_sens, y + pivot_lenght * sin(th)];

end

radius = distance ./ theta;
radius(radius>1000) = 1000;
radius(radius<-1000) = -1000;

radius_size = length(radius);

colorAry = [0, 0, 0];
for i = 1 : radius_size-1
    colorAry = [colorAry;  [abs(radius(i))/1000 0 0]];
%     if abs(radius(i)) < 150
%         colorAry = [colorAry;  [1 0 0]];
%     elseif abs(radius(i)) < 500
%         colorAry = [colorAry;  [0 1 0]];
%     elseif abs(radius(i)) < 1500
%         colorAry = [colorAry;  [0 0 0]];
%     else
%         colorAry = [colorAry;  [0 0 0]];
%     end
end

figure(1)
subplot(2, 1, 1)
scatter(X, Y, 10, colorAry)
title('ロボットの位置')
axis equal

subplot(2, 1, 2)
scatter(X_sens, Y_sens, 10, [0, 0, 1])
title('センサーの位置')
axis equal