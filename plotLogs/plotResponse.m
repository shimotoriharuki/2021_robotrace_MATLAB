response = load('workingDirectory/velocity_response.txt');
response = nonzeros(response); %m/s

plot(1:length(response), response);

