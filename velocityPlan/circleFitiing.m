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

% 円近似
range = 20;
r_store = [];

figure(2)
for i = 1 : size(distance) - range
    [cxe,cye,re] = CircleFitting(X_sens(i : i + range), Y_sens(i : i + range));
    if re >= 5000
        re = 5000;
    end
    r_store = [r_store, re];
end 

plot(1:length(r_store), r_store)

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