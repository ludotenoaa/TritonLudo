function sh_init_batch_gui
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% sh_init_batch_gui.m
%
% Verify settings in GUI before running on entire drive.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global REMORA

% button grid layouts
% 14 rows, 4 columns
r = 26; % rows      (extra space for separations btw sections)
c = 3;  % columns
h = 1/r;
w = 1/c;
dy = h * 0.8;
% dx = 0.008;
ybuff = h*.2;
xbuff = w*.1;
% y position (relative units)
y = 1:-h:0;

% x position (relative units)
x = 0:w:1;

% colors
bgColor = [1 1 1];  % white
bgColorGrayLight = [.92 .92 .92];  % gray
bgColorGray = [.86 .86 .86];  % gray

REMORA.sh_verify = [];
labelStr = 'Verify Detector Options';
btnPos=[x(1) y(2) w*3 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','points', ...
    'FontWeight','bold',...
    'FontSize',10,...
    'Visible','on');


% Set paths and strings
%***********************************

% Output Folder Text
labelStr = 'Output Folder';
btnPos=[x(1)+xbuff  y(3) w dy];
REMORA.sh_verify.outDirTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Output Folder Editable Text
labelStr=num2str(REMORA.sh.settings.outDir);
btnPos=[x(2)-w/4 y(3) w*2.2 dy];
REMORA.sh_verify.outDirEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setOutDir'')');


% Transfer Function Text
labelStr = 'Transfer Function Path';
btnPos=[x(1)+xbuff  y(4) w dy];
REMORA.sh_verify.TFPathTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
        'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Transfer Function Editable Text
labelStr=num2str(REMORA.sh.settings.tfFullFile);
btnPos=[x(2)-w/4 y(4) w*2.2 dy];
REMORA.sh_verify.TFPathEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'HorizontalAlignment','left',...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setTFPath'')');


% Detector settings
labelStr = 'Adjustable Detector Settings';
btnPos=[x(1) y(6) w*3 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGray,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');


% col names
labelStr='Parameter';
btnPos=[x(1) y(7) w*2 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Min';
btnPos=[x(3) y(7) w/2 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

labelStr='Max';
btnPos=[x(3)+w/2 y(7) w/2 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'BackgroundColor',bgColorGrayLight,...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

%***********************************
% Low Band Limits Text
%***********************************

%  Low Band Limit Text
labelStr = 'Low Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(8)-ybuff w*2 h];
REMORA.sh_verify.LowBandText = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr,'Interpreter','tex'),...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Low Band Limit Editable Text
labelStr=num2str(REMORA.sh.settings.lowBand(1,1));
btnPos=[x(3) y(8) w/2 h];
REMORA.sh_verify.MinLowBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMinLowBand'')');

% Maximum Low Band Limit Editable Text
labelStr=num2str(REMORA.sh.settings.lowBand(1,2));
btnPos=[x(3)+w/2 y(8) w/2 h];
REMORA.sh_verify.MaxLowBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMaxLowBand'')');

%***********************************
% Medium Band Limits Text
%***********************************
labelStr = 'Medium Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(9)-ybuff w*2 h];
REMORA.sh_verify.MediumBandText = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr),...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Medium Band Limit Editable Text
labelStr=num2str(REMORA.sh.settings.mediumBand(1,1));
btnPos=[x(3) y(9) w/2 h];
REMORA.sh_verify.MinMediumBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMinMediumBand'')');

% Maximum Medium Band Limit Editable Text
labelStr=num2str(REMORA.sh.settings.mediumBand(1,2));
btnPos=[x(3)+w/2 y(9) w/2 h];
REMORA.sh_verify.MaxMediumBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMaxMediumBand'')');

%***********************************
% High Band Limits Text
%***********************************
labelStr = 'High Band Limit (Hz)';
btnPos=[x(1)+xbuff*2 y(10)-ybuff w*2 h];
REMORA.sh_verify.MediumBandText = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',sprintf(labelStr),...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Limit Editable Text
labelStr=num2str(REMORA.sh.settings.highBand(1,1));
btnPos=[x(3) y(10) w/2 h];
REMORA.sh_verify.MinHighBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMinHighBand'')');

% Maximum Duration Limit Editable Text
labelStr=num2str(REMORA.sh.settings.highBand(1,2));
btnPos=[x(3)+w/2 y(10) w/2 h];
REMORA.sh_verify.MaxHighBandEdText = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMaxHighBand'')');

%***********************************
% Duration Threshold Close Passage Text
%***********************************
labelStr = 'Close Passage Duration Threshold (s)';
btnPos=[x(1)+xbuff*2 y(11)-ybuff w*2 h];
REMORA.sh_verify.ThrCloseTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Close Passage Editable Text
labelStr=num2str(REMORA.sh.settings.thrClose);
btnPos=[x(3) y(11) w/2 h];
REMORA.sh_verify.ThrCloseEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setThrClose'')');

%***********************************
% Duration Threshold Distant Passage Text
%***********************************
labelStr = 'Distant Passage Duration Threshold (s)';
btnPos=[x(1)+xbuff*2 y(12)-ybuff w*2 h];
REMORA.sh_verify.ThrDistantTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.sh.settings.thrDistant);
btnPos=[x(3) y(12) w/2 h];
REMORA.sh_verify.ThrDistantEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setThrDistant'')');

