srnum = 7; % �V�t�g���W�X�^�̐��B�o�͐M���̎����̐ݒ�
helz = 2^srnum - 1; % ����
len = 100; % ����
Adjust = 1;
x = 0:(len-1);

% M�n��M���𐶐����\��
msig = maximum_length_sequence(len, srnum);
subplot(3, 1, 1);
x = x * Adjust;
plot(x, msig);
title('1.M�n��M��');

% HIGH��LOW��1��-1��msig.txt�ɕۑ�
writematrix(msig)
type 'msig.txt'

% M�n��M���̎��ȑ��֊֐��𐶐����\��
ac = auto_correlation(0:len, msig);
subplot(3, 1, 2);
plot(x(1:length(ac)), ac);
title('2.���ȑ��֊֐�');

% �p���[�X�y�N�g����\��
subplot(3, 1, 3);
[f, power] = disp_power_spectrum(msig);
plot(f, power);
title('3.�p���[�X�y�N�g��');