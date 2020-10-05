%Merve Erdogan
%Analysis of optogenetic pilot animals
%2 seperate folder with different codes (23.09 - 04.11) & (18.11 to 12.03)
%Repro: 6, 7,10,11,12,16,23,58; FIPI: 17,18,19,20,33,35
%(L=10,11,16,23 R=6,7,12,58) & (L = 17,18,20,35 R = 19,33)
%PItimes & FItimes includes reaction times
%in PoptoFI & PoptoPI all datas are seperated depenent on FI PI
%Popto includes all data without separation
%times includes response duration of reproduction animals


clear;

for ii=[76 79]
    Popto.Subject(ii).Session.Data=[];
    level.sub(ii).Session.Data = [];%to put dates in (level up)
    lengthh.sub(ii).Session.Data = [];
end


%to put trials to be plotted together for PI trials
for pf = [76 79]
    PoptoPI.Subject(pf).Session.Data=[];
    PItimes.Subject(pf).Session.Data =[];
    Plotting.Subject(pf).FIPI.Data =[];
end



folder = dir ('D:\optogenetics_pilot_till12.03.2020\Piot _Data_w_current_since11.03.2020');
folder = folder([folder.isdir]);
[~,idx] = sort([folder.datenum]);
folder = folder(idx);


for d = 1:length(folder)
    
    name = sprintf('D:\\optogenetics_pilot_till12.03.2020\\Piot _Data_w_current_since11.03.2020\\%s',folder(d).name);
    
     
    t = dir(name);
    
    for i  = 1:length(t)
        cd (name);
        if t(i).name(end) == '.'
            break
        else
            y=dlmread(t(i).name);
        end
        
        day = str2double(folder(d).name(1:2)); %to put dates of level change day&month info is needed
        month = str2double(folder(d).name(4:5));%when it is string error
        
        if str2double(t(i).name(end-1:end))== 76
            if isempty(Popto.Subject(76).Session(1).Data)==1
                Popto.Subject(76).Session(1).Data=y;
                Popto.Subject(76).Session(1).Date=datestr(t(i).datenum);
            else
                Popto.Subject(76).Session(end+1).Data=y;
                Popto.Subject(76).Session(end).Date=datestr(t(i).datenum);
            end
            
        elseif str2double(t(i).name(end-1:end))== 79
            if isempty(Popto.Subject(79).Session(1).Data)==1
                Popto.Subject(79).Session(1).Data=y;
                Popto.Subject(79).Session(1).Date=datestr(t(i).datenum);
            else
                Popto.Subject(79).Session(end+1).Data=y;
                Popto.Subject(79).Session(end).Date=datestr(t(i).datenum);
            end
        end
        
    end
end


temp=[];
hemp=[];

for sub = [76, 79]
    for ses= 1: length(Popto.Subject(sub).Session)
        
        if isempty(Popto.Subject(sub).Session(ses).Data)==0
            
            % Öncelikle 2. columna 1.columndaki round ederek koyduk
            Popto.Subject(sub).Session(ses).Data(:,2)=round(Popto.Subject(sub).Session(ses).Data(:,1));
            
            % 3. column acip 1dekilerden 2.leri cikardik ki kusuratlarla iþlem
            % yapabilelim. Çünkü kusuratlar Pascal code'daki event kodlar !!
            Popto.Subject(sub).Session(ses).Data(:,3)=Popto.Subject(sub).Session(ses).Data(:,1)-Popto.Subject(sub).Session(ses).Data(:,2);
            
            
            % 3. columndakileri 1000 ile carptik ki event codelardaki rakamlara eriþebilelim.
            Popto.Subject(sub).Session(ses).Data(:,4)=Popto.Subject(sub).Session(ses).Data(:,3)*1000;
            
            %zamani 100'e böldük
            Popto.Subject(sub).Session(ses).Data(:,2) = Popto.Subject(sub).Session(ses).Data(:,2)/100;
            
            % virgülleri ortadan kaldýrmak için round ettik yeniden
            Popto.Subject(sub).Session(ses).Data(:,4)=round(Popto.Subject(sub).Session(ses).Data(:,4));
            
        end
    end
end


%FI PI seperation & Getting reaction times
%In Times matrix 1st column: trial duration, 2nd: rt
flagPI = 0;

