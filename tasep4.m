%parallel particle
%d= no. of samples
%j2=the midway length(l) accross which flux is being calculated
%noc= no. of vehicles varying from 0 to l

d=200;
length=100;
totaltime=500;
j2=floor(length/2);
flux=zeros(1,length);

avgflux=zeros(1,length);


for mmm=1:d
    for noc=1:length %noc=number of cars
        k=1;road=zeros(1,length);
        while k<noc+1
            intp=floor(rand()*length)+1;%initial position
            if road(1,intp)==0;
                road(1,intp)=1;
                k=k+1;
            end
        end
        
        for t=1:totaltime
            tmp=zeros(1,length);
            for j=1:length
                if road(1,j)==1
                    if j~=length
                        if road(1,j+1)==0
                            tmp(1,j+1)=road(1,j);
                            if j==j2 && road(j)==1
                                flux(1,noc)=flux(1,noc)+1;
                            end
                        end
                    elseif road(1,1)==0
                        tmp(1,1)=road(1,length);
                    end
                end
            end
            road=tmp;
        end
    end
    avgflux=flux+avgflux;
end
avgflux=avgflux/d;
figure
plot(avgflux)
title('Parallel Particle Model')
xlabel('No. of Cars')
ylabel('Flux')