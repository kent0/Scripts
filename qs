IFS=$'\n'
tmp=`mktemp`
qstat --header 'JobID:User:JobName:WallTime:RunTime:Nodes:State' > $tmp
header=`cat $tmp | head -1`
body=`awk 'NR > 2 { print }' $tmp`
wt=(`cat $body | awk 'print $4'`)
rt=(`cat $body | awk 'print $5'`)
for i in ${#wt[@]}; do
    t0=`date +%s -d ${wt[i]}`
    t1=`date +%s -d ${rt[i]}`
    date -d@$((t0 - t1)) -u +%T
done
iwalltime=`echo "$header" | grep -aob 'WallTime' | grep -oE '[0-9]+'`
ijobname=`echo "$header" | grep -aob 'JobName' | grep -oE '[0-9]+'`
cat $tmp | cut -c "1-$((ijobname+16)) $((iwalltime-1))-${#header}"
rm $tmp
