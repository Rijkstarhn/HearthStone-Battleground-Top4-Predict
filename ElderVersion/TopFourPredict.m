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
lambda = 1;
X = [ones(m, 1) X];

for c = 1 : num_rank
    options = optimset('GradObj', 'on', 'MaxIter', 200);
    theta_mid =fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), ...
               theta_init, options);
    all_theta(c,:) = theta_mid';      
end

% % Prediction
% pred = predictOneVsAll(all_theta, X);
% fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
% predFour = pred <= 4;
% topFour = y <= 4;
% fprintf('\nTop 4 Accuracy: %f\n', mean(double(predFour == topFour)) * 100);

% Prediction CV
cvdata = xlsread('CVdata.xlsx','Sheet1');
Xval = cvdata(:,1:8);
yval = cvdata(:,10);
Xval = [ones(size(Xval,1),1) Xval];
pred = predictOneVsAll(all_theta, Xval);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == yval)) * 100);
predFour = pred < 4;% Whether top4 or not

topFour = cvdata(:,9);
fprintf('\nTop 4 Accuracy: %f\n', mean(double(predFour == topFour)) * 100);



