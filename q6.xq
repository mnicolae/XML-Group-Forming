(: Valid xml (satisfying the DTD in file years.dtd, available on the Assignments page) 
   that contains the student ID and year of every student in the class.
:)

<Students>
{
for $r in doc("responses.xml")/Responses/Response
return <Student who="{$r/@sID}" year="{$r/NumAnswer[@qID = "year"]/Answer}"></Student>
}
</Students>