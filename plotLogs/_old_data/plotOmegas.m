clf
clear
current_omega = load("omegas/COMEGA.TXT");
target_omega = load("omegas/TOMEGA.TXT");

% データが有るところだけ抽出
% current_omega = nonzeros(current_omega); %rad/s
% target_omega = target_omega(1:size(current_omega)); %rad/s

t = 0 : length(current_omega)-1;

plot(t, current_omega, t, target_omega);
legend('current', 'target')