%tasep parallel site
%d= no. of samples
%j2=the midway length(l) accross which flux is being calculated
%noc= no. of vehicles varying from 0 to l

d=200;
length=100;
totaltime=500;
j2=floor(length/2);
flux=zeros(1,length); %flux as functn of no. of cars
avgflux=zeros(1,length);

for mmm=1:d
    for noc=1:length %noc=number of cars
        k=1;road=zeros(1,length); %initialization of the road with noc cars
        while k<noc+1
            intp=floor(rand()*length)+1;%initial position
            if road(1,intp)==0;
                road(1,intp)=1;
                k=k+1;
            end
        end
        
        for t=1:totaltime %time loop
            tmp=zeros(1,length); %parallel data storage temp.
            for j=1:length
                row=j;
                if row~=length %special case of position of car at l due to linear structure of array
                    if road(1,row+1)==0
                        tmp(1,row+1)=road(1,row);
                        if row==j2 && road(row)==1
                            flux(1,noc)=flux(1,noc)+1; % flux updation
                        end
                    end
                elseif road(1,1)==0
                    tmp(1,1)=road(1,length); % final implementation of temporary allocatn
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
title('Parallel Site Model')
xlabel('No. of Cars')
ylabel('Flux')