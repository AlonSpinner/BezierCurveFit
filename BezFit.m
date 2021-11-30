function CP = BezFit(xy,order)
%xy - [x,y] size mx2
%order - scalar, order of bezier curve

%-----prep
persistent B U pinv
if isempty(B)
    N = size(xy,1);
    U=deal(zeros(N,order+1));
    q=linspace(0,1,N); %assume points should be evenly spaced on curve
    for i=1:N
        for j=1:(order+1)
            U(i,j)=q(i)^(j-1); %[q^0, q^1, q^2, q^3]
        end
    end
    B = calcBezMatrix(order);
    pinv=@(A) (A'*A)\A'; %psuedo inverse matrix (moore-pensrose)
end
%-----prep

%XY=U*B*CP
CP=zeros(order+1,size(xy,2)); %initalize
for dim=1:size(xy,2) %R2 dimensions (x,y), they are indepednent of each other
    CP(:,dim)=B\pinv(U)*xy(:,dim);
end
end