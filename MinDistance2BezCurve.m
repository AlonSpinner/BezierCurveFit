function [minD,u_minD] = MinDistance2BezCurve(CP,q)
%-----prep
persistent B u uvec
if isempty(B)
    u = sym('u');
    order = size(CP,1) - 1; %assume B is squared
    uvec = sym(zeros(1,order+1));
    for ii=1:order+1
        uvec(ii) = u^(ii-1);
    end
    B=calcBezMatrix(order);
end
%-----prep
bezPoly = uvec*B*CP;

N = size(q,1); %amount of points
[minDsq,u_minD] = deal(zeros(N,1));
for ii = 1:N
qii = q(ii,:);
Dsq = sum((bezPoly - qii).^2);
dDsq = diff(Dsq,u);
uhypo = roots(sym2poly(dDsq));
uhypo = uhypo(imag(uhypo) == 0 & uhypo >= 0 & uhypo <= 1);
uhypo = [uhypo;0;1]; %add end points for global minimima
[minDsq(ii),ind] = min(double(subs(Dsq,uhypo)));
u_minD(ii) = uhypo(ind); %projection point
end

minD = sqrt(minDsq);
