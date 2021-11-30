function R=EvalBezCrv_DeCasteljau(q,Q)
%{
Evaluates Bezier Curve by given nodes and parameter
value

Q - nodes in format [x,y] dimension matrix. top row is q=0.
q - running parameter of bezier curve. 0=<q<=1
R - [x,y] or [x,y,z] format. point on bezier curve
https://pages.mtu.edu/~shene/COURSES/cs3621/NOTES/spline/Bezier/de-casteljau.html
%}

%currently not used in main
q = q(:);
R = zeros(length(q),size(Q,2));
n=size(Q,1)-1; %degree of bezier polynomial
for ii = 1:length(q)
    qii = q(ii);
    Qii = Q;
    for kk=1:(n+1)
        for jj=1:(n+1-kk) %doesnt enter in first iteration
            Qii(jj,:)=(1-qii)*Qii(jj,:)+qii*Qii(jj+1,:);
        end
    end
    R(ii,:)=Qii(1,:);
end
end