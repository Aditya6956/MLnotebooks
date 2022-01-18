x = [-4, -3, -2, -1, 0, 1, 2, 3, 4];
y = [26.1, 19, 14.1, 10.9, 10.1, 11.1, 13.9, 19.1, 25.9];
% our true model would produce: 26, 19, 14, 11, 10, 11, 14, 19, 26
% it is in fact y = x^2 + 10

% looking for a model y = f(x) = a*x^2 + c
% MSE = sum{[y-f(x)]^2}
function result = mse(y, x, a, c)
    result = 0;
    for i=1:size(x, 2)
        result = result + (y(i) - (a * x(i)^2 + c))^2;
    end
    result = result / size(x, 2);
end

% MSE derivative with respect to a: sum{2[y-f(x)]*(-2x)}
function d = a_direction_component(y, x, a, c)
    d = sum(2*(y - a * (x .^ 2) - c) .* (-2 * x .^ 2));
end

% MSE derivative with respect to c: sum{2[y-f(x)]*(-1)}
function d = c_direction_component(y, x, a, c)
    d = sum(2*(y - a * x .^ 2 - c) .* (-1));
end

a = 0;
c = 0;
step = 0.0001;
sprintf("MSE = %d",mse(y, x, a, c))

for i=1:100
    sprintf("Iteration %d", i)
    gradient = [a_direction_component(y, x, a, c), c_direction_component(y, x, a, c)]
    a = a - step * gradient(1);
    c = c - step * gradient(2);
    sprintf("Model learned: y = %f.2 * x^2 + %f.2", a, c)
    current_mse = mse(y, x, a, c)
end
