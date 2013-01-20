(: For each option (to a multiple choice question) that no one picked, 
   the question ID and the option text.
:)

(: options that were picked :)
let $picked := (for $a in doc("responses.xml")/Responses/Response/MCAnswer
	       return $a/Answer/child::text())

(: all options :)
let $all := (for $a in doc("survey.xml")/Survey/MCQuestion/Options
	    return $a/Option/child::text())

(: never picked :)
let $never := (for $a in $all
	      where not($a = $picked)
	      return $a)

(: final answer :)
for $q in doc("survey.xml")/Survey/MCQuestion
    let $opt := $q/Options/Option[child::text() = $never]
where exists($opt)
return <Question qID ="{$q/@qID}"> {$opt} </Question>