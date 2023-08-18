set datafile separator ","
set key autotitle columnhead

set border linewidth 2

#set style line 100 lt 1 lc rgb "grey" lw 0.5 
#set grid ls 100 

set style fill solid
set boxwidth 0.5

set xlabel "Duration"
set xtics rotate
set timefmt "%H:%M:%S
set format x "%H:%M:%S"
set xdata time

set ylabel "Attendance"
set grid y

set terminal pngcairo size 1920,1080 enhanced font "DejaVu Sans,18"
set output fileout

plot filecsv using 2:1
