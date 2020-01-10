clear;clc;

%Read file and process data%
data = xlsread('zhanqi.xlsx','Data');
X = data(:,1:8);
y = data(:,10);

%% 
%%J and grad%%
m = size(X, 1);
n = size(X,2);
num_rank = 8;


theta_init = zeros(n+1,1);
all_theta = zeros(num_rank, n + 1);
lambda = 0.001;
X = [ones(m, 1) X];

for c = 1 : num_rank
    options = optimset('GradObj', 'on', 'MaxIter', 100);
    theta_mid =fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), ...
               theta_init, options);
    all_theta(c,:) = theta_mid';      
end


% Prediction
cvdata = xlsread('CVdata.xlsx','Sheet1');
Xval = cvdata(:,1:8);
yval = cvdata(:,10);
Xval = [ones(size(Xval,1),1) Xval];
pred = predictOneVsAll(all_theta, Xval);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == yval)) * 100);
pred = pred < 4;% Whether top4 or not

topFour = cvdata(:,9);
fprintf('\nTop 4 Accuracy: %f\n', mean(double(pred == topFour)) * 100);



