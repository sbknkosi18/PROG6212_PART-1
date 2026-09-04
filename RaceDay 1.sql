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