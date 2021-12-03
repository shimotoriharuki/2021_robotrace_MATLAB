srnum = 7; % シフトレジスタの数。出力信号の周期の設定
helz = 2^srnum - 1; % 周期
len = 100; % 長さ
Adjust = 1;
x = 0:(len-1);

% M系列信号を生成＆表示
msig = maximum_length_sequence(len, srnum);
subplot(3, 1, 1);
x = x * Adjust;
plot(x, msig);
title('1.M系列信号');

% HIGHかLOWを1と-1でmsig.txtに保存
writematrix(msig)
type 'msig.txt'

% M系列信号の自己相関関数を生成＆表示
ac = auto_correlation(0:len, msig);
subplot(3, 1, 2);
plot(x(1:length(ac)), ac);
title('2.自己相関関数');

% パワースペクトルを表示
subplot(3, 1, 3);
[f, power] = disp_power_spectrum(msig);
plot(f, power);
title('3.パワースペクトル');