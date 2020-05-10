#!/bin/bash
        CLEAR='\033[2J'
	SETTOHOME='\033[H'
        CLEARNSET='\033[2J\033[H'
	RED='\033[0;31m'
        GREEN='\033[0;32m'
        NC='\033[0m'
        ON="$GREEN on$NC"
        OFF="$RED of$NC"

        declare -a name
        declare -a hosts
        declare -a answer
	declare -a octs
	i=0
	j=0
	cnt=0
	mod=0
	zero=0
	curoct=101

echo -e $CLEAR
#echo c01 c02 c03 c04 c05 c06 c07 c08 c09 c10 c11 c12 c13 c14 bkv
#echo -e $NO $NO $NO $NO $NO
echo -e $SETTOHOME

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
#	octs[$i]="$curoct"
#	echo $curoct
#	let curoct++
	let i++
done < hosts.txt
cnt=0
j=0
i=0
for j in "${hosts[@]}"
do
	ping -c 2 $j 2> /dev/null
	if (($? == 0)); then
		answ[$cnt]=$ON
		#echo "$octs[$i]"
		if (($i < 13)); then
			mkdir $curoct
		fi
		#ssh-copy-id -o "StrictHostKeyChecking no" $j
		scp $j:/etc/passwd $curoct/
		ssh $j 'ls -d -l /home/*' >$curoct/home.txt
		else answ[$cnt]=$OFF
	fi
	let curoct++
	let i++
	let cnt++
done
echo -e $CLEARNSET
echo "${name[@]}"
echo -e "${answ[@]}"



