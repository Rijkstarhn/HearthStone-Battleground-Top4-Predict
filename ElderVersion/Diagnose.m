% Use CVdata as CV set and zhanqi as train set. Try to see the Jcv and
% Jtrain to judge whether it is a high bias model or it is a high variance
% model.

clear;clc;

%Read file and process cvdata%
cvdata = xlsread('CVdata.xlsx','Sheet1');
Xval = cvdata(:,1:8);
yval = cvdata(:,10);

%Read file and process data%
data = xlsread('zhanqi.xlsx','Data');
X = data(:,1:8);
y = data(:,10);

% m = Number of examples
m = size(X, 1);

%lambda and num_rank should be identical to the lambda and num_rank in HBP.m
lambda = 1;
num_rank = 8;
X = [ones(m,1) X];
Xval = [ones(size(Xval,1),1) Xval];

m = 20;
%Calculate the Jcv and Jtrain
for i = 1:m
    
    theta = trainTheta(X(1:i,:), y(1:i), lambda, num_rank);
    error_train(i) = errorCalculate(X(1:i,:), y(1:i), theta, num_rank);
    error_val(i) = errorCalculate(Xval, yval, theta, num_rank);
    
   
end

figure
plot(1:m, error_train, 1:m, error_val);
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')