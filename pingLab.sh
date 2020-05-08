#!/bin/bash
        CLEAR='\033[2J'
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        NC='\033[0m'
        ON="$GREEN on$NC"
        OFF="$RED of$NC"

        declare -a name
        declare -a hosts
        declare -a answer
	i=0
	j=0
	cnt=0
	mod=0
	zero=0	

echo -e $CLEAR
#echo c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12 c13 c14 bkv
#echo -e $NO $NO $NO $NO $NO

while IFS= read -r line
do
	echo $line
	IFS=' ' read -ra split_array <<< "$line"
		for j in "${split_array[@]}"
		do
			if (("$mod" == "$zero")); then
				name[$i]=$j
				echo "$name[$i]"
				let mod++
			else
				hosts[$i]="$j "
				echo "$hosts[$i]"
				mod=0
			fi
			let cnt++
		done
	let i++
done < hosts.txt
cnt=0
j=0
for j in "${hosts[@]}"
do
	ping -c 2 $j 2> /dev/null
	if (($? == 0)); then
		answ[$cnt]=$ON
		ssh-copy-id -o "StrictHostKeyChecking no" $j
		scp $j:/etc/passwd $j/
		ssh $j 'ls -d -l /home/*' >$j/home.txt
		else answ[$cnt]=$OFF
	fi
	let cnt++
done
echo -e $CLEAR
echo "${name[@]}"
echo -e "${answ[@]}"



