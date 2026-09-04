Use RaceDayDB;

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