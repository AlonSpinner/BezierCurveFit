%% clear persistent values
clear BezFit MinDistance2BezCurve 
%% Fit bezier curve
order=4;
CP = [   
    0.9427    0.0000
    1.6238    1.5708
   -4.8246    3.1416
    1.3692    4.7124
    1.0444    6.2832
    ];

%% point
q = [1,2];
[d, s] = MinDistance2BezCurve(CP,q);
qproj = EvalBezCrv_DeCasteljau(s,CP);

%% Estimate 
N=1000;
u=linspace(0,1,N); %assume points should be evenly spaced on curve
est = EvalBezCrv_DeCasteljau(u,CP);
%% draw
Fig=figure('color',[0,0,0]);
Ax=axes(Fig,'color',[0,0,0],'XColor',[1,1,1],'YColor',[1,1,1]);
xlabel(Ax,'x'); ylabel(Ax,'y'); zlabel(Ax,'z');
axis(Ax,'equal'); grid(Ax,'on'); hold(Ax,'on');

scatter(Ax,q(1),q(2),100,'filled');
scatter(Ax,qproj(1),qproj(2),100,'filled');
plot(Ax,est(:,1),est(:,2),'linewidth',2)
plot(Ax,CP(:,1),CP(:,2),'linewidth',1,'linestyle','--','marker','sq')