clf
clear
cur_vel = load("datas3/CURVEL.txt");
tar_vel = load("datas3/TARVEL.txt");



% データが有るところだけ抽出
cur_vel = nonzeros(cur_vel);
tar_vel = tar_vel(1:size(cur_vel));

t = 0:length(cur_vel)-1;
plot(t, cur_vel, t, tar_vel)
legend('current', 'target')




