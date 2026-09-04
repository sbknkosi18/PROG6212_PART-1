USE RaceDayDB;

CREATE TABLE Users
(Id INT PRIMARY KEY IDENTITY(1,1),
 Username VARCHAR(50) NOT NULL UNIQUE,
 Email VARCHAR(100) NOT NULL UNIQUE,
 PasswordHash VARCHAR(255) NOT NULL,
 Role VARCHAR(20) NOT NULL CHECK (Role IN ('Organiser', 'Participant')),
 FullName VARCHAR(100) NOT NULL,
 PhoneNumber VARCHAR(20) NULL,
 DateOfBirth DATE NULL,
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 UpdatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 IsActive BIT DEFAULT 1 NOT NULL);

 CREATE TABLE Events
(Id INT PRIMARY KEY IDENTITY(1,1),
 OrganiserId INT NOT NULL,
 Name VARCHAR(100) NOT NULL,
 Description VARCHAR(500) NULL,
 EventDate DATE NOT NULL,
 EventTime TIME NOT NULL,
 Location VARCHAR(200) NOT NULL,
 Address VARCHAR(300) NULL,
 MaxParticipants INT NOT NULL DEFAULT 100,
 RegistrationDeadline DATE NOT NULL,
 EventType VARCHAR(30) NOT NULL CHECK (EventType IN ('Running', 'Walking', 'Cycling', 'Triathlon')),
 Status VARCHAR(20) DEFAULT 'Upcoming' CHECK (Status IN ('Upcoming', 'Ongoing', 'Completed', 'Cancelled')),
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 UpdatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 IsPublished BIT DEFAULT 0 NOT NULL,
 CONSTRAINT FK_Events_Organiser FOREIGN KEY (OrganiserId) REFERENCES Users(Id) ON DELETE CASCADE);

 CREATE TABLE Categories
(Id INT PRIMARY KEY IDENTITY(1,1),
 EventId INT NOT NULL,
 Name VARCHAR(50) NOT NULL,
 Description VARCHAR(200) NULL,
 Distance DECIMAL(5,2) NOT NULL,
 DistanceUnit VARCHAR(10) DEFAULT 'km' NOT NULL,
 Fee DECIMAL(10,2) NOT NULL DEFAULT 0,
 MaxEntries INT NOT NULL DEFAULT 50,
 CurrentEntries INT DEFAULT 0 NOT NULL,
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 UpdatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 CONSTRAINT FK_Categories_Event FOREIGN KEY (EventId) REFERENCES Events(Id) ON DELETE CASCADE,
 CONSTRAINT CHK_MaxEntries CHECK (CurrentEntries <= MaxEntries));

