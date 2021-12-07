distance = load("datas/DISTANCE.txt");
theta = load("datas/THETA.txt");

% データが有るところだけ抽出
distance = nonzeros(distance);
theta = theta(1:size(distance));

theta_adj = theta .* 1;

x = 0;
y = 0;
th = 0;

X = [];
Y = [];
for i = 1:size(distance)
    
    x = x + distance(i) * cos(th + theta_adj(i)/2);
    y = y + distance(i) * sin(th + theta_adj(i)/2);
    th = th + theta_adj(i);
    X = [X x];
    Y = [Y y];
end


scatter(X, Y)
axis equal