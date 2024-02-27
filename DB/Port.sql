-- Database export via SQLPro (https://www.sqlprostudio.com/allapps.html)
-- Exported by tigranmzykyan at 27-02-2024 13:49.
-- WARNING: This file may contain descructive statements such as DROPs.
-- Please ensure that you are running the script at the proper location.


-- BEGIN TABLE Docks
DROP TABLE IF EXISTS Docks;
CREATE TABLE `Docks` (
  `DockID` int NOT NULL,
  `DockType` char(35) NOT NULL,
  `DockLength` int NOT NULL,
  `DockDepth` int NOT NULL,
  PRIMARY KEY (`DockID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 10 rows into Docks
-- Insert batch #1
INSERT INTO Docks (DockID, DockType, DockLength, DockDepth) VALUES
(301, 'Нефтяной', 180, 8),
(302, 'Грузовой', 250, 14),
(303, 'Зерновой', 200, 12),
(304, 'Рыболовный', 150, 6),
(305, 'Контейнерный', 300, 16),
(306, 'Пассажирский', 220, 10),
(307, 'Химический', 190, 9),
(308, 'Бункерный', 160, 7),
(309, 'Рефрижераторный', 210, 11),
(310, 'Судоремонтный', 270, 15);

-- END TABLE Docks

-- BEGIN TABLE EmployeeHoursReport
DROP TABLE IF EXISTS EmployeeHoursReport;
CREATE TABLE `EmployeeHoursReport` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `EmployeeName` varchar(255) DEFAULT NULL,
  `TotalHours` int DEFAULT NULL,
  `WorkDate` date DEFAULT NULL,
  PRIMARY KEY (`ReportID`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 5 rows into EmployeeHoursReport
-- Insert batch #1
INSERT INTO EmployeeHoursReport (ReportID, EmployeeID, EmployeeName, TotalHours, WorkDate) VALUES
(59, 101, 'Смирнов', 8, '2023-01-02'),
(60, 102, 'Ковалев', 6, '2023-01-03'),
(61, 103, 'Иванов', 10, '2023-01-04'),
(62, 105, 'Сидоров', 9, '2023-01-06'),
(63, 108, 'Морозов', 10, '2023-01-09');

-- END TABLE EmployeeHoursReport

-- BEGIN TABLE Employees
DROP TABLE IF EXISTS Employees;
CREATE TABLE `Employees` (
  `EmployeeID` int NOT NULL,
  `LastName` char(35) NOT NULL,
  `Profession` char(35) NOT NULL,
  `DateOfBirth` date NOT NULL,
  `Address` char(35) NOT NULL,
  `HireDate` date NOT NULL,
  `DismissalDate` date DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 10 rows into Employees
-- Insert batch #1
INSERT INTO Employees (EmployeeID, LastName, Profession, DateOfBirth, Address, HireDate, DismissalDate) VALUES
(101, 'Смирнов', 'Крановщик', '1982-08-20', 'ул. Портовая, 5', '2015-03-12', NULL),
(102, 'Ковалев', 'Электрик', '1990-05-03', 'ул. Морская, 10', '2019-11-08', NULL),
(103, 'Иванов', 'Капитан буксира', '1975-12-15', 'ул. Маяковского, 2', '2010-06-20', NULL),
(104, 'Петрова', 'Лоцман', '1988-02-28', 'ул. Приморская, 8', '2017-04-04', NULL),
(105, 'Сидоров', 'Стропальщик', '1995-07-10', 'ул. Лесная, 15', '2021-09-14', NULL),
(106, 'Козлов', 'Механик', '1987-09-03', 'ул. Заводская, 7', '2016-08-02', NULL),
(107, 'Николаев', 'Электромонтёр', '1993-11-18', 'ул. Солнечная, 12', '2020-12-01', NULL),
(108, 'Морозов', 'Оператор крана', '1984-04-25', 'ул. Речная, 3', '2018-02-10', NULL),
(109, 'Васнецов', 'Сварщик', '1991-06-30', 'ул. Космонавтов, 9', '2019-04-15', NULL),
(110, 'Лебедев', 'Инженер', '1980-01-12', 'ул. Лермонтова, 6', '2014-07-22', NULL);

-- END TABLE Employees

-- BEGIN TABLE external_user
DROP TABLE IF EXISTS external_user;
CREATE TABLE `external_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `login` char(35) NOT NULL,
  `password` char(35) NOT NULL,
  `group_name` char(35) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 1 row into external_user
-- Insert batch #1
INSERT INTO external_user (user_id, login, password, group_name) VALUES
(1, 'user', 'user', 'noname');

-- END TABLE external_user

-- BEGIN TABLE internal_user
DROP TABLE IF EXISTS internal_user;
CREATE TABLE `internal_user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `login` char(35) NOT NULL,
  `password` char(35) NOT NULL,
  `group_name` char(35) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 4 rows into internal_user
-- Insert batch #1
INSERT INTO internal_user (user_id, login, password, group_name) VALUES
(1, 'admin', 'admin', 'admin'),
(2, 'manager', 'manager', 'manager'),
(3, 'unload', 'unload', 'unload'),
(4, 'analyst', 'analyst', 'analyst');

-- END TABLE internal_user

-- BEGIN TABLE Registration
DROP TABLE IF EXISTS Registration;
CREATE TABLE `Registration` (
  `RegID` int NOT NULL,
  `ShipID` int NOT NULL,
  `ArrivalDate` date NOT NULL,
  `DepartureDate` date NOT NULL,
  `DockID` int NOT NULL,
  `EmployeeID` int NOT NULL,
  PRIMARY KEY (`RegID`),
  KEY `PortEntries_Employees_EmployeeID_fk` (`EmployeeID`),
  KEY `PortEntries_Docks_DockID_fk` (`DockID`),
  KEY `PortEntries_Ships_ShipID_fk` (`ShipID`),
  CONSTRAINT `PortEntries_Docks_DockID_fk` FOREIGN KEY (`DockID`) REFERENCES `Docks` (`DockID`),
  CONSTRAINT `PortEntries_Employees_EmployeeID_fk` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`),
  CONSTRAINT `PortEntries_Ships_ShipID_fk` FOREIGN KEY (`ShipID`) REFERENCES `Ships` (`ShipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 10 rows into Registration
-- Insert batch #1
INSERT INTO Registration (RegID, ShipID, ArrivalDate, DepartureDate, DockID, EmployeeID) VALUES
(501, 401, '2023-01-05', '2023-01-07', 301, 101),
(502, 402, '2023-01-08', '2023-01-10', 302, 102),
(503, 403, '2023-01-12', '2023-01-14', 305, 103),
(504, 404, '2023-01-16', '2023-01-18', 304, 104),
(505, 405, '2023-02-20', '2023-02-22', 306, 105),
(506, 406, '2023-02-25', '2023-02-28', 307, 106),
(507, 407, '2023-02-28', '2023-03-01', 308, 107),
(508, 408, '2023-03-03', '2023-04-06', 309, 108),
(509, 409, '2023-03-08', '2023-04-10', 310, 109),
(510, 410, '2023-03-12', '2023-04-15', 303, 110);

-- END TABLE Registration

-- BEGIN TABLE Ships
DROP TABLE IF EXISTS Ships;
CREATE TABLE `Ships` (
  `ShipID` int NOT NULL,
  `ShipName` char(35) NOT NULL,
  `ShipType` char(35) NOT NULL,
  `ShipTonnage` int NOT NULL,
  `HomePort` char(35) NOT NULL,
  PRIMARY KEY (`ShipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 10 rows into Ships
-- Insert batch #1
INSERT INTO Ships (ShipID, ShipName, ShipType, ShipTonnage, HomePort) VALUES
(401, 'Грузовик-1', 'Грузовой', 5000, 'Москва'),
(402, 'Нефтеперевозчик-2', 'Нефтеноситель', 8000, 'Санкт-Петербург'),
(403, 'Контейнеровоз-3', 'Контейнерный', 6500, 'Ростов-на-Дону'),
(404, 'Рыболов-4', 'Рыболовный', 2000, 'Мурманск'),
(405, 'Пассажир-5', 'Пассажирский', 3000, 'Сочи'),
(406, 'Химтanker-6', 'Химический', 7000, 'Краснодар'),
(407, 'Бункерщик-7', 'Бункерный', 1500, 'Новороссийск'),
(408, 'Рефрижератор-8', 'Рефрижераторный', 5500, 'Астрахань'),
(409, 'Судоремонтник-9', 'Судоремонтный', 9000, 'Владивосток'),
(410, 'Зерновоз-10', 'Зерновой', 6000, 'Севастополь');

-- END TABLE Ships

-- BEGIN TABLE Unload
DROP TABLE IF EXISTS Unload;
CREATE TABLE `Unload` (
  `UnloadID` int NOT NULL AUTO_INCREMENT,
  `WorkHours` int NOT NULL,
  `DateUnload` char(35) NOT NULL,
  `EmployeeID` int DEFAULT NULL,
  `RegID` int NOT NULL,
  PRIMARY KEY (`UnloadID`),
  KEY `Unload_Registation_RegID_fk` (`RegID`),
  CONSTRAINT `Unload_Registation_RegID_fk` FOREIGN KEY (`RegID`) REFERENCES `Registration` (`RegID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 13 rows into Unload
-- Insert batch #1
INSERT INTO Unload (UnloadID, WorkHours, DateUnload, EmployeeID, RegID) VALUES
(1, 5, '2023-12-14', 101, 501),
(3, 5, '2023-12-14', 102, 501),
(4, 15, '2003-12-01', 106, 501),
(5, 17, '2023-12-12', 101, 501),
(6, 17, '2023-12-12', 103, 501),
(7, 17, '2023-12-12', 105, 501),
(8, 7, '2023-12-14', 106, 501),
(9, 7, '2023-12-14', 103, 501),
(10, 7, '2023-12-14', 101, 501),
(12, 10, '2023-12-24', 101, 501),
(14, 7, '2024-01-15', 101, 501),
(15, 7, '2024-01-15', 102, 501),
(16, 7, '2024-01-15', 103, 501);

-- END TABLE Unload

-- BEGIN TABLE UnloadingReport
DROP TABLE IF EXISTS UnloadingReport;
CREATE TABLE `UnloadingReport` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `ShipName` varchar(255) DEFAULT NULL,
  `DockType` varchar(255) DEFAULT NULL,
  `WorkDate` date DEFAULT NULL,
  `WorkHours` int DEFAULT NULL,
  PRIMARY KEY (`ReportID`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 7 rows into UnloadingReport
-- Insert batch #1
INSERT INTO UnloadingReport (ReportID, ShipName, DockType, WorkDate, WorkHours) VALUES
(77, 'Грузовик-1', 'Нефтяной', '2023-01-02', 8),
(78, 'Нефтеперевозчик-2', 'Грузовой', '2023-01-03', 6),
(79, 'Контейнеровоз-3', 'Контейнерный', '2023-01-04', 10),
(80, 'Рыболов-4', 'Рыболовный', '2023-01-05', 7),
(81, 'Пассажир-5', 'Пассажирский', '2023-01-06', 9),
(82, 'Химтanker-6', 'Химический', '2023-01-07', 8),
(83, 'Бункерщик-7', 'Бункерный', '2023-01-08', 7);

-- END TABLE UnloadingReport

-- BEGIN TABLE WorkRecords
DROP TABLE IF EXISTS WorkRecords;
CREATE TABLE `WorkRecords` (
  `RecordID` int NOT NULL,
  `EmployeeID` int NOT NULL,
  `WorkDate` date NOT NULL,
  `WorkHours` int NOT NULL,
  PRIMARY KEY (`RecordID`),
  KEY `WorkRecords_Employees_EmployeeID_fk` (`EmployeeID`),
  CONSTRAINT `WorkRecords_Employees_EmployeeID_fk` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserting 10 rows into WorkRecords
-- Insert batch #1
INSERT INTO WorkRecords (RecordID, EmployeeID, WorkDate, WorkHours) VALUES
(201, 101, '2023-01-02', 8),
(202, 102, '2023-01-03', 6),
(203, 103, '2023-01-04', 10),
(204, 104, '2023-03-05', 7),
(205, 105, '2023-01-06', 9),
(206, 106, '2023-03-07', 8),
(207, 107, '2023-02-08', 7),
(208, 108, '2023-01-09', 10),
(209, 109, '2023-02-10', 6),
(210, 110, '2023-02-11', 8);

-- END TABLE WorkRecords

DELIMITER $$
DROP PROCEDURE IF EXISTS GenerateEmployeeHoursReport $$
CREATE PROCEDURE `GenerateEmployeeHoursReport`(IN year_ INT, IN month_ INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE employee_id INT;
  DECLARE employee_name VARCHAR(255);
  DECLARE total_hours INT;
  DECLARE work_date DATE;  -- Assuming WorkRecords.WorkDate is of type DATE

  DECLARE cur CURSOR FOR
  SELECT Employees.EmployeeID, Employees.LastName AS EmployeeName,
         SUM(WorkRecords.WorkHours) AS TotalHours, MAX(WorkRecords.WorkDate) AS WorkDate
  FROM Employees
  LEFT JOIN WorkRecords ON Employees.EmployeeID = WorkRecords.EmployeeID
  WHERE YEAR(WorkRecords.WorkDate) = year_ AND MONTH(WorkRecords.WorkDate) = month_
  GROUP BY Employees.EmployeeID, EmployeeName;

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;

  OPEN cur;

  mainloop: LOOP
    FETCH cur INTO employee_id, employee_name, total_hours, work_date;
    IF done THEN
      LEAVE mainloop;
    END IF;

    -- Inserting data into the report table (replace 'EmployeeHoursReport' with your actual report table name)
    INSERT INTO EmployeeHoursReport (EmployeeID, EmployeeName, TotalHours, WorkDate)
    VALUES (employee_id, employee_name, total_hours, work_date);

  END LOOP;

  CLOSE cur;
END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS GenerateUnloadingReport $$
CREATE PROCEDURE `GenerateUnloadingReport`(IN year_ INT, IN month_ INT)
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE ship_name VARCHAR(255);
  DECLARE dock_type VARCHAR(255);
  DECLARE work_date DATE;
  DECLARE work_hours INT;

  DECLARE cur CURSOR FOR
    SELECT Ships.ShipName, Docks.DockType, WorkRecords.WorkDate, WorkRecords.WorkHours
    FROM Ships
    JOIN Registration ON Ships.ShipID = Registration.ShipID
    JOIN Docks ON Registration.DockID = Docks.DockID
    JOIN WorkRecords ON Registration.EmployeeID = WorkRecords.EmployeeID
    WHERE YEAR(Registration.ArrivalDate) = year_ AND MONTH(Registration.ArrivalDate) = month_;

  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;

  OPEN cur;

  mainloop: LOOP
    FETCH cur INTO ship_name, dock_type, work_date, work_hours;
    IF done THEN
      LEAVE mainloop;
    END IF;

    -- Вставка данных в отчетную таблицу
    INSERT INTO UnloadingReport (ShipName, DockType, WorkDate, WorkHours)
    VALUES (ship_name, dock_type, work_date, work_hours);

  END LOOP;

  CLOSE cur;
END $$
DELIMITER ;

