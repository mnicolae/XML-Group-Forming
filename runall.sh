#! /bin/sh

echo "Checking Assignment 4 Solutions" > results.txt

echo "" >> results.txt
echo "======= Checking xml files =======" >> results.txt

echo "" >> results.txt
echo "--- survey.xml ---" >> results.txt
echo "well-formed?" >> results.txt
xmllint --noout survey.xml >> results.txt  2>&1
echo "valid?" >> results.txt
xmllint --noout --valid survey.xml >> results.txt  2>&1

echo "" >> results.txt
echo "--- responses.xml ---" >> results.txt
echo "well-formed?" >> results.txt
xmllint --noout responses.xml >> results.txt  2>&1
echo "valid?" >> results.txt
xmllint --noout --valid responses.xml >> results.txt  2>&1

echo "" >> results.txt
echo "--- division.xml ---" >> results.txt
echo "well-formed?" >> results.txt
xmllint --noout division.xml >> results.txt  2>&1
echo "valid?" >> results.txt
xmllint --noout --valid division.xml >> results.txt  2>&1


echo "" >> results.txt
echo "======= Generating query output =======" >> results.txt

# The queries that we have no dtd for.
for query in q1 q2 q3 q4 q5
do
   echo "" >> results.txt
   echo "--- Query" $query "---" >> results.txt
   echo "" >> results.txt
   echo "Raw results:" >> results.txt
   galax-run $query.xq >> results.txt 2>&1
done

# The queries we can use xmllint to "pretty print" 
# (because we have a dtd).
for query in q6 q7 q8
do
   echo "" >> results.txt
   echo "--- Query" $query "---" >> results.txt
   echo "" >> results.txt
   echo "Raw results:" >> results.txt
   galax-run $query.xq >> results.txt  2>&1
   echo "<?xml version='1.0' standalone='no' ?>" > TEMP.xml
   galax-run $query.xq >> TEMP.xml  2>&1
   echo "" >> results.txt
   echo "Pretty results:" >> results.txt
   xmllint --format TEMP.xml >> results.txt  2>&1
done


echo "" >> results.txt
echo "======= Validating xml generated by queries =======" >> results.txt

echo "" >> results.txt
echo "--- Query" q6 "---" >> results.txt
echo "<?xml version='1.0' standalone='no' ?>" > TEMP.xml
echo "<!DOCTYPE Students SYSTEM 'years.dtd'>" >> TEMP.xml
galax-run q6.xq >> TEMP.xml  2>&1
echo "Results well-formed?" >> results.txt
xmllint --noout TEMP.xml >> results.txt  2>&1
echo "Results valid?" >> results.txt
xmllint --noout --valid TEMP.xml >> results.txt  2>&1

echo "" >> results.txt
echo "--- Query" q7 "---" >> results.txt
echo "<?xml version='1.0' standalone='no' ?>" > TEMP.xml
echo "<!DOCTYPE Histogram SYSTEM 'histogram.dtd'>" >> TEMP.xml
galax-run q7.xq >> TEMP.xml  2>&1
echo "Results well-formed?" >> results.txt
xmllint --noout TEMP.xml >> results.txt  2>&1
echo "Results valid?" >> results.txt
xmllint --noout --valid TEMP.xml >> results.txt  2>&1

echo "" >> results.txt
echo "--- Query" q8 "---" >> results.txt
echo "<?xml version='1.0' standalone='no' ?>" > TEMP.xml
echo "<!DOCTYPE Availability SYSTEM 'availability.dtd'>" >> TEMP.xml
galax-run q8.xq >> TEMP.xml  2>&1
echo "Results well-formed?" >> results.txt
xmllint --noout TEMP.xml >> results.txt  2>&1
echo "Results valid?" >> results.txt
xmllint --noout --valid TEMP.xml >> results.txt  2>&1