CREATE TABLE Enrolments
(Id INT PRIMARY KEY IDENTITY(1,1),
 ParticipantId INT NOT NULL,
 CategoryId INT NOT NULL,
 EnrolmentDate DATETIME DEFAULT GETDATE() NOT NULL,
 Status VARCHAR(20) DEFAULT 'Confirmed' CHECK (Status IN ('Confirmed', 'Cancelled', 'Completed', 'Withdrawn')),
 PaymentStatus VARCHAR(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Pending', 'Paid', 'Refunded')),
 PaymentDate DATETIME NULL,
 Notes VARCHAR(200) NULL,
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 UpdatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 CONSTRAINT FK_Enrolments_Participant FOREIGN KEY (ParticipantId) REFERENCES Users(Id) ON DELETE CASCADE,
 CONSTRAINT FK_Enrolments_Category FOREIGN KEY (CategoryId) REFERENCES Categories(Id) ON DELETE NO ACTION,
 CONSTRAINT UQ_Enrolment_Unique UNIQUE (ParticipantId, CategoryId));

 CREATE TABLE Results
(Id INT PRIMARY KEY IDENTITY(1,1),
 EnrolmentId INT NOT NULL,
 FinishTime TIME NULL,
 FinishDateTime DATETIME NULL,
 Position INT NULL,
 RaceNumber VARCHAR(20) NULL,
 Disqualified BIT DEFAULT 0 NOT NULL,
 DisqualificationReason VARCHAR(200) NULL,
 OfficialTime TIME NULL,
 GunTime TIME NULL,
 ChipTime TIME NULL,
 Notes VARCHAR(200) NULL,
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 UpdatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 CONSTRAINT FK_Results_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(Id) ON DELETE NO ACTION,
 CONSTRAINT UQ_Result_Enrolment UNIQUE (EnrolmentId));

 CREATE TABLE AuditLog
(Id INT PRIMARY KEY IDENTITY(1,1),
 UserId INT NULL,
 Action VARCHAR(50) NOT NULL,
 TableName VARCHAR(50) NOT NULL,
 RecordId INT NULL,
 OldValues VARCHAR(MAX) NULL,
 NewValues VARCHAR(MAX) NULL,
 IPAddress VARCHAR(50) NULL,
 CreatedAt DATETIME DEFAULT GETDATE() NOT NULL,
 CONSTRAINT FK_AuditLog_User FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE SET NULL);

INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
VALUES ('organiser1', 'organiser1@raceday.co.za', 'hashed_password_1', 'Organiser', 'Thabo Mokoena', '+27 82 123 4567', '1985-03-15', GETDATE(), GETDATE(), 1),
       ('organiser2', 'organiser2@raceday.co.za', 'hashed_password_2', 'Organiser', 'Sarah van der Merwe', '+27 72 987 6543', '1990-07-22', GETDATE(), GETDATE(), 1);

       IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'organiser1@raceday.co.za')
BEGIN
    INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
    VALUES ('organiser1', 'organiser1@raceday.co.za', 'hashed_password_1', 'Organiser', 'Thabo Mokoena', '+27 82 123 4567', '1985-03-15', GETDATE(), GETDATE(), 1);
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'organiser2@raceday.co.za')
BEGIN
    INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
    VALUES ('organiser2', 'organiser2@raceday.co.za', 'hashed_password_2', 'Organiser', 'Sarah van der Merwe', '+27 72 987 6543', '1990-07-22', GETDATE(), GETDATE(), 1);
END

SELECT * FROM Users;

INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
VALUES ('runner1', 'runner1@gmail.com', 'hashed_password_3', 'Participant', 'James Nkosi', '+27 63 456 7890', '1995-11-02', GETDATE(), GETDATE(), 1),
       ('runner2', 'runner2@gmail.com', 'hashed_password_4', 'Participant', 'Lindiwe Zulu', '+27 74 789 0123', '1998-05-18', GETDATE(), GETDATE(), 1);

       IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'runner1@gmail.com')
BEGIN
    INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
    VALUES ('runner1', 'runner1@gmail.com', 'hashed_password_3', 'Participant', 'James Nkosi', '+27 63 456 7890', '1995-11-02', GETDATE(), GETDATE(), 1);
END

IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'runner2@gmail.com')
BEGIN
    INSERT INTO Users (Username, Email, PasswordHash, Role, FullName, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, IsActive)
    VALUES ('runner2', 'runner2@gmail.com', 'hashed_password_4', 'Participant', 'Lindiwe Zulu', '+27 74 789 0123', '1998-05-18', GETDATE(), GETDATE(), 1);
END

SELECT * FROM Users;

INSERT INTO Events (OrganiserId, Name, Description, EventDate, EventTime, Location, Address, MaxParticipants, RegistrationDeadline, EventType, Status, CreatedAt, UpdatedAt, IsPublished)
VALUES (1, 'Cape Town Cycle Tour', 'The largest timed cycle race in the world, a 109km route around the Cape Peninsula.', '2026-03-08', '06:00:00', 'Cape Town, Western Cape', 'Cape Town Stadium, Cape Town', 35000, '2026-02-20', 'Cycling', 'Upcoming', GETDATE(), GETDATE(), 1),
       (2, 'Soweto Marathon', 'A challenging 42.2km marathon through the streets of Soweto.', '2026-11-02', '05:30:00', 'Soweto, Gauteng', 'FNB Stadium, Soweto', 25000, '2026-10-15', 'Running', 'Upcoming', GETDATE(), GETDATE(), 1),
       (1, 'Two Oceans Marathon', 'A 56km ultra-marathon along the Cape Peninsula.', '2026-04-11', '05:30:00', 'Cape Town, Western Cape', 'UCT Rugby Fields, Cape Town', 15000, '2026-03-20', 'Running', 'Upcoming', GETDATE(), GETDATE(), 1);
	
