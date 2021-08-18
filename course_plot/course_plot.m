distance = load("datas/2021-08-18delta_distance.txt");
theta = load("datas/2021-08-18delta_theta.txt");

% データが有るところだけ抽出
distance = nonzeros(distance);
theta = theta([1:size(distance)]);

for i = 1:size(distance)
end
x = distance .* sin(theta);
y = distance .* cos(theta);

scatter(x, y)