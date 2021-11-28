function B=calcBezMatrix(BezO)
%{
Note: heavily relies on symbolic toolbox


Input:
BezO - bezier order

note: bernsteinMatrix is in fact the following:
n=BezO;
for k=0:n
   b(k+1)= nchoosek(n,k)*t^k*(1-t)^(n-k);
end
%}

syms t
B=zeros(BezO+1,BezO+1);
b=fliplr(bernsteinMatrix(BezO,t));
for j=1:length(b)
    B(j,:)=coeffs(b(j),t,'all');
end
end