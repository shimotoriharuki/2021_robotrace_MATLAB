bclf
clear
cur_vel = load("STATELOG/CURVEL.txt");
tar_vel = load("STATELOG/TARVEL.txt");


% データが有るところだけ抽出
tar_vel = nonzeros(tar_vel);
cur_vel = cur_vel(1:size(tar_vel));

t = 0:length(tar_vel)-1;
plot(t, cur_vel, t, tar_vel)
legend('current', 'target')




