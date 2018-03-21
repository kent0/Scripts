tmp=`mktemp`
qstat --header 'JobID:User:JobName:WallTime:RunTime:Nodes:State' > $tmp
header=`cat $tmp | head -1`
iwalltime=`echo "$header" | grep -aob 'WallTime' | grep -oE '[0-9]+'`
ijobname=`echo "$header" | grep -aob 'JobName' | grep -oE '[0-9]+'`
cat $tmp | cut -c "1-$((ijobname+16)) $((iwalltime-1))-${#header}"
rm $tmp
