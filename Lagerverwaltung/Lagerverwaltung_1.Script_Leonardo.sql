-- * Projekt 'Lagerverwaltung' von Leonardo Loureiro * --
-- **************************** ERSTELLEN VON *********************************--
-- ********** TABELLEN, TRIGGER, VIEW, CONSTRAINTS, STORED PROCEDURE **********--
-- ****************************************************************************--

-- USER erstellen --
USE [Lagerverwaltung]
GO

CREATE LOGIN [TeamLeSa] WITH PASSWORD='Sale12', DEFAULT_DATABASE=[Lagerverwaltung], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

ALTER LOGIN [TeamLeSa] DISABLE
GO


-- ************************************** [Login]
CREATE TABLE [Login]
(
 [Login_ID]     int NOT NULL identity primary key,
 [Benutzername] varchar(100) NOT NULL ,
 [Passwort]     binary(100) NOT NULL ,
 [Salt]			binary (100) NULL default CRYPT_GEN_RANDOM(50),
 [Is_Active]    tinyint NOT NULL ,
 [Is_Deactive]  tinyint NOT NULL ,
 [Is_Archive]   tinyint NOT NULL ,


 --CONSTRAINT [PK_26] PRIMARY KEY CLUSTERED ([Login_ID] ASC)
);
GO


-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Ausgang]
CREATE TABLE [Ausgang]
(
 [Ausgang_ID]    int NOT NULL identity primary key ,
 [Ausgangsdatum] datetime NOT NULL ,



-- CONSTRAINT [PK_36] PRIMARY KEY CLUSTERED ([Ausgang_ID] ASC)
);
GO


