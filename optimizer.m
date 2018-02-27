function  surplus = optimizer(t)  
%x - set point
%sdt - shutdown time integer value to say which time the generator should
%shut down
%sd - shutdown time period min
%forcast - forcasted power predictions
%ti - time interval between time points
%ru - ramp up limit
%rd - ramp down limit
%sdr - start up rate
%sdr - shut down rate
%t(1) = 200;
sdt = 0;
sd = 120;
ti = 10;
ru = 100;
rd = 100;
sur = 100;
sdr = 100;
forcast = load('forcast.mat');
forcast = forcast.forcast(1:75)./50;
t = abs(t);
t(:,2) = 1;

%if(sdt + sd/ti > length(t))
%    sdt = length(t) + 4
%end

%t(sdt:sdt+sd/ti,2) = 0
surplus = 1;
for(i=1:length(t)-1)
   
    ramp = (t(i+1,1)-t(i,1));
    
     if(ramp > 0 & ramp > ru & t(i+1,2) == 1)
         t(i+1,1) = ru+t(i,1);
         %surplus = surplus-100;
      elseif(ramp < 0 & abs(ramp) > rd & t(i+1,2) == 1)
          t(i+1,1) = -rd+t(i,1);
%      elseif(ramp < 0 & ramp < sur & t(i+1,2) == 0)
%          t(i+1,1) = sur*ti+t(i,1);
%      elseif(ramp < 0 & abs(ramp) > sur & t(i+1,2) == 0)
%          t(i+1,1) = -sdr*ti+t(i,1);
     end
end
    surplus = abs(trapz(t(:,1)) - trapz(forcast))+surplus
       
    plot(1:10:750,forcast)
    hold on
    plot(1:10:750,t)
end
    




