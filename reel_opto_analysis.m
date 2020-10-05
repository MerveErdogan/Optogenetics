%Merve Erdogan
% Analysis of reel-opto animals' data (reproduction)
%Subj: 8,9,10,11,95,97,98,112
%Since these animals started at the last week of December 2019, data includes only 2020
%ROpto includes all data, trial, reward
%times includes, trial duration(1), response time (1), press time(3)
%First array in the level matrix includes trial numbers that subj. level up
%I added 10 for(8,9,10,11)in level values due to the plotting shape

clear;
folder = dir ('D:\Reel.-Optogenetics_till12.03.2020');
folder = folder([folder.isdir]);
[~,idx] = sort([folder.datenum]);
folder = folder(idx);
for ii=[8,9,10,11,95,97,98,112]
    ROpto.Subject(ii).Session.Data=[];
    level.sub(ii).Session.Data = [];%to put dates in (level up)
    times.Subject(ii).Session.Data = []; %for response, pressed & trial times
    Plotting.Subject(ii).Second.Data =[]; %to put trials to be plotted together
end


ses95 = 1; %for dates
ses97 = 1;
ses98 = 1;
ses112=1;
ses8 =1;
ses9=1;
ses10=1;
ses11=1;

for d=18:length(folder) %to start at the date these animals start(starting from 2020)
    if (folder(d).name)=='.'
        return
    end
    
    name = sprintf('D:\\Reel.-Optogenetics_till12.03.2020\\%s',folder(d).name');
    
    day = str2double(folder(d).name(1:2)); %to put dates of level change day&month info is needed
    month = str2double(folder(d).name(4:5));%when it is string error
    
    
    t = dir(name);
    
    
    if folder(d).name == '29.01.2020' %bugun 95in datasi yok
        ROpto.Subject(95).Session(end+1).Data=0;
        ROpto.Subject(95).Session(end).Date='29-Jan-2020';
        ses95 = ses95 +1;
    end
    
    if folder(d).name == '31.01.2020' %112 is not in the experiment for 11 post-op
        for q = 1:11
            ROpto.Subject(112).Session(end+1).Data=0;
            ROpto.Subject(112).Session(end).Date='X';
            ses112 = ses112 +1;
        end
    end
    
    for i=1:length(t)
        y=[];
        cd (name);
        if t(i).name(end) == '.'
            break
        else
            y=dlmread(t(i).name);
        end
        
        if str2double(t(i).name(end-1:end))==95
            if isempty(ROpto.Subject(95).Session(1).Data)==1
                ROpto.Subject(95).Session(1).Data=y;
                ROpto.Subject(95).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(95).Session(end+1).Data=y;
                ROpto.Subject(95).Session(end).Date=datestr(t(i).datenum);
                ses95 = ses95 +1;
            end
            if month == 1 && day == 14 || month == 3 && day == 3 %level up
                level.sub(95).Session(1).Data = [level.sub(95).Session(1).Data ses95];
            end
            
            if month == 2 && day == 11 %box change
                level.sub(95).Session(2).Data =ses95;
            end
            
            
        elseif str2double(t(i).name(end-1:end))==97
            if isempty(ROpto.Subject(97).Session(1).Data)==1
                ROpto.Subject(97).Session(1).Data=y;
                ROpto.Subject(97).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(97).Session(end+1).Data=y;
                ROpto.Subject(97).Session(end).Date=datestr(t(i).datenum);
                
                ses97 = ses97 +1;
            end
            if month == 1 && day ==23 || month == 2 && day ==24 %level up
                level.sub(97).Session(1).Data = [level.sub(97).Session(1).Data ses97];
            end
            if month == 2 && day == 11 %box change
                level.sub(97).Session(2).Data =ses97;
            end
            
            
        elseif str2double(t(i).name(end-1:end))==98
            if isempty(ROpto.Subject(98).Session(1).Data)==1
                ROpto.Subject(98).Session(1).Data=y;
                ROpto.Subject(98).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(98).Session(end+1).Data=y;
                ROpto.Subject(98).Session(end).Date=datestr(t(i).datenum);
                ses98 = ses98 +1;
            end
            if month == 1 && day == 8 || month == 1 && day == 14 || month == 1 && day == 22 %level up
                level.sub(98).Session(1).Data = [level.sub(98).Session(1).Data ses98];
            end
            if month == 2 && day == 11 %box change
                level.sub(98).Session(2).Data =ses98;
            end
            
        elseif str2double(t(i).name(end-2:end))==112
            if isempty(ROpto.Subject(112).Session(1).Data)==1
                ROpto.Subject(112).Session(1).Data=y;
                ROpto.Subject(112).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(112).Session(end+1).Data=y;
                ROpto.Subject(112).Session(end).Date=datestr(t(i).datenum);
                ses112 = ses112 +1;
            end
            if month == 1 && day == 9 || month == 1 && day == 16 || month == 1 && day ==  28 %level up
                level.sub(112).Session(1).Data = [level.sub(112).Session(1).Data ses112];
            end
            if month == 2 && day == 17 %operation
                level.sub(112).Session(3).Data =ses112;
            end
            
            
            
        elseif str2double(t(i).name(end))==8
            if isempty(ROpto.Subject(8).Session(1).Data)==1
                ROpto.Subject(8).Session(1).Data=y;
                ROpto.Subject(8).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(8).Session(end+1).Data=y;
                ROpto.Subject(8).Session(end).Date=datestr(t(i).datenum);
                ses8 = ses8 +1;
            end
            if month == 1 && day == 30 || month == 3 && day == 3 %level up
                level.sub(8).Session(1).Data = [level.sub(8).Session(1).Data ses8];
            end
            if month == 2 && day == 11 %box change
                level.sub(8).Session(2).Data =ses8;
            end
            
            
        elseif str2double(t(i).name(end))==9
            if isempty(ROpto.Subject(9).Session(1).Data)==1
                ROpto.Subject(9).Session(1).Data=y;
                ROpto.Subject(9).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(9).Session(end+1).Data=y;
                ROpto.Subject(9).Session(end).Date=datestr(t(i).datenum);
                ses9 = ses9 +1;
            end
            if day == 11  && month == 2 || month == 2 && day ==20 %level up
                level.sub(9).Session(1).Data = [level.sub(9).Session(1).Data ses9];
            end
            if month == 2 && day == 11 %box change
                level.sub(9).Session(2).Data =ses9;
            end
            
            
        elseif str2double(t(i).name(end-1:end))==10
            if isempty(ROpto.Subject(10).Session(1).Data)==1
                ROpto.Subject(10).Session(1).Data=y;
                ROpto.Subject(10).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(10).Session(end+1).Data=y;
                ROpto.Subject(10).Session(end).Date=datestr(t(i).datenum);
                ses10 = ses10 +1;
            end
            if day == 11 && month == 2 || month == 3 && day == 3 %level up
                level.sub(10).Session(1).Data = [level.sub(10).Session(1).Data ses10];
            end
            if day == 30 && month == 1 || month == 2 && day == 11 %box change
                level.sub(10).Session(2).Data =ses10;
            end
            
        elseif str2double(t(i).name(end-1:end))==11
            if isempty(ROpto.Subject(11).Session(1).Data)==1
                ROpto.Subject(11).Session(1).Data=y;
                ROpto.Subject(11).Session(1).Date=datestr(t(i).datenum);
            else
                ROpto.Subject(11).Session(end+1).Data=y;
                ROpto.Subject(11).Session(end).Date=datestr(t(i).datenum);
                ses11 = ses11 +1;
            end
            if month == 2 && day ==10 || month == 2 && day == 24 %level up
                level.sub(11).Session(1).Data = [level.sub(11).Session(1).Data ses11];
            end
            if month == 2 && day == 11 %box change
                level.sub(11).Session(2).Data =ses11;
            end
        end
    end
end

%Editting data due to fructionals
temp=[];
hemp=[];

for sub = [8,9,10,11,95,97,98,112]
    for ses= 1: length(ROpto.Subject(sub).Session)
        
        if isempty(ROpto.Subject(sub).Session(ses).Data)==0
            
            % Öncelikle 2. columna 1.columndaki round ederek koyduk
            ROpto.Subject(sub).Session(ses).Data(:,2)=round(ROpto.Subject(sub).Session(ses).Data(:,1));
            
            % 3. column açýp 1dekilerden 2.leri çýkardýk ki kusuratlarla iþlem
            % yapabilelim. Çünkü kusuratlar Pascal code'daki event kodlar !!
            ROpto.Subject(sub).Session(ses).Data(:,3)=ROpto.Subject(sub).Session(ses).Data(:,1)-ROpto.Subject(sub).Session(ses).Data(:,2);
            
            
            % 3. columndakileri 1000 ile çarptýk ki event codelardaki rakamlara eriþebilelim.
            ROpto.Subject(sub).Session(ses).Data(:,4)=ROpto.Subject(sub).Session(ses).Data(:,3)*1000;
            
            %zamaný 100'e böldük
            ROpto.Subject(sub).Session(ses).Data(:,2) = ROpto.Subject(sub).Session(ses).Data(:,2)/100;
            
            % virgülleri ortadan kaldýrmak için round ettik yeniden
            ROpto.Subject(sub).Session(ses).Data(:,4)=round(ROpto.Subject(sub).Session(ses).Data(:,4));
            
        end
    end
end

%Getting press duration into "times" matrix
%trial,reward,sec are calculated in the same matrix (ROpto)
%Last 3 sessions in each seconds are put together to be plotted in "Plotting" matrix
y =[];
x = [];
Y =[];
n =1;
flag = 0;
start=0;
finish=0;
left = 0;

for sub = [8,9,10,11,95,97,98,112]
    if sub == 9 || sub == 11 || sub == 95 || sub == 97
        left = 1;
    else
        left = 0;
    end
    
    if sub == 8 || sub == 9 || sub == 10 || sub == 11
        sec = 0; %data includes this group's FR1FT60 too
    elseif sub == 95 || sub == 97 || sub == 98 || sub == 112
        sec = 1; %in data this group starts from 1 sec
    end
    
    start=0;
    finish=0;
    trialDuration=0;
    pressDuration=0;
    leverPress=0;
    leverRelease=0;
    rt = 0;
    
    for ses= 1: length(ROpto.Subject(sub).Session)
        trial = 0;
        reward = 0;
        startcount=0;
        endcount=0;
        kcount=0;
        if isempty(ROpto.Subject(sub).Session(ses).Data)==0
            times.Subject(sub).Session(ses).Date = ROpto.Subject(sub).Session(ses).Date;
            for k = 1:length(ROpto.Subject(sub).Session(ses).Data(:,4))
                if ROpto.Subject(sub).Session(ses).Data(k,4) == 23 %trial begins
                    flag = 0;
                    startcount=startcount+1;
                    kcount = k;
                end
                %start trial with lever insert for rt
                if left == 1 && ROpto.Subject(sub).Session(ses).Data(k,4) == 7 || left == 0 && ROpto.Subject(sub).Session(ses).Data(k,4) == 8
                    start = ROpto.Subject(sub).Session(ses).Data(k,2); %to get the trial start time
                end
                if ROpto.Subject(sub).Session(ses).Data(k,4) == 24
                    trial = trial +1;
                    flag = 1;
                    endcount=endcount+1;
                    finish = ROpto.Subject(sub).Session(ses).Data(k,2); %to get the trial finish time
                    trialDuration = finish - start;
                    times.Subject(sub).Session(ses).Data(end,1)= trialDuration;
                    finish = 0; %since we used the value, to overwrite in the new trial
                    start = 0; %since we used the value, to overwrite in the new trial
                end
                
                if flag == 0 && ROpto.Subject(sub).Session(ses).Data(k,4) == 10
                    reward = reward +1;
                end
                
                if  left == 1 && ROpto.Subject(sub).Session(ses).Data(k,4) == 1 || left == 0 && ROpto.Subject(sub).Session(ses).Data(k,4) == 2 %L or R lever press
                    leverPress = ROpto.Subject(sub).Session(ses).Data(k,2); %response time
                    rt = leverPress - start; %response time how much after the trial
                    times.Subject(sub).Session(ses).Data(end+1,2)=rt;
                end
                if left == 1 && ROpto.Subject(sub).Session(ses).Data(k,4) == 4 || left == 0 && ROpto.Subject(sub).Session(ses).Data(k,4) == 5 %L or R lever release
                    leverRelease = ROpto.Subject(sub).Session(ses).Data(k,2); %release time
                    pressDuration = leverRelease - leverPress; %pressed duration
                    times.Subject(sub).Session(ses).Data(end,3)= pressDuration;
                    leverRelease = 0;
                    leverPress = 0;
                end
                
            end
            
            ROpto.Subject(sub).Session(ses).trial = trial; %trial
            ROpto.Subject(sub).Session(ses).reward = reward; %reward
            ROpto.Subject(sub).Session(ses).performance = (reward*100)/trial; %percentage
            if startcount > endcount
                ROpto.Subject(sub).Session(ses).Data(kcount:end) = [];
            end
            if ismember(ses, level.sub(sub).Session(1).Data)
                if sec ~= 0
                    Plotting.Subject(sub).Second(sec).Data=[];
                    for session = ses-2:ses
                        Plotting.Subject(sub).Second(sec).Data= [Plotting.Subject(sub).Second(sec).Data; times.Subject(sub).Session(session).Data(:,3)];
                    end
                end
                sec =sec +1;
            end
            ROpto.Subject(sub).Session(ses).second = sec;
        end
    end
    Plotting.Subject(sub).Second(sec).Data=[];
    for session = ses-2:ses
        Plotting.Subject(sub).Second(sec).Data= [Plotting.Subject(sub).Second(sec).Data; times.Subject(sub).Session(session).Data(:,3)];
    end
end


%sorting data in the matrix that will be plotted normalizing
for S = [8,9,10,11,95,97,98,112]
    for secs = 1:length(Plotting.Subject(S).Second)
        %sorting the press durations
        Plotting.Subject(S).Second(secs).Data = sortrows(Plotting.Subject(S).Second(secs).Data);
        %numbering each trials
        Plotting.Subject(S).Second(secs).Data(:,2) = 1:length(Plotting.Subject(S).Second(secs).Data);
        %dividing each trial num by total number
        Plotting.Subject(S).Second(secs).Data(:,3) = Plotting.Subject(S).Second(secs).Data(:,2)/length(Plotting.Subject(S).Second(secs).Data);
    end
end

save optoReel ROpto times Plotting level
clear;
load optoReel

%%pilotting
n =1;
for sub =[8,9,10,11,95,97,98,112]
    x=[]; y=[];
    for ses= 1: length(ROpto.Subject(sub).Session)
        x = [x ses];
        y = [y ROpto.Subject(sub).Session(ses).performance];
    end
    
    figure(1);
    sgtitle('Reproduction Data');
    subplot(4,2,n);
    plot(x,y,'bo-');
    xlim([0 50]);
    ylim([0 100]);
    ylabel('Trial/Reward(%)');
    xlabel('Sessions');
    for c = 1:length(level.sub(sub).Session(1).Data)
        xline(level.sub(sub).Session(1).Data(c), 'r');
        
        if sub == 112
            xline(level.sub(112).Session(3).Data, 'black'); 
            %no data of 112 on box change day, rather post op date
        end
    end
    
    title(['Subj(', num2str(sub),')']);
    hold on;
    x = [];
    y = [];
    n = n +1;
end

%histogram of press duration, reaction times
f=2;
LSexpGausParamsTest = [];

for sub =[8,9,10,11,95,97,98,112] 
    LSexpGausParams.Sub(sub).Data =[];  
    n=1;
    figure(f);
    sgtitle(['Subj(', num2str(sub),')']);
    for seconds = 1:length(Plotting.Subject(sub).Second)
    xdata = []; ydata = []; lsfit = [];    xvals= [];    yls_cdf = [];   
    
    xdata=Plotting.Subject(sub).Second(seconds).Data(:,1); %sorted press duration
    ydata=Plotting.Subject(sub).Second(seconds).Data(:,3); %(1:n)'/n;
       
    LSexpnormcdf = @(p, x)   p(1)*expcdf(x,p(2)) + (1-p(1))*normcdf(x,p(3),p(4)); 
    % the mixture distribution as a cumulative density function
    LSexpnormpdf = @(p, x)   p(1)*exppdf(x,p(2)) + (1-p(1))*normpdf(x,p(3),p(4)); 
    %the mixture distribution as a probability density function
    
    stdev = std(Plotting.Subject(sub).Second(seconds).Data(:,1));
    
    lower  = [0 zeros(1,3)];    upper  = [1 inf(1,3)];          x0 = [0.01  0.08 seconds stdev]; 
    
    lsfit  = lsqcurvefit( LSexpnormcdf, x0,xdata,ydata,lower,upper);
    LSexpGausParams.Sub(sub).Data(end+1,1:4) = lsfit;
    LSexpGausParams.Sub(sub).Data(end,5) = (LSexpGausParams.Sub(sub).Data(end,4)/LSexpGausParams.Sub(sub).Data(end,3));% calculates the CV
    
    % Predicted values for the cdf
    xvals = 0:0.1:9;
    yls_cdf = LSexpnormcdf( lsfit, xvals );
    
    
    subplot(2,length(Plotting.Subject(sub).Second),n);
    plot(xdata,ydata, 'k-', 'LineWidth', 2);hold on; %data cdf
    plot(xvals, yls_cdf, 'r-', 'LineWidth', 2);hold on; %from LSQ
    xlim([0 9]);  
    xlabel('Response Duration (s)');
    ylabel('Cumulative Density');
    title(['Second(', num2str(seconds),')']);

    
    subplot(2,length(Plotting.Subject(sub).Second),n+length(Plotting.Subject(sub).Second))
    dx=0.1;
    xbins = 0:dx:9;
    hx = hist(xdata,xbins);
    hx = hx/sum(hx);
    yls_pdf = dx*LSexpnormpdf(lsfit, xvals);
    bar(xbins,hx,'b'); hold on;
    plot(xvals, yls_pdf, 'r-', 'LineWidth', 2 );
    xlim([0 9]);
    xlabel('Response Duration (s)');
    ylabel('Density'); hold on;
    
    figureName= sprintf('TimeExpGausFitsSubj%d',sub);
    set(gcf,'Color',[1,1,1]);
    h=gcf;
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    print(gcf, '-dpng', figureName);
    
    n = n+1;
    end
    f = f+1;
    legend('Reproduction', 'LSfit');
end
