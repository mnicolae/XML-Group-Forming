(: The group node of every group whose leader is junior to (in an earlier year in school) 
   some other member of that group.
:)

for $group in doc("division.xml")/Division/Group
let $leader := $group/Leader
let $leader_age := number(doc("responses.xml")/Responses/Response[@sID=$leader//text()]/NumAnswer[@qID = "year"]/Answer//text())

let $student_minimum_age := max(for $student in $group/Student
let $age := doc("responses.xml")/Responses/Response[@sID=$student//text()]/NumAnswer[@qID = "year"]/Answer//text()
return
if (exists($age))
then
number($age)
else
())

return
if ($student_minimum_age > $leader_age)
then
$group
else
()