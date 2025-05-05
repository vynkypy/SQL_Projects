select * from labresults;

select * from patients;

select * from visits;

-- 1. What is the change in antibody level between each visit for a patient?
select p.name, v.visitdate, l.resultvalue,
lag(resultvalue) over(partition by p.name) as prev_value,
coalesce(l.resultvalue - (lag(resultvalue) over(partition by p.name)),0) as change_in_antibody
from patients p join visits v 
on p.PatientID = v.PatientID
join labresults l
using(visitid);


-- 2. What is the average antibody level per patient across visits?
select p.name, v.visitdate, l.resultvalue,
avg(l.ResultValue) over (partition by p.PatientID) as avg_result
from patients p join visits v 
on p.PatientID = v.PatientID
join labresults l
using(visitid);


-- 3. Which visit shows the highest antibody level per patient?
select NAME, ResultValue AS Highest_Antibody_Level from 
(select p.name, v.visitdate, l.resultvalue,
rank() over(partition by p.PatientID order by ResultValue desc) as high_level
from patients p join visits v 
on p.PatientID = v.PatientID
join labresults l 
on l.VisitID = v.VisitID) AS t
where high_level = 1;



