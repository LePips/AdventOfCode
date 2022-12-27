#!/bin/bash

# Usage: setup.sh <year>

mkdir "../Sources/AdventOfCode$1"

# Year
RawYearFile=$(cat Year_Skeleton.swift)
NewYearFile="${RawYearFile/num/$1}"

touch "../Sources/AdventOfCode$1/$1.swift"
echo "$NewYearFile" >> "../Sources/AdventOfCode$1/$1.swift"

# Days
for num in {1..25}
do
	mkdir "../Sources/AdventOfCode$1/Day$num"
	RawFile=$(cat Day_Skeleton.swift)
	NewFile="${RawFile/num/$num}"
	
	touch "../Sources/AdventOfCode$1/Day$num/Day$num.swift"
	echo "$NewFile" >> "../Sources/AdventOfCode$1/Day$num/Day$num.swift"
 
    touch "../Sources/AdventOfCode$1/Day$num/Day$num.txt"
done
