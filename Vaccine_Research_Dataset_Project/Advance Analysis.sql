-- Show gender-wise average antibody levels across all visit types.

select v.VisitType, p.Gender, avg(l.ResultValue) as Avg_Antibody_Level
from Patients p join Visits v on v.PatientID = p.PatientID
join LabResults l on l.VisitID = v.VisitID
group by v.VisitType,  p.Gender

-- Identify patients who had less than a 10% increase in antibody level from Dose 1 to Follow-up.
SELECT 
    p.PatientID,
    p.Name,
    d1.ResultValue AS Dose1_Value,
    fu.ResultValue AS FollowUp_Value,
    ROUND(((fu.ResultValue - d1.ResultValue) / d1.ResultValue) * 100, 2) AS Percentage_Increase
FROM Patients p
JOIN Visits v1 ON p.PatientID = v1.PatientID AND v1.VisitType = 'Dose 1'
JOIN LabResults d1 ON v1.VisitID = d1.VisitID
JOIN Visits v2 ON p.PatientID = v2.PatientID AND v2.VisitType = 'Follow-up'
JOIN LabResults fu ON v2.VisitID = fu.VisitID
WHERE ((fu.ResultValue - d1.ResultValue) / d1.ResultValue) * 100 < 10;

-- Detect if any patient has more than one visit of the same type (data quality check).
SELECT 
    PatientID,
    VisitType,
    COUNT(*) AS VisitCount
FROM Visits
GROUP BY PatientID, VisitType
HAVING COUNT(*) > 1;

-- Rank patients based on total antibody improvement from Screening to Follow-up.
SELECT 
    p.PatientID,
    p.Name,
    s.ResultValue AS Screening_Value,
    f.ResultValue AS FollowUp_Value,
    (f.ResultValue - s.ResultValue) AS Improvement,
    RANK() OVER (ORDER BY (f.ResultValue - s.ResultValue) DESC) AS Rank_By_Improvement
FROM Patients p
JOIN Visits v1 ON p.PatientID = v1.PatientID AND v1.VisitType = 'Screening'
JOIN LabResults s ON v1.VisitID = s.VisitID
JOIN Visits v2 ON p.PatientID = v2.PatientID AND v2.VisitType = 'Follow-up'
JOIN LabResults f ON v2.VisitID = f.VisitID;

-- Create a pivot table showing average antibody levels per VisitType per gender.
