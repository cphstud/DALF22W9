#!/bin/bash -x

find ./matches/* -type f | while read x
do
  grep -l female $x
done | while read x
do
  grep match_id $x
done | cut  -d\: -f2 |  cut -d\, -f1 | sort | uniq > listoffemgames
cat listoffemgames  | while  read x
do
  cp events/$x.json tmp
done
for i in tmp/*json; do sed -i '' -e 's/^\[//g' $i; done
for i in tmp/*json; do sed -i '' -e 's/^} \]/}/g' $i; done
for i in tmp/*json; do sed -i '' -e 's/^  \"id/  \"_id/g' $i;done
for i in tmp/*json; do sed -i '' -e 's/^}, {/}\n{/g' $i;done
#for i in *json;  do mongoimport -d statsbomb -c matches $i;done

