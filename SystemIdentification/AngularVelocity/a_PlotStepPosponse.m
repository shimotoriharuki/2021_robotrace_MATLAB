clc
clear

% ステップ応答をプロット
logs_origin = importdata("log/STEPRES.txt");
number_of_data = 1000;

logs = logs_origin(1:number_of_data);
x = 0:number_of_data-1;

plot(x, logs);

title('step response');

%500~600msくらいで定常状態



