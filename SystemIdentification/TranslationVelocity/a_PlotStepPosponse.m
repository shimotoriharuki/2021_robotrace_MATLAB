clc
clear

% �X�e�b�v�������v���b�g
logs_origin = importdata("log/STEPRES.txt");
number_of_data = 3000;

logs = logs_origin(1:number_of_data);
x = 0:number_of_data-1;

plot(x, logs);

title('step response');

%1000~1500ms���炢�Œ����



