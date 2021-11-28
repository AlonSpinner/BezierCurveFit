function R=EvalBezCrv_DeCasteljau(Q,q)
%{
Evaluates Bezier Curve by given nodes and parameter
value

Q - nodes in format [x,y] dimension matrix. top row is q=0.
q - running parameter of bezier curve. 0=<q<=1
R - [x,y] or [x,y,z] format. point on bezier curve
https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/de-casteljau.html
%}

%currently not used in main

n=size(Q,1)-1; %degree of bezier polynomial
for k=1:(n+1)
    for i=1:(n+1-k) %doesnt enter in first iteration
        Q(i,:)=(1-q)*Q(i,:)+q*Q(i+1,:);
    end
end
R=Q(1,:);
end