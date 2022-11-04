f1 = figure(1);
% f2 = figure(2);
clf (f1, "reset")
% clf (f2, "reset")
clc
clear

% ---データをロード---
first_run_distances = load('workingDirectory/first_run_distances.txt');
first_run_thetas = load('workingDirectory/first_run_thetas.txt');
first_run_sideline_distances = load('workingDirectory/first_run_sideline_distances.txt');
first_run_crossline_distances = load('workingDirectory/first_run_crossline_distances.txt');

second_run_distances = load('workingDirectory/second_run_distances.txt');
second_run_thetas = load('workingDirectory/second_run_thetas.txt');
second_run_sideline_distances = load('workingDirectory/second_run_sideline_distances.txt');
second_run_crossline_distances = load('workingDirectory/second_run_crossline_distances.txt');

% --- データが有るところだけ抽出---
first_run_distances = nonzeros(first_run_distances); %mm
first_run_thetas = first_run_thetas(1 : size(first_run_distances)); %rad
first_run_sideline_distances = nonzeros(first_run_sideline_distances); %mm
first_run_crossline_distances = nonzeros(first_run_crossline_distances); %mm
% first_run_thetas = first_run_thetas * 0.96;

second_run_distances = nonzeros(second_run_distances); %mm
second_run_thetas = second_run_thetas(1 : size(second_run_distances)); %rad
second_run_sideline_distances = nonzeros(second_run_sideline_distances); %mm
second_run_crossline_distances = nonzeros(second_run_crossline_distances); %mm
% second_run_thetas = second_run_thetas * 0.96;


% ---コースの形状をプロット---
subplot(2, 1, 1);
figure(1);
plotCourseInformation(first_run_distances, first_run_thetas, first_run_sideline_distances, first_run_crossline_distances);
title('1走目')

subplot(2, 1, 2);
plotCourseInformation(second_run_distances, second_run_thetas, second_run_sideline_distances, second_run_crossline_distances);
title('2走目')

% axis equal

figure(2);
subplot();
plotRadius(first_run_distances, first_run_thetas);


function plotCourseInformation(distances, thetas, sidelines, crosslines)
    x = 0;
    y = 0;
    th = 0;
    total_distance = 0;

    positions = [zeros(size(distances)), zeros(size(distances))];
    sideline_positions = [zeros(size(sidelines)), zeros(size(sidelines))];
    crossline_positions = [zeros(size(crosslines)), zeros(size(crosslines))];
    sideline_idx = 1;
    crossline_idx = 1;

    % コース情報をプロット
    for i = 1:size(distances)
        % 位置を計算
        x = x + (distances(i)) * cos(th + thetas(i)/2);
        y = y + (distances(i)) * sin(th + thetas(i)/2);
    
        th = th + thetas(i);
        positions(i, :) = [x, y];

        % サイドラインの位置を計算
        if total_distance + 10 >= sidelines(sideline_idx) && sidelines(sideline_idx) >= total_distance - 10
            y_sideline = y + 100 * cos(th);
            sideline_positions(sideline_idx, :) = [x, y_sideline];
            sideline_idx = sideline_idx + 1;

            if sideline_idx > length(sidelines(:, 1))
                sideline_idx = length(sidelines(:, 1));
            end
        end

        % クロスラインの位置を計算
        if total_distance + 10 >= crosslines(crossline_idx) && crosslines(crossline_idx) >= total_distance - 10
            
            crossline_positions(crossline_idx, :) = [x, y];
            crossline_idx = crossline_idx + 1;

            if crossline_idx > length(crosslines(:, 1))
                crossline_idx = length(crosslines(:, 1));
            end
        end

        total_distance = total_distance + distances(i);
    
    end
    hold on
    scatter(positions(:, 1), positions(:, 2)); % コースをプロット

    crossline_nums = 1 : length(crossline_positions(:, 1));
    scatter(crossline_positions(: ,1), crossline_positions(:, 2), 300, "red", "x", "LineWidth", 2); % クロスラインをプロット
    text(crossline_positions(: ,1) + 50, crossline_positions(:, 2) + 50, string(crossline_nums), "Color", 'r');
    
    sideline_nums = 1 : length(sideline_positions(:, 1));
    scatter(sideline_positions(: ,1), sideline_positions(:, 2), 300, "magenta", "*", "LineWidth", 2) % サイドラインをプロット
    text(sideline_positions(: ,1) + 50, sideline_positions(:, 2) + 50, string(sideline_nums), "Color", "m");

    hold off
end

function plotRadius(distances, thetas)
    t = 1 : length(distances);
    radius = abs(distances ./ thetas);
    radius(radius >= 5000) = 5000;
    
    plot(t, radius);
    ylim([0, 5500])

end
 