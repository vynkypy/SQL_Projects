--Find the average time (in days) between Dose 1 and Follow-up visits for each patient.
with date_of_dose1 as
(
select patientID, VisitID, visittype, VisitDate from Visits
where VisitType = 'Dose 1'
)

,date_of_follow_ups as
(
select patientID, VisitID,visittype, VisitDate from Visits
where VisitType = 'Follow-up'
) 
select dd.patientID, DATEDIFF(day, dd.visitdate, df.visitdate) Days_between_Dose_and_Follow_Up from date_of_dose1 dd join 
date_of_follow_ups df on dd.PatientID = df.PatientID;

--Show the top 3 patients with the highest final (Follow-up) antibody levels.
select * from
(
select p.Name, v.patientID, v.VisitType, l.ResultValue,
rank() over(order by l.ResultValue desc) as HighestValue
from Visits v join LabResults l on v.VisitID = l.VisitID
join Patients p on v.PatientID = p.PatientID
where v.VisitType = 'Follow-up'
) t where t.HighestValue <= 3;

--List patients who do not have a follow-up visit.
select p.PatientID, p.Name, v.VisitType from Patients p
join Visits v on v.PatientID = p.PatientID
where v.VisitType != 'Follow-up';

--Show a monthly count of new enrollments.
select DateName(MONTH, enrollmentDate) Month, count(patientid) TotalPatients from Patients
group by DateName(MONTH, enrollmentDate);

--For each patient, show the change in antibody level from Dose 1 to Follow-up (if both exists)
/*
select Name, VisitType, (ResultValue -LagValue) AntiBody_Level_Change from
(
select p.Name, v.VisitType, l.ResultValue,
lag(l.ResultValue) over(order by p.Name) LagValue
from patients p join Visits v on p.PatientID = v.PatientID
join LabResults l on v.VisitID = l.VisitID
where v.VisitType = 'Dose 1' or v.VisitType = 'Follow-up'
) t
where VisitType = 'Follow-Up';
*/

SELECT p.PatientID, p.Name, 
       MAX(CASE WHEN VisitType = 'Dose 1' THEN ResultValue END) AS Dose1,
       MAX(CASE WHEN VisitType = 'Follow-up' THEN ResultValue END) AS FollowUp,
       MAX(CASE WHEN VisitType = 'Follow-up' THEN ResultValue END) -
       MAX(CASE WHEN VisitType = 'Dose 1' THEN ResultValue END) AS Antibody_Change
FROM Patients p
JOIN Visits v ON p.PatientID = v.PatientID
JOIN LabResults l ON v.VisitID = l.VisitID
WHERE VisitType IN ('Dose 1', 'Follow-up')
GROUP BY p.PatientID, Name
HAVING COUNT(DISTINCT VisitType) = 2;

