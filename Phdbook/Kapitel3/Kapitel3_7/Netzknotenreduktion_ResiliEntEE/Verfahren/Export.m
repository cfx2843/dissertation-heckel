%Speichert die Daten in Outputdata unter den in Filename eingetragenen
%Namen mit reduzierter Admittanzmatrix
run Adjred.m
filename='Outputdata\SciGRID';
save(filename,'-struct','app');
clear filename