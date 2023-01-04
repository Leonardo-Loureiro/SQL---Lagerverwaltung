-- Projekt 'Lagerverwaltung' von Leonardo Loureiro --
-- ************** DATENSÄTZE EINFÜGEN **************** --

 --1.INSERTS ARTIKELGRUPPEN Fixed
insert into artikelgruppen(artikelgruppen)
 values ('Smartphone')
insert into artikelgruppen(artikelgruppen)
 values ('Tablet')
 insert into artikelgruppen(artikelgruppen)
 values ('Laptop')

 --2.INSERTS MARKEN Fixed
insert into marken(marken)
 values ('Apple')
 insert into marken(marken)
 values ('Samsung')
 insert into marken(marken)
 values ('Acer')
 insert into marken(marken)
 values ('HP')
 insert into marken(marken)
 values ('Asus')

 --3.INSERTS ARTIKEL *(Erzeugt!)* // "insert into artikel"= Use-Case für Constraint -> increaseBestand
insert into artikel(artikelname,artikelnummer,preis,Artikelbestand,artikelgruppen_id, marken_id)
 values ('Iphone 13','153D153',899.95,10,1,1)
 GO
insert into artikel(artikelname,artikelnummer,preis,Artikelbestand,artikelgruppen_id, marken_id)
 values ('Acer Aspire F 09','178L863',1199.95,8,3,3)
 GO
insert into artikel(artikelname,artikelnummer,preis,Artikelbestand,artikelgruppen_id, marken_id)
 values ('HP Tablet 5000','856FX56',1599.95,5,2,4)
 GO
 insert into artikel(artikelname,artikelnummer,preis,Artikelbestand, artikelgruppen_id, marken_id)
 values ('Galaxy S200','1D182QW',900.00,5, 1,2)
 GO

 /*		"delte from artikel" = Use-Case für Constraint -> decreaseBestand		*/
				--delete from artikel where artikel_id=5


 --4.INSERTS für LOGIN 
insert into Login (Benutzername, Passwort, Is_Active,Is_Deactive,Is_Archive)
 values ('Oxa', HASHBYTES('SHA2_256', 'supersuper1526'), 1, 0, 0)
 insert into Login (Benutzername, Passwort, Is_Active,Is_Deactive,Is_Archive)
 values ('wasd', HASHBYTES('SHA2_256', 'supergeheim1345'), 1, 0, 0)


 --5.INSERTS für Kunden 
insert into Kunden (Anrede, Vorname, Nachname, Adresse, Hausnummer, PLZ, Ortschaft, Telefonnummer, [E-Mail], Geburtsdatum, Login_ID)
 values ('Herr', 'Leonardo', 'Loureiro', 'Gutstrasse 100', 80, 8005, 'Zürich', 078555646, 'leo@djdj.ch', '2001-03-16', 1)
 insert into Kunden (Anrede, Vorname, Nachname, Adresse, Hausnummer, PLZ, Ortschaft, Telefonnummer, [E-Mail], Geburtsdatum, Login_ID)
 values ('Frau', 'Shaadhaana', 'Manivannan', 'strasse 10', 85, 5000, 'Aargau', 078444646, 'sha@djdj.ch', '2000-01-01', 1)

 --6.INSERTS Lieferanten
insert into Lieferanten(Lieferantenname, Ansprechsperson, adresse, hausnummer, plz, ortschaft, telefonnummer,[e-mail])
 values('BlackBerry', 'Herr Dr.Einstein', 'Diestrasse', '106A', '8009', 'Buchs', 078566464, 'berry.oi@hot.com')
 insert into Lieferanten(Lieferantenname, Ansprechsperson, adresse, hausnummer, plz, ortschaft, telefonnummer,[e-mail])
 values('Doogee', 'Herr Dr.Albert', 'Diesestrasse', '236A', '8059', 'Buchs', 07876522, 'Doo.gee@hot.com')

--7.INSERTS Kundenbestellung // "insert into Kundenbestellungen"= Use-Case Trigger -> decrementValueOnOrder
insert into Kundenbestellungen(artikelmenge, preis_summe,versandkosten,kb_datum,Kunden_ID)
 values(14, 3900, 69, GETDATE(), 1)

--8.INSERTS Lieferantenbestellungen // "insert into Lieferantenbestellung"= Use-Case Trigger -> incrementValueOnOrder
insert into Lieferantenbestellungen(Produktmenge,preis_summe,lb_datum, Lieferanten_ID)
 values(15, 4000, GETDATE(), 2)

 --9. INSERTS Zwischentabellen
 --Artikel_KB
insert into Artikel_KB(Artikel_ID, KB_ID)
 values(1,1)

 --Artikel_LB
insert into Artikel_LB(Artikel_ID, LB_ID)
 values(4, 1)

 --Eingang_LB
insert into Eingang_LB(Eingang_ID, LB_ID)
 values(1, 1)

 --KB_Ausgang
insert into KB_Ausgang(KB_ID, Ausgang_ID)
 values(1,1)
 


--10. USE CASES TESTGEBIET für Constraints--
 --1. Constraint ->  maxProduktmenge -- wird Fehlermedlung geben!!!
 insert into Lieferantenbestellungen(Produktmenge, Preis_Summe, LB_Datum, Lieferanten_ID)
values (1001, 2222.90, 2021-10-04, 2);
--2. Constraint -> maxArtikelbestand -- wird Fehlermedlung geben!!!
insert into Artikel(Artikelname, Artikelnummer, Preis, Artikelbestand, Artikelgruppen_ID, Marken_ID)
values ('SamsungS4', 1121, 1121.90, 1000, 1,  1);
--3. Constraint -> Altersbeschraenkung -- wird Fehlermeldung geben!!!
insert into Kunden (Anrede, Vorname, Nachname, Adresse, Hausnummer, PLZ, Ortschaft, Telefonnummer, [E-Mail], Geburtsdatum, Login_ID)
values ('Herr', 'Leo', 'Lou', 'Gutstras', 80, 8005, 'Zürich', 078555646, 'leo@djdj.ch', '2004-03-16', 1)



  
