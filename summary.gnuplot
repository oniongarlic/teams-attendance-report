set datafile separator ","
set key autotitle columnhead

set border linewidth 1

set style line 100 lt 1 lc rgb "grey" lw 0.5 
set grid ls 100 

set timefmt "%Y-%m-%d %H:%M:%S
set format x "%H:%M:%S"
set xdata time
set xlabel 'Time'
set xtics rotate
set xtics 300

set ylabel "Times"
set grid y
set ytics 50
set ylabel "Attendance" 

set terminal pngcairo size 1920,1080 enhanced font "DejaVu Sans,16"
set output fileout

plot filecsv using 1:2 with lines, '' using 1:3 with lines, '' using 1:4 with lines
