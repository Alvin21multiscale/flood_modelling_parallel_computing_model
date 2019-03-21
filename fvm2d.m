clear
close all
global grav

grav=9.806;

cellsize=1; %Cell size (m)
n=50; %number of cells across box
L=n*cellsize; %box size (m)

x=cellsize/2:cellsize:L-cellsize/2; %x coordinate of cell center
y=cellsize/2:cellsize:L-cellsize/2; %y coordinate of cell center

nt=200; %number of time steps
ntplot=2; %plotting interval
dt=0.1; %time step (s)
dt2=dt/cellsize;

%Initial condition
t=0; %start time
h=0.1*ones(n,n); %depth
%h(20:30,n-10+1:n)=1; %higher water level in corner
h(2:7,n-4+1:n)=1; %higher water level in corner
u=zeros(n,n);
v=zeros(n,n);
F=zeros(n+1,n,3); %fluxes in the $x$ direction
G=zeros(n,n+1,3); %fluxes in the $y$ direction


U(:,:,1)=h;
U(:,:,2)=u.*h;
U(:,:,3)=v.*h;
tic
for tstep=1:nt,
    %Compute fluxes
    [F, G, amax]=fluxes(U,n);
    U=corrector(U,F,G,n,dt2);
    fprintf('Time Step = %d, Courant Number = %g \n',tstep,amax*dt2*2)
    if (mod(tstep,ntplot) == 0),
        surf(x,y,U(:,:,1)');
        xlabel('x (m)'); 
        ylabel('y (m)'); 
        zlabel('h (m)');
        axis([0 L 0 L 0 1]);
        view(-30,30);
        pause(0.1);
    end
end
toc