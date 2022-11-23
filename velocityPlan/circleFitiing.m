clf
clear
clc

% distance = load("japan/COURSLOG/DISTANCE.txt");
% theta = load("japan/COURSLOG/THETA.txt");
distances = load("workingDirectory/first_run_distances.txt");
thetas= load("workingDirectory/first_run_thetas.txt");

% データが有るところだけ抽出
distances = nonzeros(distances); %mm
thetas = thetas(1:size(distances)); %rad

% x, yに変換
 x = 0;
y = 0;
th = 0;
total_distance = 0;

robot_positions = [zeros(size(distances)), zeros(size(distances))];
sensor_positions = [zeros(size(distances)), zeros(size(distances))];

pivot_lenght = 110; %mm

% コース情報をプロット
for i = 1:size(distances)
    % 位置を計算
    x = x + (distances(i)) * cos(th + thetas(i)/2);
    y = y + (distances(i)) * sin(th + thetas(i)/2);

    th = th + thetas(i);
    robot_positions(i, :) = [x, y];
    sensor_positions(i, :) = [x + pivot_lenght * cos(th), y + pivot_lenght * sin(th)];

end

figure(1)
hold on
scatter(robot_positions(:, 1), robot_positions(:, 2), 5, 'b') % 生データ
scatter(sensor_positions(:, 1), sensor_positions(:, 2), 10, 'r') % 補正後データ
title('1走目')
% axis equal
xlim([-3000 5000])
ylim([-3500 1000])
% hold off

% 円近似1
range1 = 10;
r_store1 = [];
for i = 1 : size(distances) - range1
    [cxe, cye, re] = CircleFitting(sensor_positions(i : i + range1, 1), sensor_positions(i : i + range1, 2));
    
    if re >= 5000
        re = 5000;
    end
    r_store1 = [r_store1, re];
    if rem(i, 5) == 0
        circle_thetas=[0:0.1:2*pi 0];
        xe = re * cos(circle_thetas) + cxe;
        ye = re * sin(circle_thetas) + cye;

%         p = plot(xe,ye,'-b');hold on;
%         drawnow;
%         hold on;   
%         delete(p)
    end
    
end 

% 今までの方法
radius = abs(distances ./ thetas);
radius(radius >= 5000) = 5000;

% d_theta/d_distance
slope = thetas ./ distances;

%shift
r_store1 = circshift(r_store1, range1); % range1だけずれて計算してるからもとに戻す

figure(2)
hold on
plot(1 : length(r_store1), r_store1, 'blue', 'LineWidth', 1)
plot(1 : length(radius), radius, 'black', 'LineWidth', 1)
legend('Circle Fitting range: 10', 'Original way')
hold off

% ↓ Reference：https://myenigma.hatenablog.com/entry/2015/09/07/214600
function [cx, cy, r] = CircleFitting(x, y)
    sumx = sum(x);
    sumy = sum(y);
    sumx2 = sum(x.^2);
    sumy2 = sum(y.^2);
    sumxy = sum(x.*y);
    
    F = [sumx2 sumxy sumx;
       sumxy sumy2 sumy;
       sumx  sumy  length(x)];
    
    G=[-sum(x.^3 + x.*y.^2);
       -sum(x.^2.*y + y.^3);
       -sum(x.^2 + y.^2)];
    
    if rcond(F) < 4.0e-15
        r = 5000;
        cx = 0;
        cy = 0;
    else
        T = F\G;
        cx = T(1) / -2;
        cy = T(2) / -2;
        r = sqrt(cx^2 + cy^2 - T(3));
    end
end