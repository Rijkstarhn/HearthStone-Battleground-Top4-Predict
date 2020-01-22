function [J, grad] = lrCostFunction(theta, X, y, lambda)

    m = length(y);
    J = 0;
    grad = zeros(size(theta));
    
    z = X * theta;
    thetaj = theta.^2;
    J = 1/m * sum(-y .* log(sigmoid(z)) - (1-y) .* log(1 - sigmoid(z))) + 0.5 * lambda / m * sum(thetaj(2:length(thetaj),:));
    grad_0 = 1/m * ((X(:,1))' * (sigmoid(z) - y));
    grad_rest = 1/m * (X(:,2:size(X,2))' * (sigmoid(z) - y)) + lambda / m * theta(2:size(theta,1),:);
    grad = [grad_0;grad_rest];
    
    
    
end