-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Artikelgruppen]
CREATE TABLE [Artikelgruppen]
(
 [Artikelgruppen_ID] int NOT NULL identity primary key,
 [Artikelgruppen]    varchar(100) NOT NULL ,


 --CONSTRAINT [PK_45] PRIMARY KEY CLUSTERED ([Artikelgruppen_ID] ASC)
);
GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Marken]
CREATE TABLE [Marken]
(
 [Marken_ID] int NOT NULL identity primary key,
 [Marken]    varchar(100) NOT NULL ,


 --CONSTRAINT [PK_49] PRIMARY KEY CLUSTERED ([Marken_ID] ASC)
);
GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Eingang]
CREATE TABLE [Eingang]
(
 [Eingang_ID]    int NOT NULL identity primary key,
 [Eingangsdatum] datetime NOT NULL ,


 --CONSTRAINT [PK_73] PRIMARY KEY CLUSTERED ([Eingang_ID] ASC)
);
GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Lieferanten]
CREATE TABLE [Lieferanten]
(
 [Lieferanten_ID]  int NOT NULL identity primary key,
 [Lieferantenname] varchar(100) NOT NULL ,
 [Ansprechsperson] varchar(100) NOT NULL ,
 [Adresse]         varchar(100) NOT NULL ,
 [Hausnummer]      varchar(10) NOT NULL ,
 [PLZ]             int NOT NULL ,
 [Ortschaft]       varchar(100) NOT NULL ,
 [Telefonnummer]   int NOT NULL ,
 [E-Mail]		   varchar(100) NOT NULL ,


 --CONSTRAINT [PK_64] PRIMARY KEY CLUSTERED ([Lieferanten_ID] ASC)
);
GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Artikel]
CREATE TABLE [Artikel]
(
 [Artikel_ID]        int NOT NULL identity primary key,
 [Artikelname]		 varchar(100) NOT NULL,
 [Artikelnummer]     varchar(100) NOT NULL ,
 [Preis]             float NOT NULL ,
 [Artikelbestand]    int NOT NULL ,
 [Artikelgruppen_ID] int NOT NULL ,
 [Marken_ID]         int NOT NULL ,


 --CONSTRAINT [PK_53] PRIMARY KEY CLUSTERED ([Artikel_ID] ASC),
 CONSTRAINT [FK_Artikelgruppen_ID] FOREIGN KEY ([Artikelgruppen_ID])  REFERENCES [Artikelgruppen]([Artikelgruppen_ID]),
 CONSTRAINT [FK_Marken_ID] FOREIGN KEY ([Marken_ID])  REFERENCES [Marken]([Marken_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_93] ON [Artikel] 
 (
  [Artikelgruppen_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_96] ON [Artikel] 
 (
  [Marken_ID] ASC
 )

GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Lieferantenbestellungen]
CREATE TABLE [Lieferantenbestellungen]
(
 [LB_ID]          int NOT NULL identity primary key,
 [Produktmenge]   int NOT NULL ,
 [Preis_Summe]    float NOT NULL ,
 [LB_Datum]       datetime NOT NULL ,
 [Lieferanten_ID] int NOT NULL ,



 --CONSTRAINT [PK_58] PRIMARY KEY CLUSTERED ([LB_ID] ASC),
 CONSTRAINT [FK_Lieferanten_ID] FOREIGN KEY ([Lieferanten_ID])  REFERENCES [Lieferanten]([Lieferanten_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_99] ON [Lieferantenbestellungen] 
 (
  [Lieferanten_ID] ASC
 )

GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Kunden]
CREATE TABLE [Kunden]
(
 [Kunden_ID]     int NOT NULL identity primary key,
 [Anrede]        varchar(10) NULL ,
 [Vorname]       varchar(100) NOT NULL ,
 [Nachname]      varchar(100) NOT NULL ,
 [Adresse]       varchar(100) NOT NULL ,
 [Hausnummer]    varchar(5) NOT NULL ,
 [PLZ]           int NOT NULL ,
 [Ortschaft]     varchar(80) NOT NULL ,
 [Telefonnummer] int NOT NULL ,
 [E-Mail]        varchar(100) NOT NULL ,
 [Geburtsdatum]  date NULL ,
 [Login_ID]      int NOT NULL ,



 --CONSTRAINT [PK_5] PRIMARY KEY CLUSTERED ([Kunden_ID] ASC),
 CONSTRAINT [FK_Login_ID] FOREIGN KEY ([Login_ID])  REFERENCES [Login]([Login_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_87] ON [Kunden] 
 (
  [Login_ID] ASC
 )

GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Kundenbestellungen]
CREATE TABLE [Kundenbestellungen]
(
 [KB_ID]         int NOT NULL identity primary key,
 [Artikelmenge]  int NOT NULL ,
 [Preis_Summe]   float NOT NULL ,
 [Versandkosten] float NOT NULL ,
 [KB_Datum]      datetime NOT NULL ,
 [Kunden_ID]     int NOT NULL ,


 --CONSTRAINT [PK_29] PRIMARY KEY CLUSTERED ([KB_ID] ASC),
 CONSTRAINT [FK_Kundenbestellungen_ID] FOREIGN KEY ([Kunden_ID])  REFERENCES [Kunden]([Kunden_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_90] ON [Kundenbestellungen] 
 (
  [Kunden_ID] ASC
 )

GO


-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Eingang_LB]
CREATE TABLE [Eingang_LB]
(
 [Eingang_LB_ID] int NOT NULL identity primary key,
 [Eingang_ID]    int NOT NULL ,
 [LB_ID]         int NOT NULL ,



 --CONSTRAINT [PK_145] PRIMARY KEY CLUSTERED ([Eingang_LB_ID] ASC),
 CONSTRAINT [FK_Eingang_ID] FOREIGN KEY ([Eingang_ID])  REFERENCES [Eingang]([Eingang_ID]),
 CONSTRAINT [FK_LB_ID] FOREIGN KEY ([LB_ID])  REFERENCES [Lieferantenbestellungen]([LB_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_148] ON [Eingang_LB] 
 (
  [Eingang_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_151] ON [Eingang_LB] 
 (
  [LB_ID] ASC
 )

GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Artikel_LB]
CREATE TABLE [Artikel_LB]
(
 [Artikel_LB_ID]  int NOT NULL identity primary key,
 [Artikel_ID]    int NOT NULL ,
 [LB_ID]         int NOT NULL ,




 --CONSTRAINT [PK_154] PRIMARY KEY CLUSTERED ([Artikel_LB_ID] ASC),
 CONSTRAINT [FK_LB_ID3] FOREIGN KEY ([LB_ID])  REFERENCES [Lieferantenbestellungen]([LB_ID]),
 CONSTRAINT [FK_Artikel_ID3] FOREIGN KEY ([Artikel_ID])  REFERENCES [Artikel]([Artikel_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_137] ON [Artikel_LB] 
 (
  [LB_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_140] ON [Artikel_LB] 
 (
  [Artikel_ID] ASC
 )

GO


-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [Artikel_KB]
CREATE TABLE [Artikel_KB]
(
 [Artikel_KB_ID] int NOT NULL identity primary key,
 [Artikel_ID]    int NOT NULL ,
 [KB_ID]         int NOT NULL ,



 --CONSTRAINT [PK_152] PRIMARY KEY CLUSTERED ([Artikel_KB_ID] ASC),
 CONSTRAINT [FK_Artikel_ID2] FOREIGN KEY ([Artikel_ID])  REFERENCES [Artikel]([Artikel_ID]),
 CONSTRAINT [FK_KB_ID2] FOREIGN KEY ([KB_ID])  REFERENCES [Kundenbestellungen]([KB_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_117] ON [Artikel_KB] 
 (
  [Artikel_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_120] ON [Artikel_KB] 
 (
  [KB_ID] ASC
 )

GO

-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

-- ************************************** [KB_Ausgang]
CREATE TABLE [KB_Ausgang]
(
 [KB_Ausgang_ID] int NOT NULL identity primary key,
 [KB_ID]         int NOT NULL ,
 [Ausgang_ID]    int NOT NULL ,


 --CONSTRAINT [PK_102] PRIMARY KEY CLUSTERED ([KB_Ausgang_ID] ASC),
 CONSTRAINT [FK_KB_ID] FOREIGN KEY ([KB_ID])  REFERENCES [Kundenbestellungen]([KB_ID]),
 CONSTRAINT [FK_Ausgang_ID] FOREIGN KEY ([Ausgang_ID])  REFERENCES [Ausgang]([Ausgang_ID])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_105] ON [KB_Ausgang] 
 (
  [KB_ID] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_111] ON [KB_Ausgang] 
 (
  [Ausgang_ID] ASC
 )

GO

/* Probleme
--1.trigger um Artikelbestand zu Inklementieren, bei einem INSERT zu Artikel
Create trigger increaseBestand on Artikel
for insert
as
	update Artikel
		set Artikelbestand = Artikelbestand + (select count(Artikel_ID) 
							   from inserted
							  where Artikel_ID = Artikel.ARTIKEL_ID)
		where Artikel_ID in (select Artikel_id from inserted)

GO

--2.trigger um Artikelbestand zu Deklementieren, bei einem INSERT zu Artikel
Create trigger decreaseBestand on Artikel
for delete
as
	update Artikel
		set Artikelbestand = Artikelbestand - (select count(Artikel_ID) 
							   from deleted
							  where Artikel_ID = Artikel.ARTIKEL_ID)
		where Artikel_ID in (select Artikel_id from deleted)

GO*/

--3.trigger um Kundenbesteelungen mit Ausgang
create trigger decrementValueOnOrder on Kundenbestellungen
for insert
as
	insert into Ausgang (Ausgangsdatum)
	 values(GETDATE())
GO

--4.trigger um Lieferantenbestellungen mit Eingang
create trigger incrementValueOnOrder on Lieferantenbestellungen
for insert
as
	insert into Eingang (Eingangsdatum)
	 values(GETDATE())
GO		


--1.Constraints--
alter table Lieferantenbestellungen
add constraint maxProduktmenge
check(1000>=Produktmenge)

--2.Constraints--
alter table Artikel
add constraint maxArtikelbestand
check(30>Artikelbestand)

--3.Constraints--
alter table kunden
add constraint Altersbeschraenkung
check (Geburtsdatum between '1910-01-01' and '2003-01-01')

GO

--1view für Login und Kunden
create view Login_Kunden
as
select L.Login_ID,
L.Benutzername,
K.Kunden_ID,
K.Vorname,
K.Nachname
from Login as L
inner Join Kunden as K
on L.Login_ID = K.Login_ID;

GO

--2view für Kunden und Kundenbestellungen
create view Kunden_Kundenbestellungen
as
select K.Kunden_ID,
K.Vorname,
K.Nachname,
KB.KB_ID,
KB.Artikelmenge,
KB.Preis_Summe,
KB.Versandkosten,
KB.KB_Datum
from Kunden as K
inner Join Kundenbestellungen as KB
on K.Kunden_ID = KB.Kunden_ID;

GO

--3view für Artikel und Marken
create view Artikel_Marken
as
select A.Artikel_ID,
A.Artikelname,
A.Artikelnummer,
A.Preis,
M.Marken_ID,
M.Marken
from Artikel as A
inner Join Marken as M
on A.Marken_ID = M.Marken_ID;

GO

--1.Stored Procedure--
CREATE PROCEDURE ZeigeAlleKunden
AS
SELECT * FROM Kunden
GO
--Use Case for Stored Procedure -> ZeigeAlleKunden
 /**** EXEC ZeigeAlleKunden; ****/

--2.Stored Procedure--
CREATE PROCEDURE ZeigeKundenVonOrtschaft @Ortschaft varchar(30)
AS
SELECT * FROM Kunden
	where Ortschaft = @Ortschaft
GO
--Use Case for Stored Procedure -> ZeigeKundenVonOrtschaft mit lokaler Variabel @Ortschaft--
 /**** EXEC ZeigeKundenVonOrtschaft @Ortschaft = 'Zürich'; ****/
 /**** EXEC ZeigeKundenVonOrtschaft @Ortschaft = 'Aargau'; ****/


