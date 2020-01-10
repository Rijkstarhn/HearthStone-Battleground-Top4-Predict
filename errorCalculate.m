function [ error ] = errorCalculate( X, y, theta, num_rank )
%   To calculate the error
error = 0;
m = length(y); % number of training examples
theta = theta';

for c = 1 : num_rank
    
    z = X * theta(:,c);
    error_c = 1/m * sum(-(y == c) .* log(sigmoid(z)) - (1-(y == c)) .* log(1 - sigmoid(z)));
    error = error + error_c;
    
end


end

