%% clear persistent values
clear BezFit MinDistance2BezCurve 

%% Raw data
N=40;
x=linspace(0,2*pi,N)'; %col
Anoise = 0.2;
noise = Anoise*randn(N,1); %col
y=cos(x);
xy = [y,x];
measxy = [y+noise,x]; %flip it to show we dont estiamte functions, but curves
%% using fmin
clear MinDistance2BezCurve

order = 4;
CP0 = measxy(1,:);
CPn = measxy(end,:);
f2minFcn = @(CP) sum(MinDistance2BezCurve([CP0; CP; CPn],measxy).^2);

x0 = zeros(order-1,2);
for ii=1:order-1
    x0(ii,:) = measxy(round(N/(order+1)*ii),:);
end
x0 = measxy(2:order,:); %orde+1-2 = order-1 points in CPmid
CPmid = fminunc(f2minFcn,x0);
CP = [CP0; CPmid; CPn];
%% Estimate 
N=1000;
u=linspace(0,1,N); %assume points should be evenly spaced on curve
est = EvalBezCrv_DeCasteljau(u,CP);
%% draw
Fig=figure('color',[0,0,0]);
Ax=axes(Fig,'color',[0,0,0],'XColor',[1,1,1],'YColor',[1,1,1]);
xlabel(Ax,'x'); ylabel(Ax,'y'); zlabel(Ax,'z');
axis(Ax,'equal'); grid(Ax,'on'); hold(Ax,'on');

scatter(Ax,measxy(:,1),measxy(:,2),10,'filled');
plot(Ax,xy(:,1),xy(:,2),'linewidth',2)
plot(Ax,est(:,1),est(:,2),'linewidth',2)
plot(Ax,CP(:,1),CP(:,2),'linewidth',1,'linestyle','--','marker','sq')
h=legend(Ax,'data','ground truth',...
    'fit','CP','TextColor',[1,1,1],'location','best');