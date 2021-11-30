function est = EvalBezCrv_B(u,B,CP)
order = size(B,1)-1;
N = length(u);
U = deal(zeros(N,order+1));
for ii=1:N
    for jj=1:(order+1)
        U(ii,jj) = u(ii)^(jj-1);
    end
end

est = U*B*CP;
end