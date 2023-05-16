set datafile separator ","
set key autotitle columnhead

set border linewidth 2

#set style line 100 lt 1 lc rgb "grey" lw 0.5 
#set grid ls 100 

set style fill solid
set boxwidth 0.5

set xlabel "Domain"
set xtics rotate
#set xtics 100

set ylabel "Users"
set grid y
#set ytics 50
set ylabel "Attendees" 

set terminal pngcairo size 1920,1080 enhanced font "DejaVu Sans,18"
set output fileout

plot filecsv using 2: xtic(1) with histogram title 'Users', "" using 0:2:2 with labels offset 0,1 title ""
