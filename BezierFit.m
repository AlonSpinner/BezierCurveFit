%% Raw data
N=100;
x=linspace(0,pi,N)'; %col
y=cos(x)-5+0.1*randn(N,1); %col
XY=[x,y];

%% Fit bezier curve of third degree
q=linspace(0,1,N); %assume constant intervals
U=deal(zeros(N,4));
for i=1:N
    for j=1:4
        U(i,j)=q(i)^(j-1); %[q^0, q^1, q^2, q^3]
    end
end
B=[
    1     0     0     0
    -3     3     0     0
    3    -6     3     0
    -1     3    -3     1
    ];
pinv=@(A) inv(A'*A)*A'; %psuedo inverse matrix (moore-pensrose)

%XY=U*B*CP
CP=zeros(4,2); %initalize
for dim=1:2 %R2 dimensions (x,y)
    CP(:,dim)=inv(B)*pinv(U)*XY(:,dim);
end

%% draw
Fig=figure('color',[0,0,0]);
Ax=axes(Fig,'color',[0,0,0],'XColor',[1,1,1],'YColor',[1,1,1]);
xlabel(Ax,'x'); ylabel(Ax,'y'); zlabel(Ax,'z');
axis(Ax,'equal'); grid(Ax,'on'); hold(Ax,'on');

k = 10*N;
[Ex,Ey]=deal(zeros(1,k));
q=linspace(0,1,k); %assume constant intervals
for i=1:k
    Ex(i)=EvalBezCrv_DeCasteljau(CP(:,1),q(i));
    Ey(i)=EvalBezCrv_DeCasteljau(CP(:,2),q(i));
end

scatter(Ax,XY(:,1),XY(:,2),5,'filled');
plot(Ax,CP(:,1),CP(:,2),'linewidth',1,'linestyle','--');
plot(Ax,Ex,Ey,'linewidth',2)
h=legend(Ax,'data','control points','estimation','TextColor',[1,1,1]);

function R=EvalBezCrv_DeCasteljau(Q,q)
%{
Evaluates Bezier Curve by given nodes and parameter
value

Q - nodes in format [x] or [x,y,z] dimension matrix. top row is q=0.
q - running parameter of bezier curve. 0=<q<=1
R - [x] or [x,y,z] format. point on bezier curve
https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/de-casteljau.html
%}

n=size(Q,1)-1; %degree of bezier polynomial
for k=1:(n+1)
    for i=1:(n+1-k) %doesnt enter in first iteration
        Q(i,:)=(1-q)*Q(i,:)+q*Q(i+1,:);
    end
end
R=Q(1,:);
end