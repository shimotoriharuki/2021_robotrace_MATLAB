clf
clear
motorL = load("motorInputs/LPERIOD.txt");
motorR = load("motorInputs/RPERIOD.txt");

motorL = nonzeros(motorL);
motorR = motorR(1:size(motorL)); 

t = 0 : length(motorL) - 1;

plot(t, motorL, t, motorR)
