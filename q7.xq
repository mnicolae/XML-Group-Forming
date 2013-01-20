(: Valid xml (satisfying the DTD in file histogram.dtd, available on the Assignments page) 
   that contains a histogram showing the number of students who picked each project domain 
   in survey.xml.
:)

<Histogram>
{
(: get project domains :)

let $pd := (for $p in doc("survey.xml")/Survey/MCQuestion[@qID = "prefs"]/Options/Option
	    return $p)

for $opt in $pd
let $occurences := count(for $ans in doc("responses.xml")/Responses/Response/MCAnswer[@qID = "prefs"]/Answer 
		        where $ans/child::text() = $opt/child::text() 
		        return $ans)  
return <Bar choice="{$opt}" count="{$occurences}"> </Bar>
}
</Histogram>