clf
clear
motor_distance_origin = load("STATELOG/MOTORDIS.TXT");
pulley_distance_origin = load("STATELOG/PULEYDIS.TXT");

motor_distance2_origin = load("STATELOG/MOTORDI2.TXT");
pulley_distance2_origin = load("STATELOG/PULEYDI2.TXT");

% データが有るところだけ抽出
motor_distance = nonzeros(motor_distance_origin); %mm
pulley_distance = pulley_distance_origin(1:size(motor_distance)); %mm

motor_distance2 = nonzeros(motor_distance2_origin); %mm
pulley_distance2 = pulley_distance2_origin(1:size(motor_distance2)); %mm

t = 0 : length(motor_distance)-1;
t2 = 0 : length(motor_distance2)-1;

subplot(2, 1, 1)
plot(t, motor_distance, t2, motor_distance2)
legend("motor\_distance", "motor\_distance2")
yline(motor_distance(end))
yline(motor_distance2(end))
motor_diff = motor_distance2(end) / motor_distance(end)
text(200, 4000, "比: " + num2str(motor_diff))

subplot(2, 1, 2)
plot(t, pulley_distance, t2, pulley_distance2)
legend("pulley\_distance", "pulley\_distance2")
yline(pulley_distance(end))
yline(pulley_distance2(end))
pulley_diff = pulley_distance2(end) / pulley_distance(end)
text(200, 4000, "比: " + num2str(pulley_diff))

if abs(1 - motor_diff) > abs(1 - pulley_diff)
    disp("コロコロエンコーダのほうが誤差が少ない")
else 
    disp("モータエンコーダのほうが誤差が少ない")
end