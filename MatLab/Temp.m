%system('copy *.txt combined.txt');
data = importdata('C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\1st day.txt',' ',14);
for k = [1, 2]
   disp(data.data.colheaders{1, k})
   disp(data.data(:, k))
   disp(' ')
end