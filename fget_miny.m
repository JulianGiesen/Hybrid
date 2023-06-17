

% Setting the constants
x = linspace(0, 150, 1000);
consts = fset_consts();

% Define the equations of the lines as functions to use them in FZERO
d1 = @(x) ((2*consts.h)/consts.w)*x;
d2 = @(x) ((consts.h/consts.w)*x) + consts.h;
d3 = @(x) (3*consts.h)+0*x;
d4 = @(x) ((3*consts.h)/(2*consts.w)*x)+(9*consts.h);

% Define the function to find the intersection
f1 = @(x) d1(x) - d2(x);
f2 = @(x) d3(x) - d2(x);

% Find the intersection point
x_intersect1 = round(fzero(f1, [0, 150]),1);
x_intersect2 = round(fzero(f2, [0, 150]),1);

% Calculate the corresponding y-coordinate
y_intersect1 = round(d1(x_intersect1),1);
y_intersect2 = round(d2(x_intersect2),1);

% Display the intersection point
fprintf('Intersection point: (%f, %f)\n', x_intersect1, y_intersect1);
fprintf('Intersection point: (%f, %f)\n', x_intersect2, y_intersect2);

% Get the gradients for the three segments
gradientd1 = gradient(d1(x),x);
gradientd2 = gradient(d2(x),x);
gradientd3 = gradient(d3(x),x);

% Finding the minimum value of each x
min_function = min(min(min(d1(x), d2(x)), d3(x)), d4(x));

% Plotting
figure()
title('Graphing multiple lines on the same plot and showing the y_min function');
xlabel('x');
ylabel('y');
legend('Location', 'best');
legend('show');
hold on;
plot(x, d1(x), 'DisplayName', 'd1');
plot(x, d2(x), 'DisplayName', 'd2');
plot(x, d3(x), 'DisplayName', 'd3');
plot(x, d4(x), 'DisplayName', 'd4');

plot(x_intersect1, y_intersect1, 'ro', 'DisplayName', 'Intersection 1');
plot(x_intersect2, y_intersect2, 'ro', 'DisplayName', 'Intersection 2');
plot(x, min_function, 'DisplayName', 'y_{min}(d1,d2,d3,d4)', 'Color',[0 1 1], LineWidth=2);




