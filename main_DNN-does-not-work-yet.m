%% Constants
order = 4;
k = 100;
Anoise = 0.01;
N=100;
u=linspace(0,1,N); %assume points should be evenly spaced on curve
U = deal(zeros(N,order+1));
for ii=1:N
    for jj=1:(order+1)
        U(ii,jj) = u(ii)^(jj-1);
    end
end
B=calcBezMatrix(order);
%% Create trainning data
[XTrain,YTrain] = deal(cell(k,1));
for ii=1:k
CP = rand(order+1,2);
normalizedCP = (CP - min(CP))./(max(CP)-min(CP));
YTrain(ii,:) = reshape(normalizedCP,[1,2*(order+1)]);
xii = EvalBezCrv_DeCasteljau(u,CP) + Anoise*randn(N,2);
XTrain(ii) = xii(randperm(N),:);
end
%% Create model
layers = [
    imageInputLayer([N,2],'Name','Input');
    convolution2dLayer(2,8,'Padding','same')
    reluLayer('Name','relu1')
    convolution2dLayer(2,16,'Padding','same')
    reluLayer('Name','relu2')
    convolution2dLayer(2,32,'Padding','same')
    reluLayer('Name','relu3')
    dropoutLayer(0.2)
    fullyConnectedLayer(2*(order+1))
%     functionLayer(@(X) reshape(X,[order+1,2]));
%     functionLayer(@(X) U*B*reshape(X,[order+1,2]));
    regressionLayer];
%%
options = trainingOptions("adam",MaxEpochs=10);
net = trainNetwork(XTrain,YTrain,layers,options);

