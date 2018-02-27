function [ trainingCell ] = formatData()
%Formats a single table containing all the information for training the
%neural network
%IMPORTANT: INDEX NUMBERS ARE TAILORED FOR EACH SPECIFIC DATA SET TO
%IMPROVE PERFORMANCE.
%Use the following function: datetime.setDefaultFormats('default','yyyy-MM-dd''T''HH:mm:ss')

timeTAvgCellHistorical = table2cell(getHistoricalWeather('2017-01-01', '2018-01-30', 'TAVG'));
timePrcpCellHistorical = table2cell(getHistoricalWeather('2017-01-01', '2018-01-30', 'PRCP'));
timePrcpCellHistorical(:,1)=[];

[powerGen, time] = xlsread("Therm Gen MW", 'Sheet1', 'B1:C49468');
time(1,:)=[];
time=datetime(time(:,1));

trainingCell=table2cell(table(time,powerGen));
trainingCell{length(time),4} = [];
for i=1:length(time)
    
    
    [powerGenYear, powerGenMonth, powerGenDay ]=ymd(time(i));
    powerGenDate = [powerGenYear, powerGenMonth, powerGenDay ];
    
    if powerGenYear == 2017
        if powerGenMonth <=3
            for j=52:90
                [compareYear, compareMonth, compareDay ] =ymd(datetime(timeTAvgCellHistorical(j,1)));
                compareDate = [compareYear, compareMonth, compareDay ];
                
                if compareDate==powerGenDate
                    trainingCell{i,3}=timeTAvgCellHistorical{j,2};
                    trainingCell{i,4}=timePrcpCellHistorical{j,1};
                end
            end
        end
        if powerGenMonth >3 && powerGenMonth <=6
            for j=91:181
                [compareYear, compareMonth, compareDay ] =ymd(datetime(timeTAvgCellHistorical(j,1)));
                compareDate = [compareYear, compareMonth, compareDay ];
                
                if compareDate==powerGenDate
                    trainingCell{i,3}=timeTAvgCellHistorical{j,2};
                    trainingCell{i,4}=timePrcpCellHistorical{j,1};
                end
            end
        end
        if powerGenMonth >6 && powerGenMonth <=9
            for j=182:273
                [compareYear, compareMonth, compareDay ] =ymd(datetime(timeTAvgCellHistorical(j,1)));
                compareDate = [compareYear, compareMonth, compareDay ];
                
                if compareDate==powerGenDate
                    trainingCell{i,3}=timeTAvgCellHistorical{j,2};
                    trainingCell{i,4}=timePrcpCellHistorical{j,1};
                end
            end
        end
        if powerGenMonth >9
            for j=274:365
                [compareYear, compareMonth, compareDay ] =ymd(datetime(timeTAvgCellHistorical(j,1)));
                compareDate = [compareYear, compareMonth, compareDay ];
                
                if compareDate==powerGenDate
                    trainingCell{i,3}=timeTAvgCellHistorical{j,2};
                    trainingCell{i,4}=timePrcpCellHistorical{j,1};
                end
            end
        end
        
        
    end
    
    
    
    if powerGenYear == 2018
        if powerGenMonth <=3
            for j=366:length(timeTAvgCellHistorical(:,1))
                [compareYear, compareMonth, compareDay ] =ymd(datetime(timeTAvgCellHistorical(j,1)));
                compareDate = [compareYear, compareMonth, compareDay ];
                
                if compareDate==powerGenDate
                    trainingCell{i,3}=timeTAvgCellHistorical{j,2};
                    trainingCell{i,4}=timePrcpCellHistorical{j,1};
                end
            end
        end
%         if powerGenMonth >3 && powerGenMonth <=6
%        
%         end
%         if powerGenMonth >6 && powerGenMonth <=9
%          
%         end
%         if powerGenMonth >9
%         
%         end
        
    end
    
end


end

