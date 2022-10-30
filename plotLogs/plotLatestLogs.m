clc
clear
clf

% ---データをロード---
first_run_distances = load('workingDirectory/first_run_distances.txt');
first_run_thetas = load('workingDirectory/first_run_thetas.txt');

% --- データが有るところだけ抽出---
first_run_distances = nonzeros(first_run_distances); %mm
first_run_thetas = first_run_thetas(1 : size(first_run_distances)); %rad

% ---コースの形状をプロット---
x = 0;
y = 0;
th = 0;
X = zeros(size(first_run_distances));
Y = zeros(size(first_run_distances));
for i = 1:size(first_run_distances)
    x = x + (first_run_distances(i)) * cos(th + first_run_thetas(i)/2);
    y = y + (first_run_distances(i)) * sin(th + first_run_thetas(i)/2);

    th = th + first_run_thetas(i);
    X(i) = x;
    Y(i) = y;

end

s = subplot(2, 1, 1)
scatter(X, Y, 10)
title('1走目')
axis equal

function ax = plotCourseShape(distances, thetas)
    x = 0;
    y = 0;
    th = 0;
    X = zeros(size(distances));
    Y = zeros(size(distances));
    for i = 1:size(distances)
        x = x + (distances(i)) * cos(th + thetas(i)/2);
        y = y + (distances(i)) * sin(th + thetas(i)/2);
    
        th = th + thetas(i);
        X(i) = x;
        Y(i) = y;
    
    end
    ax = subplot(2, 1, 1);
end
