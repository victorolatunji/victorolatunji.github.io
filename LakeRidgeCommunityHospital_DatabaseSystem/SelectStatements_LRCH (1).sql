-- SELECT STATEMENTS – Examples of Data Usage in our Database Management System

/*Room Utilization
Show rooms with current patient count and current patient names.*/
SELECT s.SpaceID, r.RoomType, b.BedName,
       COUNT(h.HistoryID) AS CurrentPatients
FROM Space s
LEFT JOIN Room r ON s.RoomID = r.RoomID
LEFT JOIN Bed b ON s.BedID = b.BedID
LEFT JOIN History h ON s.SpaceID = h.SpaceID AND h.EndDate IS NULL
GROUP BY s.SpaceID, r.RoomType, b.BedName
ORDER BY s.SpaceID;



/* Overall Occupancy by Rooms */
SELECT s.SpaceID,
       CASE WHEN EXISTS(SELECT 1 FROM History h2 WHERE h2.SpaceID = s.SpaceID AND h2.EndDate IS NULL) THEN 1 ELSE 0 END AS OccupiedFlag
FROM Space s;



/* Revenue by Cost Centre (Revenue Analysis) */
SELECT cc.CostCentreID, cc.CostCentreName, COUNT(rv.RevenueID) AS NoOfTrans, SUM(rv.ChargeAmount) AS TotalCharges
FROM Revenue rv
LEFT JOIN Item i ON rv.ItemCode = i.ItemCode
LEFT JOIN CostCentre cc ON i.CostCentreID = cc.CostCentreID
GROUP BY cc.CostCentreID, cc.CostCentreName
ORDER BY TotalCharges DESC;



/* Patient Full Details (personal info, total bookings, total charges, history) */
SELECT p.PatientID, p.PatientName, p.Telephone, p.EmailAddress,
  (SELECT COUNT(*) FROM Booking b WHERE b.PatientID = p.PatientID) AS TotalBookings,
  (SELECT COUNT(*) FROM History h WHERE h.PatientID = p.PatientID) AS HistoryCount,
  (SELECT COALESCE(SUM(rv.ChargeAmount),0) FROM Revenue rv WHERE rv.PatientID = p.PatientID) AS TotalCharges
FROM Patient p
WHERE p.PatientID = 1;



/* Generate invoice from revenue rows (invoice creation check) */
SELECT rv.RevenueID, i.ItemName, rv.ChargeAmount, rv.FinancialSource
FROM Revenue rv
LEFT JOIN Item i ON rv.ItemCode = i.ItemCode
WHERE rv.PatientID = 1 AND CAST(rv.RevenueDate AS DATE) BETWEEN '2025-11-20' AND '2025-11-25';


