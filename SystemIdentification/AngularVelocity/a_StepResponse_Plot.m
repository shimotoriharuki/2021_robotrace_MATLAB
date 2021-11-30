clear
clc

% ステップ応答をプロット
logs_origin = importdata("log/ROTSTEP.txt");
number_of_data = 5000;

logs = logs_origin(1:number_of_data);
x = 0:number_of_data-1;

plot(x, logs);

title('step response');




