function [ all_theta ] = trainTheta( X, y, lambda, num_rank )
% Use trainTheta to calculate the theta of CVdata and train data

n = size(X,2);
all_theta = zeros(num_rank, n);% X has already been added ones(x0 == 1 for theta0)
theta_init = zeros(n,1);

for c = 1 : num_rank
    options = optimset('GradObj', 'on', 'MaxIter', 50);
    theta_mid =fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), ...
               theta_init, options);
    all_theta(c,:) = theta_mid';      
end

end

