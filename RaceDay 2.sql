USE RaceDayDB;

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