for sub = [76 79]
    if sub == 79
        left =1;
    elseif sub ==76
        left = 0;
    end
    
     
    startPI=0;
    finishPI=0;
    trialdurationPI=0;
    leverPressPI=0;
    leverReleasePI=0;
    rtPI=0;
    
    for ses = 1: length(Popto.Subject(sub).Session)
        
        PoptoPI.Subject(sub).Session(ses).Date = Popto.Subject(sub).Session(ses).Date;
        PItimes.Subject(sub).Session(ses).Date = Popto.Subject(sub).Session(ses).Date;
        
        
        if isempty(Popto.Subject(sub).Session(ses).Data)==0
            for k = 1:length(Popto.Subject(sub).Session(ses).Data(:,4))
 
                if Popto.Subject(sub).Session(ses).Data(k,4) == 25 %PI trial beggining
                    flagPI = 1;
                    startPI = Popto.Subject(sub).Session(ses).Data(k,2);
                end
                %seting lever insert as starting moment in PI
                if flagPI == 1
                    if left == 1 && Popto.Subject(sub).Session(ses).Data(k,4) == 7 || left == 0 && Popto.Subject(sub).Session(ses).Data(k,4) == 8
                        startPI = Popto.Subject(sub).Session(ses).Data(k,2);
                    end
                end
                if Popto.Subject(sub).Session(ses).Data(k,4) == 26 %PI trial end
                    PoptoPI.Subject(sub).Session(ses).Data(end+1,1) = Popto.Subject(sub).Session(ses).Data(k,2);
                    PoptoPI.Subject(sub).Session(ses).Data(end,2) = Popto.Subject(sub).Session(ses).Data(k,4);
                    flagPI = 0;
                    startPI=0;
                end
                if flagPI == 1 %Put RT for PI
                    PoptoPI.Subject(sub).Session(ses).Data(end+1,1) = Popto.Subject(sub).Session(ses).Data(k,2);
                    PoptoPI.Subject(sub).Session(ses).Data(end,2) = Popto.Subject(sub).Session(ses).Data(k,4);
                    
                    if  left == 1 && Popto.Subject(sub).Session(ses).Data(k,4) == 1 || left == 0 && Popto.Subject(sub).Session(ses).Data(k,4) == 2 %L or R lever press
                        leverPressPI = Popto.Subject(sub).Session(ses).Data(k,2);
                        rtPI = leverPressPI - startPI;
                        PItimes.Subject(sub).Session(ses).Data(end+1,1)=rtPI;
                    end
                end
            end
        end
        end
end



%putting last 5 trials in PI sessions together to plot
for subje = [76,79]
    for sessions = length(PItimes.Subject(subje).Session)-4:length(PItimes.Subject(subje).Session)
        Plotting.Subject(subje).FIPI.Data = [Plotting.Subject(subje).FIPI.Data; PItimes.Subject(subje).Session(sessions).Data];
    end
end

%counting presses in each seconds in last 5 sessions will be plotted in PI
for p = [76,79]
    PIsec.Subject(p).Session.Data = [];
    if isempty(Plotting.Subject(p).FIPI.Data)==0
        for c=1:45 %trial duration is 45 sec = possible press time
            PIsec.Subject(p).Session.Data(end+1,1)=c;
            for k = 1:length(Plotting.Subject(p).FIPI.Data(:,1))
                a = sum(Plotting.Subject(p).FIPI.Data(:,1)>(c-1) & Plotting.Subject(p).FIPI.Data(:,1)<c);
            end
            PIsec.Subject(p).Session.Data(end,2) = a;
        end
        
        PIsec.Subject(p).Session.Data(:,3) = PIsec.Subject(p).Session.Data(:,2)/sum(PIsec.Subject(sub).Session.Data(:,2)); %the number of press in a bin / total number of press
        
        %normalizing
        PIsec.Subject(p).Session.Data(:,4) = PIsec.Subject(p).Session.Data(:,3)/max(PIsec.Subject(p).Session.Data(:,3));

    end
end
 

save opto_pilot

%histogram FIPI press time
m = 1;
for sub =[76,79]
     subplot(1,2,m);

    a= plot((smooth(PIsec.Subject(sub).Session.Data(:,3),15)),'k--');hold on; %smoothed
    b= plot(PIsec.Subject(sub).Session.Data(:,3),'g--'); hold on; %original data
    
    xlabel('Time(s)');
    ylabel('Response Rate');
    xline(15, 'r');
   
%     c = plot(smooth(PIsec.Subject(sub).Session.Data(:,3)/ max(smooth(PIsec.Subject(sub).Session.Data(:,3))))); %normalized data
%     xlabel('Time(s)');
%     ylabel('Response Rate');
%     xline(15, 'r');
%     title('Normalized Data');

title(['Subject(', num2str(sub),')']);

    figureName= sprintf('Subject%d',sub);%,size(TNS.Subject(sub).Session,2)
    print (figureName, '-dpng');
    m= m+1;
end

