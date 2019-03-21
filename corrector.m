function U=corrector(U,F,G,n,dt2)

for j=1:n,
    for k=1:n,
        for l=1:3,
            fluxes = F(j+1,k,l)-F(j,k,l)+G(j,k+1,l)-G(j,k,l);
            U(j,k,l)=U(j,k,l)-dt2*(F(j+1,k,l)-F(j,k,l)+G(j,k+1,l)-G(j,k,l));
        end
    end
end