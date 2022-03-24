clf
clear
clc

distance = load("COURSLOG/DISTANCE.txt");
theta = load("COURSLOG/THETA.txt");

% データが有るところだけ抽出
distance = nonzeros(distance); %mm
theta = theta(1:size(distance)); %rad

% x, yに変換
x = 0;
y = 0;
th = 0;
X = [];
Y = [];
pre_distance = 0;
pivot_lenght = 85; %mm
X_sens = [];
Y_sens = [];
for i = 1:size(distance)
    x = x + (distance(i) - pre_distance) * cos(th + theta(i)/2);
    y = y + (distance(i) - pre_distance) * sin(th + theta(i)/2);
    th = th + theta(i);
    X = [X x];
    Y = [Y y];
    X_sens = [X_sens, x + pivot_lenght * cos(th)];
    Y_sens = [Y_sens, y + pivot_lenght * sin(th)];

    pre_distance = distance(i);
end


figure(1)
hold on
scatter(X, Y, 5, 'b') % 生データ
scatter(X_sens, Y_sens, 10, 'r') % 補正後データ
title('1走目')
axis equal
hold off

% 円近似1
range1 = 15;
r_store1 = [];
for i = 1 : size(distance) - range1
    [cxe, cye, re] = CircleFitting(X_sens(i : i + range1), Y_sens(i : i + range1));
    if re >= 5000
        re = 5000;
    end
    r_store1 = [r_store1, re];
end 

% 円近似2
range2 = 20;
r_store2 = [];
for i = 1 : size(distance) - range2
    [cxe, cye, re] = CircleFitting(X_sens(i : i + range2), Y_sens(i : i + range2));
    if re >= 5000
        re = 5000;
    end
    r_store2 = [r_store2, re];
end 

% 今までの方法
theta(theta == 0) = 0.00001;
cir_distance = circshift(distance, 1);
cir_distance(1) = 0;
delta_distance = distance - cir_distance;
radius = abs(delta_distance ./ theta);
radius(radius > 5000) = 5000;

%shift
r_store1 = circshift(r_store1, range1);
r_store2 = circshift(r_store2, range2);

figure(2)
hold on
plot(1 : length(r_store1), r_store1, 'blue')
plot(1 : length(r_store2), r_store2, 'red')
plot(1 : length(radius), radius, 'black')
legend('Circle Fitting range: 10', 'Circle Fitting range; 20', 'Original way')
hold off

% ↓ Reference：https://myenigma.hatenablog.com/entry/2015/09/07/214600
function [ cx, cy, r ] = CircleFitting(x,y)
sumx=sum(x);
sumy=sum(y);
sumx2=sum(x.^2);
sumy2=sum(y.^2);
sumxy=sum(x.*y);

F=[sumx2 sumxy sumx;
   sumxy sumy2 sumy;
   sumx  sumy  length(x)];

G=[-sum(x.^3+x.*y.^2);
   -sum(x.^2.*y+y.^3);
   -sum(x.^2+y.^2)];

T=F\G;

cx=T(1)/-2;
cy=T(2)/-2;
r=sqrt(cx^2+cy^2-T(3));

end