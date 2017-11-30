%files = dir(['C:\Users\Sharan\Desktop\Ti6242-2-Old-FS', '\*.txt']);
%numberOfFiles = length(files);



%fopen(filename, 'rt');  %for reading
%fopen(filename, 'wt');  %for writing

system('copy /a C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\*.txt C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\combined.txt');

%data = importdata('C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\*.txt',' ',14);
