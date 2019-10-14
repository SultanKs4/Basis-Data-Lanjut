-- Drop the database 'MovieRental'
-- Connect to the 'master' database to run this snippet
USE master
GO

-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
-- ALTER DATABASE MovieRental SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
  SELECT [name]
FROM sys.databases
WHERE [name] = N'MovieRental'
)
DROP DATABASE MovieRental
GO

-- Create a new database called 'MovieRental'
-- Connect to the 'master' database to run this snippet
USE master
GO

-- Create the new database if it does not exist already
IF NOT EXISTS (
  SELECT [name]
FROM sys.databases
WHERE [name] = N'MovieRental'
)
CREATE DATABASE MovieRental
GO

-- Connect Database

USE MovieRental;
GO

-- Create Schema
CREATE SCHEMA Mv
GO

CREATE SCHEMA HR
GO

CREATE SCHEMA Sales
GO

-- Create Table

CREATE TABLE Mv.Genre
(
  ID int IDENTITY NOT NULL,
  Name varchar(25) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Mv.MainActor
(
  ID int IDENTITY NOT NULL,
  First_Name varchar(255) NULL,
  Last_Name varchar(255) NULL,
  DoB date NULL,
  Debut date NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Sales.Customer
(
  ID int IDENTITY NOT NULL,
  First_Name varchar(255) NULL,
  Last_Name varchar(255) NULL,
  Email varchar(50) NULL,
  Address varchar(50) NULL,
  Create_Date datetime NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE HR.Store
(
  ID int IDENTITY NOT NULL,
  Name varchar(50) NOT NULL UNIQUE,
  Address varchar(50) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Sales.PaymentMethod
(
  ID int IDENTITY NOT NULL,
  Method varchar(50) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Mv.Film
(
  ID int IDENTITY NOT NULL,
  Title varchar(255) NULL,
  Description varchar(255) NULL,
  Release_Year int NULL,
  Duration int NULL,
  Language varchar(20) NULL,
  Rating float(10) NULL,
  GenreID int NOT NULL,
  MainActorID int NOT NULL,
  Replacement_Cost int NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Sales.Inventory
(
  ID int IDENTITY NOT NULL,
  FilmID int NOT NULL,
  Stock int NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE HR.Staff
(
  ID int IDENTITY NOT NULL,
  StoreID int NOT NULL,
  First_Name varchar(255) NULL,
  Last_Name varchar(255) NULL,
  Email varchar(50) NULL,
  Username varchar(16) NULL,
  Password varchar(40) NULL,
  Address varchar(50) NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE Sales.Rental
(
  ID int IDENTITY NOT NULL,
  StaffID int NOT NULL,
  CustomerID int NOT NULL,
  InventoryID int NOT NULL,
  PaymentMethodID int NOT NULL,
  Rental_Date date NULL,
  Return_Date date NULL,
  Amount int NULL,
  PRIMARY KEY (ID)
);

-- Create Relation Foreign Key

ALTER TABLE Mv.Film ADD CONSTRAINT FKFilm760983 FOREIGN KEY (GenreID) REFERENCES Mv.Genre (ID);
ALTER TABLE Mv.Film ADD CONSTRAINT FKFilm143446 FOREIGN KEY (MainActorID) REFERENCES Mv.MainActor (ID);
ALTER TABLE Sales.Inventory ADD CONSTRAINT FKInventory897443 FOREIGN KEY (FilmID) REFERENCES Mv.Film (ID);
ALTER TABLE HR.Staff ADD CONSTRAINT FKStaff192835 FOREIGN KEY (StoreID) REFERENCES HR.Store (ID);
ALTER TABLE Sales.Rental ADD CONSTRAINT FKRental408601 FOREIGN KEY (StaffID) REFERENCES HR.Staff (ID);
ALTER TABLE Sales.Rental ADD CONSTRAINT FKRental331820 FOREIGN KEY (InventoryID) REFERENCES Sales.Inventory (ID);
ALTER TABLE Sales.Rental ADD CONSTRAINT FKRental608585 FOREIGN KEY (CustomerID) REFERENCES Sales.Customer (ID);
ALTER TABLE Sales.Rental ADD CONSTRAINT FKRental509879 FOREIGN KEY (PaymentMethodID) REFERENCES Sales.PaymentMethod (ID);


-- Insert Dummy Data

-- Insert Table Store

INSERT INTO MovieRental.HR.Store
  (Name,Address)
VALUES
  ('CabangDieng', 'Jalan Branjangan')
,
  ('Kantor Utama Suhat', 'Jalan.SoekarnoHatta')
,
  ('Moviemaxx', 'Jalan.kawi no7')
,
  ('IndoXX1', 'Jalan.bandung.no6')
,
  ('Cinemax', 'Jalan.bandung.no14')
,
  ('Movierextsal', 'Jalan.Saxophone')
,
  ('Iconmalang', 'Jalan.Branjangan')
,
  ('Kuynonton', 'Jalan.straat.no5')
,
  ('Qnema', 'Jalan.Wirosentanan')
,
  ('Xorcinema', 'Jalan.Semeru.no7');

-- Insert Staff

INSERT INTO MovieRental.HR.Staff
  (StoreID,First_Name,Last_Name,Email,Username,Password,Address)
VALUES
  (1, 'Tri ', 'Fuad', 'trifuad@gmail.com', 'fuad2331', 'Fuad12Tri11', 'Jalan Pakissaji')
,
  (2, 'Reza', 'Febriansyah', 'reza23@gmail,com', 'brian23', 'Reza0115', 'Jalan.TerusanBatu')
,
  (3, 'Adie', 'Bagus', 'adiebagus14@gmail.com', 'bgustamvan', 'adie112345', 'Jalan.Bogor')
,
  (4, 'Fima', 'Zidan', 'fmazdn44@gmail.com', 'fma.haa', 'FimaZidan89', 'Jalan.Blitarkawi')
,
  (5, 'Andhika', 'Utama', 'BliBli@gmail.com', 'Blidhika', 'dhikadc34', 'Jalan.Balinesia')
,
  (6, 'Ahmad', 'Bahrul', 'Bahrululum@gmail.com', 'ulumactkids', 'ulumnaghkeren', 'Jalan.Pakisaji')
,
  (7, 'Ardyansyah', 'Vira', 'virabahrudin@gmail.com', 'vira0114', 'adryvira234', 'Jalan.TerusanBatu')
,
  (8, 'Mochamad', 'Fariz', 'linanoobs@gmail.com', 'w33.haa', 'w33haa14', 'Jalan.Bandung')
,
  (9, 'Hanaan', 'Aulia', 'hananaulia@gmail.com', 'Strongee', 'Hanaan13', 'Jalan.JakartaTimur')
,
  (10, 'Bagas', 'Ipung', 'Bagas31@gmail.com', 'BagasIpung', 'Ipung01145', 'Jalan.Blitarkawi')
,
  (1, 'Icha', NULL, NULL, 'ichasan', '123h3h3', NULL);

-- Insert Customer

INSERT INTO MovieRental.Sales.Customer
  (First_Name,Last_Name,Email,Address,Create_Date)
VALUES
  ('Bening', 'Sukma', 'beningsukma@gmail.com', 'Jalan.Bogor', '2018-12-04 15:44:15.000')
,
  ('Yovita', 'Fara', 'yovitafara@gmail.com', 'Jalan.SemeruTimur', '2018-12-04 16:00:00.000')
,
  ('Sultan', 'Ahmad', 'sultanahmad', 'Jalan.Blitar', '2019-11-07 17:43:00.000')
,
  ('Dimahyanti', 'Dwiningsih', 'nining@gmail.com', 'Jalan.SemanggiTimur', '2018-04-04 09:24:00.000')
,
  ('Muhammad', 'Arifin', 'muhammadarifin', 'Jalan.Bogor', '2017-12-08 07:13:20.000')
,
  ('Johan', 'Sunsteind', 'johansundstein@gmail.com', 'Jalan.Bandung', '2019-03-28 22:00:00.000')
,
  ('Anathan', 'Pham', 'anathanpham@gmail.com', 'Jalan.Bandung', '2019-03-28 12:00:00.000')
,
  ('Andri', 'Yoga', 'andriyss@gmail.com', 'Jalan.SemanggiBarat', '2018-09-11 13:45:00.000')
,
  ('Febtri', 'Anitari', 'febtrianitari@gmail.com', 'Jalan.Arjuna', '2018-07-11 06:00:12.000')
,
  ('Isa', 'Sarasvati', 'isabelidong@gmail.com', 'Jalan.PuloGadung', '2017-11-03 23:14:10.000')
,
  ('Santi', NULL, NULL, 'Jalan.Perusahaan', '2019-10-13 19:34:10.327');

-- Insert Genre

INSERT INTO MovieRental.Mv.Genre
  (Name)
VALUES
  ('Horror')
,
  ('Action')
,
  ('Adventure')
,
  ('Fiction')
,
  ('Romance')
,
  ('Drama')
,
  ('Comedy')
,
  ('Sci-Fi')
,
  ('Thriller')
,
  ('Documentary');

-- Insert MainActor

INSERT INTO MovieRental.Mv.MainActor
  (First_Name,Last_Name,DoB,Debut)
VALUES
  ('Joaquin', 'Phoenix', '1974-10-28', '1986-01-01')
,
  ('Leigh', 'Whannell', '1977-01-17', '2003-01-01')
,
  ('Tom ', 'Holland', '1996-06-01', '2012-01-01')
,
  ('Iqbaal', 'Ramadhan', '1999-12-28', '2011-01-01')
,
  ('Daniel', 'Radcliffe', '1989-07-23', '1999-01-01')
,
  ('Raditya', 'Dika', '1984-12-28', '2013-01-01')
,
  ('Harrison', 'Ford', '1942-07-13', '1979-01-01')
,
  ('Song', 'Jong-Ki', '1985-09-19', '2008-01-01')
,
  ('Crhis', 'Evan', '1981-06-13', '2000-01-01')
,
  ('Madison', 'Iseman', '1997-02-14', '2015-01-01')
,
  ('Jennifer', 'Lopez', '1969-07-24', NULL);

-- Insert Payment Method

INSERT INTO MovieRental.Sales.PaymentMethod
  ([Method])
VALUES
  ('OVO')
,
  ('Go Pay')
,
  ('Cash')
,
  ('Credit Card')
,
  ('Lawson')
,
  ('Virtual Account')
,
  ('Debit Card')
,
  ('Link Aja')
,
  ('OVO Paylater')
,
  ('DANA');

-- Insert Film

INSERT INTO MovieRental.Mv.Film
  (Title,Description,Release_Year,Duration,[Language],Rating,GenreID,MainActorID,Replacement_Cost)
VALUES
  ('Joker2019', 'Joker adalah film cerita psikologis yang disutradarai oleh Todd', 2019, 2, 'English', 9, 2, 1, 350000)
,
  ('Insidious Last Key', 'Parapskiolog Elise Rainer yang sudah pensiun sejak perristiwa mengerikan di Insidious3 kembali berurusan dengan iblis jahat', 2018, 2, 'English ', 8, 1, 2, 380000)
,
  ('Spiderman:Far From Home', 'Peter Parker tengah mengunjungi Eropa bersama teman temannya sayangnya syangnya Nick Fury meminta Parker Untuk menghadapi musuh', 2019, 2, 'English', 8, 2, 3, 240000)
,
  ('Dilan 1991', 'Kisah cinta Dilan dan Milea akan Kembali berlanjut di film Dilan 1991 mampukah cinta mereka bertahan?', 2019, 2, 'Indonesia', 7, 5, 4, 230000)
,
  ('Harry Potter', 'Harry Potter and the death Hallows adalah film fantasy daptasi dari novel J.K Rowling', 2011, 2, 'English', 8, 4, 5, 230000)
,
  ('Marmut Merah jambu', 'Film ini diangkat dari novel Karya Raditya Dika yang berjudul Marmut merah Jambu', 2014, 2, 'Indonesia', 7, 7, 6, 200000)
,
  ('Indiana Jones', 'Film yang disutradarai oleh Steven Stilberg yang dirislis tahun 2008', 2008, 2, 'English', 7, 3, 7, 150000)
,
  ('Descendants Of The Sun', 'Bercerita tentang kisah cinta antara comandan dan seorang doketr', 2016, 2, 'Korea', 8, 6, 8, 200000)
,
  ('AvangerEndGame', 'Lanjutan dari infinity war dimana thano berhasil mendapatkan infinity stones dan berhasil memusnakan separuh dari populasi alam semesta ', 2019, 3, 'English', 10, 2, 9, 400000)
,
  ('Anabelle come home', 'Annabelle kembali dengan membangunkan roh roh jahat yang ada di ruangan yang khusus', 2019, 2, 'English', 8, 1, 10, 200000)
,
  ('Anaconda', NULL, NULL, 2, 'English', NULL, 1, 11, 420000);

-- Insert Inventory

INSERT INTO MovieRental.Sales.Inventory
  (FilmID,Stock)
VALUES
  (1, 23)
,
  (2, 15)
,
  (3, 12)
,
  (4, 17)
,
  (5, 9)
,
  (6, 10)
,
  (7, 6)
,
  (8, 4)
,
  (9, 7)
,
  (10, 11);

-- Insert Rental

INSERT INTO MovieRental.Sales.Rental
  (StaffID,CustomerID,InventoryID,PaymentMethodID,Rental_Date,Return_Date,Amount)
VALUES
  (1, 1, 1, 1, '2019-10-09', '2019-11-09', 1000000)
,
  (2, 2, 2, 2, '2019-09-10', '2019-10-10', 500000)
,
  (3, 3, 3, 3, '2019-08-09', '2019-09-09', 750000)
,
  (4, 4, 4, 4, '2019-07-08', '2019-08-08', 200000)
,
  (5, 5, 5, 5, '2019-06-07', '2019-07-07', 150000)
,
  (6, 6, 6, 6, '2019-05-06', '2019-06-06', 300000)
,
  (7, 7, 7, 7, '2019-04-05', '2019-05-05', 500000)
,
  (8, 8, 8, 8, '2019-03-04', '2019-04-04', 120000)
,
  (9, 9, 9, 9, '2019-02-03', '2019-03-03', 420000)
,
  (10, 10, 10, 10, '2019-01-02', '2019-02-02', 360000)
,
  (9, 3, 2, 3, '2018-01-02', '2018-01-15', 69000)
,
  (8, 4, 3, 1, '2018-12-24', '2019-01-11', 35000)
,
  (7, 6, 9, 5, '2018-06-20', '2018-07-10', 120000)
,
  (6, 5, 8, 2, '2018-10-11', '2018-10-30', 50000)
,
  (5, 8, 7, 7, '2018-04-02', '2018-04-27', 62000)
,
  (4, 9, 6, 6, '2018-09-11', '2018-09-30', 75000)
,
  (3, 10, 5, 9, '2018-09-15', '2018-09-20', 48000)
,
  (2, 1, 1, 10, '2018-03-05', '2018-03-28', 81000)
,
  (1, 2, 4, 4, '2018-02-20', '2018-03-25', 240000)
,
  (8, 4, 10, 8, '2018-11-08', '2018-11-30', 69000)
,
  (11, 11, 8, 3, '2019-10-13', NULL, NULL);

-- Delete Record Primary key 
-- DBCC CHECKIDENT ([Sales.Rental], RESEED, 20);

-- Alter column
-- EXEC sp_rename 'Mv.Film."[Duration(hrs)]"' , 'Duration', 'COLUMN';


