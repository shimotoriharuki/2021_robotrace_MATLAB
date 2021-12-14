clear

radius = [0, 100, 150, 200, 250, 300, 500, 1000, 2000, 5000]';
velo = [1.3, 1.3, 1.4, 1.5, 1.6, 1.8, 2.0, 2.3, 2.5, 2.8]';
f = fit(radius, velo, 'exp2');
% x2 = 0:0.1:10000;
% y2 = polyval(p,x2);
plot(radius, velo);

hold on
plot(f,radius,velo)
hold off
xlim([0 5000])
ylim([1.0 3.0]);

legend("元データ", "近似曲線")
xlabel("曲率半径[mm]")
ylabel("速度[mm/s]")