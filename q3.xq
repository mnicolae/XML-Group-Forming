(: The college that most students are in. If there is a tie, report all colleges that tied. :)

(: get colleges :)
let $colleges := (for $p in doc("survey.xml")/Survey/MCQuestion[@qID = "college"]/Options/Option
		return $p)

(: get colleges and occurences :)
let $stats := (for $college in $colleges
	      let $occurences := count(for $ans in doc("responses.xml")/Responses/Response/MCAnswer[@qID = "college"]/Answer
				     where $ans/child::text() = $college/child::text()
				     return $ans)
	      return <stat><college>{$college/child::text()}</college><occurences>{$occurences}</occurences></stat>)

for $stat in $stats
where $stat/occurences = max(for $occ in $stats/occurences return $occ)
return $stat/college