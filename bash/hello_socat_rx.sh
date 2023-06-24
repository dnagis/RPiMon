#!/bin/sh

#Comment recevoir des arguments dans un remote script 
#socat -t 10 TCP-LISTEN:1212,fork EXEC:/bin/hello_socat_rx.sh &

#code maintenu dans RPiMon/bash/

#echo salut | socat - TCP:192.168.49.1:1212 

echo debut script hello_socat_rx.sh

#deux manières différentes de récupérer ce qui a été envoyé (puisque $1 $2 ne marche pas)
#STDIN=$(cat) #serait comme `cat`
read STDIN


echo $STDIN

W1=`echo $STDIN | cut -d' ' -f1`
W2=`echo $STDIN | cut -s -d' ' -f2` #sans -s: en labsence de delimiter cut renvoie la ligne entiere (donc le 1st field)

echo variables W1=$W1 W2=$W2


