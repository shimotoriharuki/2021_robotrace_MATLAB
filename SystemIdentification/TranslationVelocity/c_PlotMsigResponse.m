% M系列信号の応答をプロット
logs_origin = importdata("log/response.txt");
inputs_origin = importdata("log/input.txt");
number_of_data = 8500;

logs = logs_origin(1:number_of_data);
inputs = inputs_origin(1:number_of_data);
x = 0:number_of_data-1;

subplot(2, 1, 1)
plot(x, logs);
title('Msig response');

subplot(2, 1, 2)
plot(x, inputs);
title('Input');