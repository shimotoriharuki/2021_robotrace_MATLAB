% 右側のフォトトランジスタ
init_pos = [0; 50];
for th = deg2rad([9.75, 19.5, 29.25, 39, 48.75, 58.5])
    pthoto_pos_r = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end

% 左側のフォトトランジスタ
init_pos = [0; 50];
for th = deg2rad([-9.75, -19.5, -29.25, -39, -48.75, -58.5])
    photo_pos_l = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end

% 右側のLED
init_pos = [0; 50];
for th = deg2rad([4.875, 14.625, 24.375, 34.125, 43.875, 53.625])
    led_pos_r = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end

% 左側のLED
init_pos = [0; 50];
for th = deg2rad([-4.875, -14.625, -24.375, -34.125, -43.875, -53.625])
    led_pos_l = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end

% 右側のLED
init_pos = [0; 50-2.5];
for th = deg2rad([4.875, 14.625, 24.375, 34.125, 43.875, 53.625])
    reg_pos_r = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end

% 左側の抵抗
init_pos = [0; 50-2.5];
for th = deg2rad([-4.875, -14.625, -24.375, -34.125, -43.875, -53.625])
    reg_pos_l = [cos(th+pi), -sin(th+pi); sin(th+pi), cos(th+pi)] * init_pos + [150; 121.67]
end