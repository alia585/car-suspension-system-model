VH=(60*1609.3)/3600; B=1140; K1=10800; K2=20900; M=350; %define the constant variables

options=odeset('MaxStep',0.1); %set 0.1 as the maximum step the ODE solver can work under
[T, X]=ode23s(@(t,x)funcp4(t,x,VH,B,K1,K2),[0 20], [0, 0, 0, 0], options); % integrates funcp4 using starting conditions 0 and outputs the results to T and X

y=X(:,1); z=X(:,2); vy=X(:,3); vz=X(:,4);
t=linspace(0, 20, length(y)); % define the time span as 0s-20s with number of elements equal to the length of y z vy vz vectors

for k=1:4 % illustrating the for loop method of plotting graphs
    subplot(2,2,k); % create 2x2 figure containing 4 subplots
    if k==1 % if statement to insert the corresponding plot into the respective subplot
        plot(t,y);
        title('Displacement (y) of the quarter car over time (t)', 'FontSize', 20);
        ylabel('Displacement / m', 'FontSize', 18);
    elseif k==2
        plot(t,z);
        title('Displacement (z) of the unsprung tire over time (t)', 'FontSize', 20);
    elseif k==3
        plot(t,vy, 'r');
        title('Velocity (vy) of the quarter car over time (t)', 'FontSize', 20);
        ylabel('Velocity / m/s', 'FontSize', 18);
        xlabel('Time / s', 'FontSize', 18);
    elseif k==4
        plot(t,vz, 'r');
        title('Velocity (vz) of the unsprung tire over time (t)', 'FontSize', 20);
        xlabel('Time / s', 'FontSize', 18);
    end
end

ay =  (K2/M)*(z-y)+(B/M)*(vz-vy); % creates anonymous function and returns the function handle ay

figure(2) % create second figure
subplot(2,1,1);
plot(T, y);
title('Variation of displacement (y) with time', 'FontSize', 20);
ylabel('Displacement / m', 'FontSize', 18);
indexmax=find(max(y)== y);
Tmax=T(indexmax); % assign the maximum T value to Tmax
ymax=y(indexmax); % assign the maximum y value to ymax
strmax=['Maximum=', num2str(ymax)]; % create the text to be displayed on the plot
text(Tmax, ymax, strmax, 'HorizontalAlignment', 'right'); % display the generated text along with the options for positioning

subplot(2,1,2);
plot(T, ay);
title('Variation of acceleration (ay) with time', 'FontSize', 20);
ylabel('Acceleration / m/s^2', 'FontSize', 18);
xlabel('Time / s', 'FontSize', 18);

a=ay.^2;

arms=sqrt((1/20)*trapz(T, a));
