function B=calcBezMatrix(order,symbolic)
%{
Note: heavily relies on symbolic toolbox if not classic cases


Input:
order - bezier order

note: bernsteinMatrix is in fact the following:
n=BezO;
for k=0:n
   b(k+1)= nchoosek(n,k)*t^k*(1-t)^(n-k);
end
%}

if nargin<2
    symbolic = false;
end

if symbolic
    B = calcBsymbolic(order);
    return
end

%numeric for simple classic cases
switch order
    case 1
        B = [-1 0;
            -1 1];
    case 2
        B = [1 0 0;
            -2 2 0;
            1 -2 1];
    case 3
        B = [1 0 0 0;
            -3 3 0 0;
            3 -6 3 0;
            -1 3 -3 1];
    case 4
        B = [1 0 0 0 0;
            -4 4 0 0 0;
            6 -12 6 0 0
            -4 12 -12 4 0;
            1 -4 6 -4 1];
    otherwise
        B = calcBsymbolic(order);
end
end

function B = calcBsymbolic(order)
syms t
B=zeros(order+1,order+1);
b=fliplr(bernsteinMatrix(order,t));
for j=1:length(b)
    B(j,:)=coeffs(b(j),t,'all');
end
end