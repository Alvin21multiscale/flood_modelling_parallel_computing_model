function [F, G, amax]=fluxes(U,n)

%Compute fluxes in x-direction
sn=0; cn=1;
amax=0;
for j=2:n,
    for k=1:n,
        hl=U(j-1,k,1);
        hr=U(j,k,1);
        ul=U(j-1,k,2)/hl;
        ur=U(j,k,2)/hr;
        vl=U(j-1,k,3)/hl;
        vr=U(j,k,3)/hr;
        [F(j,k,:), a]=solver(hl,hr,ul,ur,vl,vr,sn,cn);
        amax=max([a amax]);
    end
end
%Enforce wall boundary on left side of box (west)
for k=1:n,
    hr=U(1,k,1);
    ur=U(1,k,2)/hr;
    vr=U(1,k,3)/hr;
    [F(1,k,:), a]=solver(hr,hr,-ur,ur,vr,vr,sn,cn);
    amax=max([a amax]);
end
%Enforce wall boundary on right side of box (east)
for k=1:n,
    hl=U(n,k,1);
    ul=U(n,k,2)/hl;
    vl=U(n,k,3)/hl;
    [F(n+1,k,:), a]=solver(hl,hl,ul,-ul,vl,vl,sn,cn);
    amax=max([a amax]);
end

%Compute fluxes in y-direction
sn=1; cn=0;
for k=2:n,
    for j=1:n,
        hl=U(j,k-1,1);
        hr=U(j,k,1);
        ul=U(j,k-1,2)/hl;
        ur=U(j,k,2)/hr;
        vl=U(j,k-1,3)/hl;
        vr=U(j,k,3)/hr;
        [G(j,k,:), a]=solver(hl,hr,ul,ur,vl,vr,sn,cn);
        amax=max([a amax]);
    end
end
%Enforce wall boundary on bottom of box (south)
for j=1:n,
    hr=U(j,1,1);
    ur=U(j,1,2)/hr;
    vr=U(j,1,3)/hr;
    [G(j,1,:), a]=solver(hr,hr,ur,ur,-vr,vr,sn,cn);
    amax=max([a amax]);
end
%Enforce wall boundary on top of box (north)
for j=1:n,
    hl=U(j,n,1);
    ul=U(j,n,2)/hl;
    vl=U(j,n,3)/hl;
    [G(j,n+1,:), a]=solver(hl,hl,ul,ul,vl,-vl,sn,cn);
    amax=max([a amax]);
end

sn=1;