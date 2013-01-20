(: For every student in the class, the student ID and their college. 
   If the student has not answered the college question, give 
   "no college reported" as their college.
:)

let $doc := doc("responses.xml")  
for $response in $doc/Responses/Response
   let $sid := $response/@sID
   let $answer := $response/MCAnswer[@qID = "college"]/Answer/child::text()
return 
if (exists($answer))
then
  <Student> {$sid} <College> {$answer} </College></Student>
else
  <Student> {$sid} <College>no college provided</College></Student>
