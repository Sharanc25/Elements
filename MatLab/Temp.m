%system('copy *.txt combined.txt');
fid = fopen('C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\1st day.txt', 'rt');
Data = textscan(fid, '%d %f %f', 'headerLines', 14, 'CollectOutput', true);
fclose(fid);
Data= cell2mat( Data);   