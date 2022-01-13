function spHelpStrings = sp_get_help_strings

%%% Detector parameter choices %%%
spHelpStrings.baseDir = 'Location of base directory containing files or directories of files to be analyzed.';

spHelpStrings.outDir = ['Optional output directory location. Metadata directory will be\n ',...
 'created in outDir if specified, otherwise it will be created in baseDir.'];
 
spHelpStrings.TFPath = 'Transfer function file location. Optional, but highly recommended.';

spHelpStrings.deployName = ['File name wildcard. This should be the first few characters\n ',...
'in the names of the directory(ies) you want to look at.'];

spHelpStrings.channel = 'Which channel to detect on.';

spHelpStrings.overwrite = ['Overwrite existing detector output? In case of a crash,\n '...
 'leave unchecked to skip previously-processed files and pick up\n ',...
 'where you left off.'];

spHelpStrings.PPThresholdTF = 'If selected, detector will operate in peak-to-peak amplitude threshold mode.';

spHelpStrings.snrDetTF = 'If selected, detector will operate in signal-to-noise ratio (SNR) threshold mode.';

spHelpStrings.PPThreshold = 'Minimum amplitude threshold in dB used for peak to peak mode.';

spHelpStrings.SNRThreshold = 'Minimum SNR threshold for SNR mode.';

spHelpStrings.BandPass = 'Bandpass filter edges.';

spHelpStrings.ClickDurLim = 'Detections with durations outside this range will be discarded.';

spHelpStrings.PeakFreq = 'Detections with peak frequencies outside this range will be discarded.';
 
spHelpStrings.clipThreshold = ['Normalized clipping threshold btwn 0 and 1, used to try to,\n ',...
 'reject highly-saturated, possibly-clipped signals.\n  ', ...
 'If 1, nothing will be rejected based on saturation.'];

spHelpStrings.rmIsolated = ['Max time in seconds allowed between neighboring detections.\n ',...
 'Detections that are far from neighbors can be rejected using this parameter.\n ',...
 'Can be useful in noisy environments.'];

spHelpStrings.rmEchoTF = '';

spHelpStrings.lockoutTxt = 'Min gap between detections in seconds, only used if rmEchos=TRUE.';

spHelpStrings.noiseTF = 'Save noise snippets. Can be useful for understanding background noise levels.';

spHelpStrings.saveForTPWSTF = ['If true, save just enough data to build TPWS files. ',...
'Helps reduce output data size.'];

spHelpStrings.GuidedDetTF = ['Allows you to use a text file or spreadsheet to restrict time periods\n ',...
 'over which the detector will run.\n ',...
 'See example file: Triton\Remoras\SPICE-Detector\ui\settings\guidedDets_example.csv'];

spHelpStrings.WaveRegExp = ['If you are using wav files that have a time stamp in the name,\n ',...
 ' put a regular expression for extracting that here.\n ',...
 ' Examples:\n ',...
 '     a) File name looks like: "myFile_20110901_234905.wav"\n ',...
 '        ie.:  "*_yyyymmdd_HHMMSS.wav"\n ',...
 '        So use:\n '  ,...
 '        parametersST.DateRE = ''_(\\d*)_(\\d*)'';\n ',...
 ' \n  ',...
 '     b) File name looks like: "palmyra102006-061104-012711_4.wav"\n ',...
 '        ie.:  "*yyyy-yymmdd-HHMMSS*.wav"\n ',...
 '        So use: \n ',...
 '        parametersST.DateRE = ''(\\d{4})-\\d{2}(\\d{4})-(\\d{6})'';\n '];

spHelpStrings.dEnv = ['Envelope energy distribution comparing first half to second half\n '...
'of high energy envelope of click. If there is more energy in the\n ',...
'first half of the click (dolphin) dEv >0. If it''s more in the\n ',...
'second half (boats?) dEv<0. If it''s about the same (beaked whale)\n ',...
'dEnv ~= 0 , but still allow a range.'];

spHelpStrings.LRbuffer = ['Number of seconds of data to add on either side of detections\n ',...
 'of interest in low resolution first pass.'];

spHelpStrings.HRBuffer = ['Number of seconds of data to add on either side of detections\n ',...
 'when saving detection waveforms in high resolution second pass.'];

spHelpStrings.mergeThreshold = ['Min gap between energy peaks in us. Anything less will be,\n ',...
 'merged into one detection the beginning of the next is fewer\n ',...
 'samples than this, the signals will be merged.'];

spHelpStrings.energyPerc = ['Sets the threshold at which click start and end are defined.\n ',...
 'In a time window of interest, the detector finds the maximum energy peak,\n ',...
 'and then walks forward and back in time, until it gets to an energy level\n ',...
 'set by this threshold, ie. 70th percentile of energy in the time window. '];

spHelpStrings.energyThr = '';

spHelpStrings.BPfilterOrder = 'Butterworth filter order used for bandpass.';

spHelpStrings.Parpool = 'Number of parallel detection processes to run.';