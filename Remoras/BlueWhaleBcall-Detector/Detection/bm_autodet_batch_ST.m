function bm_autodet_batch_ST(WavDir, OutDir)

% scroll through Sound Trap wav file - adapted from Shyam's BatchClassifyBlueCalls
% smk 100219

% ideal for regular wav files that have date/time information in the
% filename. If this is not the case, code should be adapted.

% modified by Anjali Boyd and Simone Baumann-Pickering September 9, 2019
% modified by Annebelle Kok Februari 6, 2020
%% Define settings to provide to findcalls.m
global REMORA
startF = REMORA.bm.settings.startF;
endF = REMORA.bm.settings.endF;
%startF    = [45.6, 44.3, 43.8, 43.2];	% Hz - start frequency kernel
%endF      = [44.3, 43.8, 43.2, 42.6];	% Hz - end frequency kernel
thresh =  REMORA.bm.settings.thresh; %detection threshold, was 30, lowered it to 10 to see how function works.
%thresh = 15;
%% Get list of wav files in deployment and define output
%Get all wavs in that deployment
%WavDir = 'G:\CI01_01_df8';
WavDir = REMORA.bm.settings.inDir;
SearchFileMaskMat = {'*wav'};
SearchPathMaskMat = {WavDir};
SearchRecursiv = 0;

[PathFileListWav, FileListWav, PathListWav] = ...
    utFindFiles(SearchFileMaskMat, SearchPathMaskMat, SearchRecursiv);

%Define output files
%OutDir = 'I:\Shared drives\Soundscape_Analysis\trial_output'; %NB: the drive letter changes quite often, so check.
OutDir = REMORA.bm.settings.outDir;
PathListCsv = PathListWav;
FileListCsv = FileListWav;

for l = 1:length(PathListCsv)
    path = PathListCsv{l};
    path = strrep(path,path,OutDir);
    PathListCsv{l} = path;
end

for l = 1:length(FileListCsv)
    file = FileListCsv{l};
    file = strrep(file,'wav','csv'); %make sure 'x.wav' is the correct extension that is altered.
    FileListCsv{l} = file;
end

for l = 1:length(FileListCsv)
    PathFileListCsv{l} = fullfile(PathListCsv{l},FileListCsv{l});
end

%% find start times from each file for Sound Trap data
RegDate = REMORA.bm.settings.regdate;
%RegDate = '(?<yr>\d\d)(?<mon>\d\d)(?<day>\d\d)(?<hr>\d\d)(?<min>\d\d)(?<s>\d\d)';
fileDates = dateregexp(FileListWav,RegDate);

%%
% 
gap = zeros([1,length(PathFileListWav)]); %duty cycle data
fileEnd = fileDates;
offset = zeros([1,length(PathFileListWav)]);
%out_fid = fopen(PathFileListCsv{120},'a');
%det_times = double.empty(1,0);
%det_times2 = double.empty(1,0);
%det_times = struct('');
%det_times2 = struct('');
maintable = [];

for fidx = 1:length(PathFileListWav)
    %Write into excel sheet
    %out_fid = fopen(PathFileListCsv{fidx}, 'a');   % Open xls file to write to
    %hdr = PathFileListWav{fidx};
    
    %%%%%%%%%% 
    %1) calculate n of hours (should be just under 3) =2:59:58-59
    %2) calculate sample start and sample end for each hour;
    %shift by 30 minutes to avoid missing calls on edges
    %3) feed each hour into findcalls 
    %4) in findcalls figure out how to incrementally write to csv file,
    %e.g. dlmwrite('test.csv',N,'delimiter',',','-append');
    %5) in findcalls - detection shows as peakS, being seconds into the
    %window; export of call start - add peakS to start of window
    times = [];
    filename = PathFileListWav{fidx};
    block = 3600;   % s - hourly increments
    halfblock = block/2;
    display(['calculating ',filename,'; file ',num2str(fidx),'/',num2str(size(PathFileListWav),1)])
    
    %time keeping; start of file and first hourly increment
    startTime = fileDates(fidx);
    incHr = datenum([0 0 0 1 0 0]);
    
    I = audioinfo(filename); %info on audio file properties
    totalsec = I.Duration;
    fileEnd(fidx)=startTime + (I.Duration/24/3600);
    blocknum = ceil(totalsec/block); %how many times will the whole window fit
   
    %start and end times in sample points for first file
