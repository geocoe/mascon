function timeElapsedShow(timeElapsed)
second=floor(mod(timeElapsed,60));
minute=floor(timeElapsed/60);
hour=floor(minute/60);
minute=mod(minute,60);
% 格式化数字
formattedhour=sprintf('%02d',hour);
formattedminute=sprintf('%02d',minute);
formattedsecond=sprintf('%02d',second);
disp(['程序运行结束耗时为:',formattedhour,':',formattedminute,':',formattedsecond]);