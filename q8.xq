(: Valid xml (satisfying the DTD in file availability.dtd, available on the Assignments page) 
   that shows for each group, the number of timeslots to which all group members answered yes.
:)

<Availability>
{
(: get group ID's :)
let $groups := (for $g in doc("division.xml")/Division/Group
	       return $g)

let $times := (for $timeslot in doc("survey.xml")/Survey/TimeQuestion[@qID = "times"]/Options/Option
		let $option_index := index-of(doc("survey.xml")/Survey/TimeQuestion[@qID = "times"]/Options/Option, $timeslot)
		let $time_array := (for $group in doc("division.xml")/Division/Group
		    let $member_response:= (for $member in $group/*
					  return doc("responses.xml")/Responses/Response[@sID = $member]/TimeAnswer[@qID = "times"]/Answer[$option_index])
		    return <Group gID="{$group/@gID}">
				  <Answers> {$member_response} </Answers>
			   </Group>)
	      return $time_array)

    for $g in $groups
    let $occurences := count(for $time in $times
			   where $time/@gID = $g/@gID 
			   and every $a in $time/Answers/Answer satisfies $a/child::text() = "yes"
			   and count(for $mem in $g/Student return $mem) + 1 = count(for $a in $time/Answers/Answer return $a)
			   return $time)    
    return <Group numslots="{$occurences}"> {string($g/@gID)} </Group>
}
</Availability>