if fidx == 1
        gap = 0;
        offset = 0;
    
   %First file is analysed in blocks
    for blockIdx = 1:blocknum  %scroll through blocks
        if blockIdx == 1
            startS = 1;
            endS = block*I.SampleRate;
            startTime1 = startTime;
            endTime = startTime + incHr;
        else
            startS = ((blockIdx-1)*block-20)*I.SampleRate;
            endS = (blockIdx)*block*I.SampleRate;
            startTime1 = startTime + datenum([0 0 0 0 0 ((blockIdx-1)*block-20)]);
            endTime = endTime + incHr;
        end
        if endS > I.TotalSamples
            endS = I.TotalSamples;
            block = (endS - startS)/I.SampleRate;
            endTime = startTime1 + datenum([0 0 0 0 0 block]);
        end
        
            % Read in data
            y = audioread(filename, [startS endS]);
%             if ~isempty(find(y==0,1))
%                 noSig = find(y==0);
%                 samplestop = noSig(1);
%                 samplestart = noSig(end);
%                 if samplestop ~= startS
%                 y1 = audioread(filename,[StartS,samplestop-1];
%                 endTime1 = (samplestop-1)/I.SampleRate;
%                 [abstime1,peakS1] = bm_findcalls_soundtrap(y1,I,blockIdx,startTime1,endTime1,startF,endF,thresh,block,halfblock,offset,1,filename);
%                 end
%                 if samplestart ~=endS
%                 y2 = audioread(filename,[samplestart+1,endS];
%                 startTime2 = (samplestart+1)/I.SampleRate;
%                 [abstime2,peakS2] = bm_findcalls_soundtrap(y2,I,blockIdx,startTime2,endTime,startF,endF,thresh,block,halfblock,offset,1,filename);
%                 end
%                 if ~isempty(abstime1) && ~isempty(abstime2)
%                 abstime = [abstime1,abstime2];
%                 peakS = [peakS1,peakS2];
%                 elseif ~isempty(abstime1)
%                     abstime = abstime1;
%                     peakS = peakS1;
%                 elseif ~isempty(abstime2)
%                     abstime =abstime2;
%                     peakS = peakS2;
%                 end
%             else
            [abstime,peakS] = bm_findcalls_soundtrap(y,I,blockIdx,startTime1,endTime,startF,endF,thresh,block,halfblock,offset,1,filename); %Waar gaat de output naartoe?
%             end
            ty = 1 - isempty(abstime);
        if ty == 1
            %det_times = vertcat(det_times,abstime);
            %det_times{fidx,blockIdx} = abstime;
        File = repmat({filename},length(abstime),1);
            Date = dbSerialDateToISO8601(abstime); %datetime(abstime,'ConvertFrom','datenum','Format','yyyy-MM-dd HH:mm:ss.sss');
            if ischar(Date)
                Date = {Date};
            end
            det_times = table(File,Date,abstime,peakS);
            %abstimefin = abstime+datenum([0 0 0 0 0 10]);
            %times = [abstime,abstimefin]; 
        else
          det_times = [];
        end 
         maintable = [maintable;det_times];
         %det_times2 = vertcat(det_times2,det_times);
        %dety = 1 - isempty(det_times);
        %if dety == 1
        %end
        
    end
    
    %If not first file, 20s segment of previous file will be added to the start
    %of the file, so no call gets missed.
else
    %gap(fidx) = floor((startTime - ...
    %fileEnd(fidx-1)) * 24 * 60 * 60);

        % Calculate the cumulative offset in scheduled gaps per raw file
    %offset(fidx) = offset(fidx-1) + gap(fidx); % will give cumulative gap time so far
    
    for blockIdx = 1:blocknum  %scroll through blocks
    
        if blockIdx == 1
            startS = 1; 
            endS = block*I.SampleRate;
            prevfile = PathFileListWav{fidx-1};
            J = audioinfo(prevfile);
            edge1S = J.TotalSamples-J.SampleRate*20;
            edge1E = J.TotalSamples;
            incS = datenum([0 0 0 0 0 20]);
            startTime1 = startTime - incS; 
            endTime = startTime + incHr+incS;
        else
            startS = ((blockIdx-1)*block-20)*I.SampleRate;
            endS = (blockIdx)*block*I.SampleRate;
            startTime1 = startTime + datenum([0 0 0 0 0 ((blockIdx-1)*block-20)]);
            endTime = endTime + incHr;
        end
        if endS > I.TotalSamples
            endS = I.TotalSamples;
            block = (endS - startS)/I.SampleRate;
            endTime = startTime1 + datenum([0 0 0 0 0 block]);
        end
        
        % Read in data
        if blockIdx == 1
            y1 = audioread(prevfile, [edge1S edge1E]);
            y2 = audioread(filename, [startS endS]);
            y = [y1; y2];
        else
            y = audioread(filename, [startS endS]);
        end
%         if ~isempty(find(y==0,1))
%                 noSig = find(y==0);
%                 samplestop = noSig(1);
%                 samplestart = noSig(end);
%                 if samplestop ~= startS
%                 y1 = audioread(filename,[StartS,samplestop-1];
%                 endTime1 = (samplestop-1)/I.SampleRate;
%                 [abstime1,peakS1] = bm_findcalls_soundtrap(y1,I,blockIdx,startTime1,endTime1,startF,endF,thresh,block,halfblock,offset,1,filename);
%                 end
%                 if samplestart ~=endS
%                 y2 = audioread(filename,[samplestart+1,endS];
%                 startTime2 = (samplestart+1)/I.SampleRate;
%                 [abstime2,peakS2] = bm_findcalls_soundtrap(y2,I,blockIdx,startTime2,endTime,startF,endF,thresh,block,halfblock,offset,1,filename);
%                 end
%                 if ~isempty(abstime1) && ~isempty(abstime2)
%                 abstime = [abstime1,abstime2];
%                 peakS = [peakS1,peakS2];
%                 elseif ~isempty(abstime1)
%                     abstime = abstime1;
%                     peakS = peakS1;
%                 elseif ~isempty(abstime2)
%                     abstime =abstime2;
%                     peakS = peakS2;
%                 end
%             else
        [abstime,peakS] = bm_findcalls_soundtrap(y,I,blockIdx,startTime1,endTime,startF,endF,thresh,block,halfblock,offset,1,filename); %Detect calls
%         end
        ty = 1 - isempty(abstime);
        if ty == 1
        %det_times{fidx,blockIdx} = abstime;
            %det_times = vertcat(det_times,abstime);
            File = repmat({filename},length(abstime),1);
            Date = dbSerialDateToISO8601(abstime); %datetime(abstime,'ConvertFrom','datenum','Format','yyyy-MM-dd HH:mm:ss.sss');
            if ischar(Date)
                Date = {Date};
            end
            det_times = table(File,Date,abstime,peakS);
            %abstimefin = abstime+datenum([0 0 0 0 0 10]);
            %times = [abstime,abstimefin];
        else
            det_times = [];
        end 
        maintable = [maintable;det_times];
    end
   
    
%det_times2 = vertcat(det_times2,det_times);   
%dety = 1 - isempty(det_times{fidx,:});
 %       if dety == 1
        %det_times2{1,fidx} = vertcat(det_times{fidx,:});
        
  %      else
   %     det_times2{1,fidx} = '';    
    %    end
end
%filename = split(PathFileListCsv,'.csv');
%labelname = [filename{fidx},'_BlueWhaleLabels.tlab'];
%ioWriteLabel(labelname,times,'Blue whale'); 
%fclose(out_fid);

end
%for Idx = 1:length(maintable{:,1})
    
    %det_times2{1,Idx} = vertcat(det_times{Idx,:});
%det_times3 = vertcat(det_times2{:});
tty = 1 - isempty(maintable);
if tty==1
prevcall = [];
    prevcall(2:(length(maintable.abstime)),1) = maintable.abstime(1:(length(maintable.abstime)-1),1); %add times of previous call to second column, so time difference can be calculated.
    timediff = maintable.abstime-prevcall;
    check(1:length(maintable.abstime),1) = 0;
   check(timediff < datenum([0 0 0 0 0 5])) = 1;
   check = table(check);
   %dvec = datevec(det_times3);
   %seconds = num2str(dvec(:,6));
   %date = datestr(det_times3,31);
   %results = table(date,seconds,check);
   results = [maintable,check];
   filename = split(PathFileListCsv,'.csv');
   csvname = [filename{fidx},'_Bm_thresh',num2str(thresh),'.csv'];
   writetable(results,csvname); 
   
   %Write label file
   startTriton = maintable.abstime - dateoffset();
   endTriton = startTriton + datenum([0 0 0 0 0 10]);
   times = [startTriton, endTriton];
   
labelname = [filename{fidx},'_Bm_thresh', num2str(thresh),'.tlab'];
ioWriteLabel(labelname,times,'Bm','Binary',true);

    %Write mat file
%     matname = [filename{fidx},'_Bm_thresh',num2str(thresh),'.mat'];
%     settings = REMORA.bm.settings;
%     %remove padded text
%     endtime = maintable.abstime + datenum([0 0 0 0 0 10]);
%     times = [maintable.abstime,endtime];
%     BmLabels = repmat({'Bm'},size(times(:,1)));
%     save(matname,'times',...
%         'BmLabels','settings','-mat','-v7.3');
end
end


 