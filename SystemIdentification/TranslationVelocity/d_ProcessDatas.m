for_sysident_msig = 0;
len = length(msig);
stretch =20;

for i = 1 : len
    Temp = repmat(msig(1, i), 1, stretch);
    for_sysident_msig = [for_sysident_msig Temp];
end
for_sysident_msig(: ,1) = [];

for_sysident_logs = logs';

x = 1:length(for_sysident_logs);
subplot(2, 1, 1)
plot(x, for_sysident_msig)
subplot(2, 1, 2)
plot(x, for_sysident_logs)
