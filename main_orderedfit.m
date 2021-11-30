%% clear persistent values
clear BezFit MinDistance2BezCurve 
%% Raw data
N=100;
x=linspace(0,2*pi,N)'; %col
y=cos(x)-5+0.2*randn(N,1); %col
xy = [y,x]; %flip it to show we dont estiamte functions, but curves

%% Fit bezier curve
order=4;
CP = BezFit(xy,order);
%% Estimate 
N=1000;
u=linspace(0,1,N); %assume points should be evenly spaced on curve
est = EvalBezCrv_DeCasteljau(u,CP);
%% draw
Fig=figure('color',[0,0,0]);
Ax=axes(Fig,'color',[0,0,0],'XColor',[1,1,1],'YColor',[1,1,1]);
xlabel(Ax,'x'); ylabel(Ax,'y'); zlabel(Ax,'z');
axis(Ax,'equal'); grid(Ax,'on'); hold(Ax,'on');

scatter(Ax,xy(:,1),xy(:,2),5,'filled');
plot(Ax,CP(:,1),CP(:,2),'linewidth',1,'linestyle','--');
plot(Ax,est(:,1),est(:,2),'linewidth',2)
h=legend(Ax,'data','control points',...
    'estimation','TextColor',[1,1,1],'location','best');