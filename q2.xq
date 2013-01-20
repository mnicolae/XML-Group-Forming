(: The average group size :)

let $num := count(
		for $group in doc("division.xml")/Division/Group
		return $group
		)

let $sum := sum(
	    for $group in doc("division.xml")/Division/Group
	    let $size := count($group/Student) + 1
	    return $size
	    )
	    
return <AverageGroupSize> {$sum div $num} </AverageGroupSize>