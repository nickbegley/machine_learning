% percepteron_algorithm
clear all
close all

screen_size = get(0, 'ScreenSize');

x1 = -1:0.1:1 ;% to draw line

% generate two random points on -1 to 1 interval
a = -1;
b = 1;
f = a + (b-a).*rand(2,2);
% create a line based on two random points
x2 = (f(2,2)-f(1,2))/(f(2,1) - f(1,1)) * (x1 - f(1,1));
line(x1,x2)
axis([-1 1 -1 1])   % min and max values
f1 = figure(1);
set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );
hold on

N = 100;             % number of data samples
a = -1;
b = 1;
n = 1:N;                 % number of points
x = a + (b-a).*rand(N,2);  % generate random points

% plug point into target function to calculate output value
e = (f(2,2)-f(1,2))/(f(2,1) - f(1,1)) * (x(:,1) - f(1,1));

y = zeros(N,1);            % initialize output values
for i=1:N                  % this loop calcultates output values
   if e(i) > x(i,2)
       y(i,1) = -1;
   else
       y(i,1) = 1;
   end
end

scatter(x(:,1),x(:,2),30,y, 'filled')   % plot x values, colored according
                                        % to y values
x = [ones(N,1), x];         % add x1 value and set it to one
[r c] = size(x);            
w = zeros(1,3);             % initialize w values
hold on

p = [n' x y];               % keep track of x values and corresponding y

i = 1;

while r > 0                % main loop
    x_fail = [];            % initialize x_fail index
%     [r c] = size(x);            

    h = sign(w*x');         % calculate hypothesis    

    % check hypotheses against output values
    for j = 1:N
        if h(j) ~= y(j)
           x_fail = [x_fail; p(j,2:5)];     % generate x_fail matrix
                                            % for each run through
        end
    end

    [r c] = size(x_fail);                   % check number of failures
    if r == 0
        break                         % if zero failures, you're done!
    end
    
    ran_dex = randi(r,1);               % pick a random element of failures
    y_fail = x_fail(ran_dex,4); % y should be the 4th element
    
    % calculate new weights
    w = w + y_fail*x_fail(ran_dex,1:3);
    
    b2 = -1:0.1:1 ;% to draw line based on new hypothesis
    if w(3) == 0
        b2 = -1:0.1:1 ;% to draw line based on new hypothesis
        b1 = (-w(1)/w(2))*b2;
    else
        b1 = -1:0.1:1 ;% to draw line based on new hypothesis
        b2 = -w(2)/w(3)*b1-w(1)/w(3);
    end

    h2 = line(b1,b2,'Color',[0 0 0]);
    plot(h2)
   
    pause(0.001)
    delete(h2)
    i = i +1;       % increment loop counter
end
line(b1,b2,'Color',[0 0 0])
disp(['The number of iterations is: ' num2str(i)])
% disp('The target values and the hypothesis values:')
% [y h']


