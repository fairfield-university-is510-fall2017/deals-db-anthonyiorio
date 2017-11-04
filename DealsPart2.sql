# Created by Anthony Iorio, 11/4/2017, with the help of Dr. Chris Huntley.
# The purpose of this exercise is to write SQL select queries, and debug them.
# The purpose of this script is to simplify data analysis by relating the different tables to each other, and using various SQL functions to perform mathematical operations on the data.

# Indicate that we are using the deals database
USE deals;  
# Execute a test query  
SELECT *
FROM Companies
WHERE CompanyName like "%Inc.";
# Select companies sorted by CompanyName
SELECT *
FROM Companies
ORDER BY CompanyID;
# Select Deal Parts with dollar values
SELECT DealName, PartNumber, DollarValue
FROM Deals,DealParts
WHERE Deals.DealID = DealParts.DealID;
# Select Deal Parts with dollar values using a join
SELECT DealName, PartNumber, DollarValue
FROM Deals join DealParts on (Deals.DealID=DealParts.DealID);
# Show each company involved in each deal.
SELECT DealName, RoleCode, CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
    JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;
# Create a view that matches companies to deals
DROP VIEW IF EXISTS `CompanyDeals`;
CREATE View CompanyDeals AS
SELECT DealName,RoleCode,CompanyName
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;
# A test of the CompanyDeals view
SELECT * FROM CompanyDeals;
# 9. Create a view named DealValues
DROP VIEW IF EXISTS `DealValues`;
CREATE VIEW DealValues AS
SELECT DEALS.DealID, SUM(DollarValue) AS TotDollarValue, COUNT(PartNumber) AS NumParts
FROM DEALS JOIN DEALPARTS ON (DEALS.DealID = DEALPARTS.DealID)
GROUP BY DEALS.DealID
ORDER BY DEALS.DealID;

SELECT * from DealValues;
# 10. Create a view named DealSummary
DROP VIEW IF EXISTS `DealSummary`;
CREATE VIEW DealSummary AS
SELECT DEALS.DealID, DealName, COUNT(PlayerID) AS NumPlayers, TotDollarValue, NumParts
FROM DEALS JOIN DealValues ON (DEALS.DealID = DealValues.DealID)
	JOIN Players ON (DEALS.DealID = Players.DealID)
GROUP BY Deals.DealID;

# 11. Create a view called DealsByType
DROP VIEW IF EXISTS `DealsByType`;
CREATE VIEW DealsByType AS
SELECT DISTINCT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM DealTypes
	LEFT JOIN Deals ON (DealTypes.DealID = Deals.DealID)
    JOIN DealParts ON (DealParts.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode; 

# 12. Create a view called DealPlayers
DROP VIEW IF EXISTS `DealPlayers`;
CREATE VIEW DealPlayers AS
SELECT DealID, CompanyID, CompanyName, RoleCode
FROM Players
	JOIN Deals USING (DealID)
	JOIN COMPANIES USING (CompanyID)
    JOIN ROLECODES USING (RoleCode)
ORDER BY RoleSortOrder;

# 13. Create a view called DealsByFirm
SELECT FirmID, `Name` AS FirmName, COUNT(PLAYERS.DealID) AS NumDeals, SUM(TotDollarValue) AS TotValue
FROM FIRMS
	JOIN PLAYERSUPPORTS USING (FirmID)
    JOIN PLAYERS USING (PlayerID)
    JOIN DealValues USING (DealID)
GROUP BY FirmID, `Name`;