%***********************************
% Received Level Threshold Text
%***********************************
labelStr = 'Received Level Threshold (%)';
btnPos=[x(1)+xbuff*2 y(13)-ybuff w*2 h];
REMORA.sh_verify.ThrRLTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.sh.settings.thrRL);
btnPos=[x(3) y(13) w/2 h];
REMORA.sh_verify.ThrRLEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setThrRL'')');

%***********************************
% Minimum Time Between Passages Threshold Text
%***********************************
labelStr = 'Time Between Passages (h)';
btnPos=[x(1)+xbuff*2 y(14)-ybuff w*2 h];
REMORA.sh_verify.MinPassageTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.sh.settings.minPassage);
btnPos=[x(3) y(14) w/2 h];
REMORA.sh_verify.MinPassageEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setMinPassage'')');

%***********************************
% Buffer Time Detections Text
%***********************************
labelStr = 'Buffer Time (min)';
btnPos=[x(1)+xbuff*2 y(15)-ybuff w*2 h];
REMORA.sh_verify.BufferTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');

% Minimum Duration Threshold Distant Passage Editable Text
labelStr=num2str(REMORA.sh.settings.buffer);
btnPos=[x(3) y(15) w/2 h];
REMORA.sh_verify.BufferEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setBuffer'')');

%***********************************
% Duty Cycle Text
%***********************************
labelStr = 'Duty Cycle Data';
btnPos=[x(1)+xbuff*2 y(16) w h];
REMORA.sh_verify.dutyCycleCheckbox = uicontrol(REMORA.fig.sh.batch,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'Value',REMORA.sh.settings.dutyCycle,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setDutyCycle'')');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Window heading
labelStr = 'HARP data only:';
btnPos=[x(1)+xbuff y(17)-ybuff w*2 h];
REMORA.sh_verify.WindowHeading = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontWeight','bold',...
    'FontUnits','normalized', ...
    'Visible','on');

%***********************************
% Disk Write Noise Text
%***********************************
labelStr = 'Exclude Disk-Write Noise';
btnPos=[x(1)+xbuff*2 y(18) w h];
REMORA.sh_verify.diskWriteCheckbox = uicontrol(REMORA.fig.sh.batch,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'Value',REMORA.sh.settings.diskWrite,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setDiskWrite'')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Window heading
labelStr = 'Window Settings:';
btnPos=[x(1)+xbuff y(19)-ybuff w*2 h];
REMORA.sh_verify.WindowHeading = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontWeight','bold',...
    'FontUnits','normalized', ...
    'Visible','on');

%***********************************
% Duration Window Text
%***********************************

labelStr = 'Window Size (h)';
btnPos=[x(1)+xbuff*2 y(20)-ybuff w*2 h];
REMORA.sh_verify.DurWindTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
% Duration Window Editable Text
labelStr=num2str(REMORA.sh.settings.durWind);
btnPos=[x(3) y(20) w/2 h];
REMORA.sh_verify.DurWindEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setDurWind'')');

%***********************************
% Slide Overlapping Window Text
%***********************************

labelStr = 'Sliding Time Overlapping Windows (h)';
btnPos=[x(1)+xbuff*2 y(21)-ybuff w*2 h];
REMORA.sh_verify.SlideTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','text',...
    'Units','normalized',...
    'HorizontalAlignment','left',...
    'Position',btnPos,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on');
% Slide Editable Text
labelStr = num2str(REMORA.sh.settings.slide);
btnPos=[x(3) y(21) w/2 h];
REMORA.sh_verify.SlideEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','edit',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',bgColor,...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setSlide'')');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Post Processing Options
labelStr = 'Post-Processing Options:';
btnPos=[x(1)+xbuff y(22)-ybuff w*2 h];
REMORA.sh_verify.headtext = uicontrol(REMORA.fig.sh.batch, ...
    'Style','text', ...
    'Units','normalized', ...
    'Position',btnPos, ...
    'HorizontalAlignment','left',...
    'String',labelStr, ...
    'FontUnits','normalized', ...
    'FontWeight','bold',...
    'Visible','on');

%***********************************
% Save .tlab file Checkbox
%***********************************
labelStr = 'Create .csv Ouput File';
btnPos=[x(1)+xbuff*2 y(23) w h];
REMORA.sh_verify.csvCheckbox = uicontrol(REMORA.fig.sh.batch,...
    'Style','checkbox',...
    'Units','normalized',...
    'Position',btnPos,...
    'String',labelStr,...
    'Value',REMORA.sh.settings.saveCsv,...
    'FontUnits','normalized', ...
    'Visible','on',...
    'Callback','sh_control(''setCsvFile'')');

% Run button
labelStr = 'Run Detector';
btnPos=[x(2) y(25) w h];
REMORA.sh_verify.RunDetectorEdTxt = uicontrol(REMORA.fig.sh.batch,...
    'Style','pushbutton',...
    'Units','normalized',...
    'Position',btnPos,...
    'BackgroundColor',[.47,.67,.19],...
    'String',labelStr,...
    'FontUnits','normalized', ...
    'FontSize',.5,...
    'Visible','on',...
    'FontWeight','bold',...
    'Callback','sh_control(''RunBatchDetection'')');
