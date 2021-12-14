clf
clear
distance = load("datas3/DISTANCE.txt");
theta = load("datas3/THETA.txt");
vel_table = load("datas3/VELTABLE.TXT");
current_vel = load("datas3/DISTANC2.txt");
theta2 = load("datas3/THETA2.txt");


% データが有るところだけ抽出
distance = nonzeros(distance); %mm
theta = theta(1:size(distance)); %rad

current_vel = nonzeros(current_vel); %mm
theta2 = theta2(1:size(current_vel)); %rad


figure(1)
vel_table = vel_table(1:size(distance));
subplot(2, 1, 1)
t = 0:length(vel_table)-1;
plot(t, vel_table)
ylim([1.2 2.8])

subplot(2, 1, 2)
t = 0:length(current_vel)-1;
plot(t, current_vel)
ylim([1.2 2.8])

