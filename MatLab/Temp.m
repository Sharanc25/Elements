%system('copy *.txt combined.txt');
data = importdata('C:\Users\Sharan\Desktop\Ti6242-2-Old-FS\1st day.txt',' ',14);
for k = [1, 2]
   disp(A.colheaders{1, k})
   disp(A.data(:, k))
   disp(' ')
end