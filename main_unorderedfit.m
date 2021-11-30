%% clear persistent values
clear BezFit MinDistance2BezCurve 

%% Raw data
N=20;
x=linspace(0,2*pi,N)'; %col
Anoise = 0.2;
y=cos(x)-5+Anoise*randn(N,1); %col
xy = [y,x]; %flip it to show we dont estiamte functions, but curves
%% using Ransac
order=4;
sampleSize = order + 1; %minimum numnber of points to compute model
fitFcn = @(xy) BezFit(xy,order);
distFcn = @MinDistance2BezCurve;
maxDistance = 5*Anoise;
[ransacCP,inlierIdx] = ransac(xy,fitFcn,distFcn,sampleSize,maxDistance,...
    "MaxNumTrials",5*nchoosek(N,sampleSize),"Confidence",80);
fprintf('inlier percentile %g\n',sum(inlierIdx)/N);
%% using fmin
clear MinDistance2BezCurve 
f2minFcn = @(CP) sum(MinDistance2BezCurve(CP,xy).^2);
CP0 = xy(1:order+1,:);
fminCP = fmincon(f2minFcn,CP0);
%% fit of ordered points via LMS, this will be "ground truth"
clear BezFit %sample size is different, so different persistant U
ofitCP = BezFit(xy,order);
%% draw
%evalute curves
N=1000;
u=linspace(0,1,N); %assume points should be evenly spaced on curve
ransacEst = EvalBezCrv_DeCasteljau(u,ransacCP);
fminEst = EvalBezCrv_DeCasteljau(u,fminCP);
ofitEst = EvalBezCrv_DeCasteljau(u,ofitCP);

Fig=figure('color',[0,0,0]);
Ax=axes(Fig,'color',[0,0,0],'XColor',[1,1,1],'YColor',[1,1,1]);
xlabel(Ax,'x'); ylabel(Ax,'y'); zlabel(Ax,'z');
axis(Ax,'equal'); grid(Ax,'on'); hold(Ax,'on');

scatter(Ax,xy(:,1),xy(:,2),5,'filled');
plot(Ax,ofitEst(:,1),ofitEst(:,2),'linewidth',2)
plot(Ax,ransacEst(:,1),ransacEst(:,2),'linewidth',2,'linestyle','--')
plot(Ax,fminEst(:,1),fminEst(:,2),'linewidth',1,'linestyle','--');

h=legend(Ax,'data','control points',...
    'ransac','ordered fit','TextColor',[1,1,1],'location','best');