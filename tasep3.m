% random seq particle
%d= no. of samples
%j2=the midway length(l) accross which flux is being calculated
%noc= no. of vehicles varying from 0 to l

d=200;
length=100;
totaltime=500;
j2=floor(length/2);
a=zeros(1,length);
aavg=zeros(1,length);
%noc=number of cars

for mmm=1:d
    for noc=1:length
        k=1;road=zeros(1,length);
        while k<noc+1
            intp=floor(rand()*length)+1;%initial position
            if road(1,intp)==0;
                road(1,intp)=1;
                k=k+1;
            end
        end
       
        for t=1:totaltime
            rowm=find(road);
            for j=1:noc
                msize = numel(rowm);
                row=rowm(randperm(msize, 1));%selection of a car randomly
                
                if row~=length
                    if road(1,row+1)==0
                        road(1,row+1)=road(1,row);
                        road(1,row)=0;
                        if row==j2
                            a(1,noc)=a(1,noc)+1;
                        end
                    end
                elseif road(1,1)==0
                    road(1,1)=road(1,length);
                    road(1,length)=0;
                end
            end
        end
        
    end
    aavg=aavg+a;
end

aavg=aavg/d;
figure
plot(aavg)
title('Random Seq. Particle Model')
xlabel('No. of Cars')
ylabel('Flux')