SELECT * FROM Events;

INSERT INTO Categories (EventId, Name, Description, Distance, Fee, MaxEntries, CurrentEntries, CreatedAt, UpdatedAt)
VALUES (1, 'Elite Men', 'Professional category for elite male cyclists', 109.00, 850.00, 500, 320, GETDATE(), GETDATE()),
       (1, 'Elite Women', 'Professional category for elite female cyclists', 109.00, 850.00, 300, 180, GETDATE(), GETDATE()),
       (1, 'Amateur Men', 'For recreational male cyclists', 109.00, 650.00, 5000, 4800, GETDATE(), GETDATE()),
       (1, 'Amateur Women', 'For recreational female cyclists', 109.00, 650.00, 3000, 2900, GETDATE(), GETDATE());

SELECT * FROM Categories;

INSERT INTO Categories (EventId, Name, Description, Distance, Fee, MaxEntries, CurrentEntries, CreatedAt, UpdatedAt)
VALUES (2, 'Full Marathon', '42.2km standard marathon', 42.20, 400.00, 5000, 4800, GETDATE(), GETDATE()),
       (2, 'Half Marathon', '21.1km half marathon', 21.10, 250.00, 8000, 6500, GETDATE(), GETDATE()),
       (2, '10km Challenge', '10km fun run', 10.00, 150.00, 12000, 11000, GETDATE(), GETDATE());

SELECT * FROM Categories;

INSERT INTO Categories (EventId, Name, Description, Distance, Fee, MaxEntries, CurrentEntries, CreatedAt, UpdatedAt)
VALUES (3, 'Ultra Marathon', '56km ultra-marathon', 56.00, 800.00, 3000, 2800, GETDATE(), GETDATE()),
       (3, 'Half Marathon', '21.1km half marathon', 21.10, 350.00, 6000, 5500, GETDATE(), GETDATE()),
       (3, '10km Run', '10km fun run', 10.00, 200.00, 6000, 5800, GETDATE(), GETDATE());

SELECT * FROM Categories;

INSERT INTO Enrolments (ParticipantId, CategoryId, EnrolmentDate, Status, PaymentStatus, PaymentDate, Notes, CreatedAt, UpdatedAt)
VALUES (3, 5, DATEADD(DAY, -30, GETDATE()), 'Confirmed', 'Paid', DATEADD(DAY, -28, GETDATE()), 'Training for sub-4 hour', GETDATE(), GETDATE()),
       (3, 9, DATEADD(DAY, -20, GETDATE()), 'Confirmed', 'Paid', DATEADD(DAY, -18, GETDATE()), 'First ultra attempt', GETDATE(), GETDATE()),
       (4, 4, DATEADD(DAY, -45, GETDATE()), 'Confirmed', 'Paid', DATEADD(DAY, -43, GETDATE()), 'Excited for first cycle tour', GETDATE(), GETDATE()),
       (4, 10, DATEADD(DAY, -15, GETDATE()), 'Confirmed', 'Pending', NULL, 'Will pay next week', GETDATE(), GETDATE());

SELECT * FROM Enrolments;

INSERT INTO Results (EnrolmentId, FinishTime, FinishDateTime, Position, RaceNumber, OfficialTime, GunTime, ChipTime, CreatedAt, UpdatedAt)
VALUES (1, '03:55:30', DATEADD(DAY, -5, GETDATE()), 125, '125', '03:55:30', '03:56:10', '03:55:30', GETDATE(), GETDATE());

SELECT * FROM Results;






