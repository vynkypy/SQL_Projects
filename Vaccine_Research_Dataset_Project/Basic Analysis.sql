-- List all patients along with their enrollment date and gender.
select Name, Gender, EnrollmentDate from Patients;

-- Count the total number of visits for each patient.
select p.Name, COUNT(v.visitID)as Total_Visits from Visits v
join Patients p on p.PatientID = v.PatientID
group by p.Name, v.PatientID;

-- Find all patients who have taken a 'Dose 1' visit.
select p.Name, v.visittype from Patients p
join Visits v on p.PatientID = v.PatientID
where VisitType = 'Dose 1';

-- Show the average antibody level for each type of visit.
select v.visittype , AVG(l.ResultValue) Avg_antibody_level from LabResults l
join Visits v on v.VisitID = l.VisitID 
group by v.VisitType;

-- Find the maximum antibody level recorded and the patient name associated with it

select p.Name, V.visittype, l.resultvalue from
(
select VisitID, resultvalue,
rank() over (order by resultvalue desc) as max_antibody_level 
from LabResults
) t
join LabResults l on t.visitID = l.VisitID
join Visits v on v.VisitID = l.VisitID
join Patients p on p.PatientID = v.PatientID
where max_antibody_level = 1;

