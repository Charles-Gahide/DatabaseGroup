-- =============================================================================
-- SCRIPT: DF_insert_data_team_69.sql
-- DOEL: Vullen van de database met testdata (Case study + Extra's)
-- =============================================================================

-- 1. REFERENTIEDATA
INSERT INTO Diersoort (DiersoortID, Naam) VALUES 
(1, 'Kat'), (2, 'Hond'), (3, 'Papegaai'), (4, 'Konijn'), (5, 'Paardachtigen');

INSERT INTO Ras (RasID, Naam, DiersoortID) VALUES 
(1, 'Bengaal', 1), (2, 'Europese Korthaar', 1), (3, 'Pers', 1), 
(4, 'Border Collie', 2), (5, 'Golden Retriever', 2), (6, 'Chihuahua', 2), 
(7, 'Ara', 3), 
(8, 'Hangoor', 4), 
(9, 'Shetland Pony', 5);

INSERT INTO Specialisatie (SpecialisatieID, Naam) VALUES 
(1, 'Gebitsverzorging'), (2, 'Beeldvorming'), (3, 'Chirurgie'), (4, 'Kleine huisdieren');

INSERT INTO Product (ProductID, Naam, Prijs, Type) VALUES 
(1, 'Cefalexine', 20.00, 'Medicatie'),
(2, 'Hill''s Prescription Diet c/d Multicare 12kg', 80.29, 'Voeding'),
(3, 'Royal Canin mini puppy', 14.99, 'Voeding'),
(4, 'Ontworming Hond Large', 15.50, 'Medicatie'),
(5, 'Vlooienband Seresto', 35.00, 'Medicatie');

INSERT INTO Service (ServiceID, Naam, StandaardPrijs) VALUES 
(1, 'Consultatie Standaard', 50.00),
(2, 'Consultatie Controle', 40.00),
(3, 'Consultatie Huisbezoek', 65.00),
(4, 'Toeslag Huisbezoek', 20.00),
(5, 'Gebitsreiniging (incl narcose)', 350.00),
(6, 'Euthanasie & Verwerking', 135.00),
(7, 'Snavelverzorging', 30.00);

-- 2. PERSONEEL & WACHTDIENST (AANGEPAST MET CONTACTGEGEVENS)
INSERT INTO Personeelslid (PersoneelID, Naam, Adres, Telefoon, Email, Functie) VALUES 
(1, 'Els Martens', 'Kerkstraat 1, 3000 Leuven', '0475111222', 'els.martens@connect.be', 'Arts'),
(2, 'Geert Vanaken', 'Dorpstraat 10, 3001 Heverlee', '0475222333', 'geert.vanaken@connect.be', 'Arts'),
(3, 'Sara Vanderelst', 'Bondgenotenlaan 5, 3000 Leuven', '0475333444', 'sara.vanderelst@connect.be', 'Arts'),
(4, 'Aïsha El Founti', 'Tiensesteenweg 80, 3010 Kessel-Lo', '0475444555', 'aisha.elfounti@connect.be', 'Arts'),
(5, 'Walter Malfliet', 'Naamsestraat 45, 3000 Leuven', '0475555666', 'walter.malfliet@connect.be', 'Arts'),
(6, 'Jan Peeters', 'Brusselsestraat 12, 3000 Leuven', '0475666777', 'jan.peeters@connect.be', 'Arts'),
(7, 'Ine De Smet', 'Parkstraat 22, 3000 Leuven', '0475777888', 'ine.desmet@connect.be', 'Arts'),
(8, 'Ruth Bertels', 'Diestsestraat 100, 3000 Leuven', '0475888999', 'ruth.bertels@connect.be', 'Verzorger'),
(9, 'Tom Willems', 'Vaartstraat 7, 3000 Leuven', '0475999000', 'tom.willems@connect.be', 'Verzorger'),
(10, 'Sofie Casterman', 'Vismarkt 3, 3000 Leuven', '0475000111', 'sofie.casterman@connect.be', 'Medewerker');

INSERT INTO Arts_Specialisatie (PersoneelID, SpecialisatieID) VALUES (4, 1);

INSERT INTO Wachtdienst (WachtdienstID, StartDatumTijd, EindDatumTijd) VALUES
(1, '2025-09-05 18:00:00', '2025-09-06 09:00:00'),
(2, '2025-09-06 09:00:00', '2025-09-07 09:00:00'),
(3, '2025-09-07 09:00:00', '2025-09-08 08:00:00');

INSERT INTO Arts_Wachtdienst (PersoneelID, WachtdienstID) VALUES (2, 1), (5, 2), (1, 3);

-- 3. KLANTEN & HUISDIEREN
INSERT INTO Klant (EigenaarID, Naam, Telefoon, Email) VALUES 
(1, 'Wim Desmedt', '0455123456', 'wim.desmedt@gmail.com'),
(2, 'Katrien Aerts', '0455795632', 'katrien.aerts@telenet.be'),
(3, 'Geertje Bernaerts', '0455999666', 'geertje.bernaerts@vjk.be'),
(4, 'Bart Mertens', NULL, 'bmertens@skynet.be'),
(5, 'Griet Vekemans', '0455112233', 'griet.vekemans@icloud.com'),
(6, 'Peter Snellings', '016 489786', 'psnel@hotmail.com'),
(7, 'Sophie Visser', '0477112233', 's.visser@mail.com'),
(8, 'Mark De Vries', '0488445566', 'mark.devries@provider.be'),
(9, 'Emma Peeters', '0499778899', 'emma.p@gmail.com'),
(10, 'Lucas Maes', '0466001122', 'lucas.maes@telenet.be'),
(11, 'Julie Dubois', '0455334455', 'j.dubois@hotmail.com');

INSERT INTO Huisdier (HuisdierID, Naam, Geboortedatum, EigenaarID, RasID) VALUES 
(1, 'Maurice', '2022-01-15', 1, 1),
(2, 'Willy', '2015-06-20', 1, 7),
(3, 'Bobby', '2018-05-10', 1, 5),
(4, 'Nero', '2019-09-03', 2, 4),
(5, 'Prins', '2024-01-01', 3, 6),
(6, 'Fluffy', '2023-04-12', 4, 8),
(7, 'White shadow', '2010-05-20', 5, 9),
(8, 'Garfield', '2002-08-15', 6, 2),
(9, 'Max', '2020-05-01', 7, 5),
(10, 'Luna', '2021-08-12', 8, 2),
(11, 'Simba', '2019-03-20', 8, 2),
(12, 'Coco', '2023-01-10', 9, 3),
(13, 'Bella', '2017-11-05', 10, 5),
(14, 'Nijntje', '2022-06-15', 11, 8);

-- 4. PROCES
INSERT INTO Afspraak (AfspraakID, DatumTijd, Reden, KlantID, HuisdierID, PersoneelID) VALUES 
(1, '2025-08-28 15:00:00', 'Bloed in urine', 1, 1, 1),
(2, '2025-09-03 09:00:00', 'Controle blaas', 1, 1, 2),
(3, '2025-03-23 14:00:00', 'Snavelprobleem', 1, 2, 8),
(4, '2025-09-03 09:00:00', 'Tandsteen', 2, 4, 4),
(5, '2025-09-03 10:25:00', 'Eet niet meer', 4, 6, 1),
(6, '2025-09-04 13:45:00', 'Bespreking toestand', 4, 6, 1),
(7, '2025-09-03 11:00:00', 'Euthanasie', 6, 8, 1),
(8, '2025-09-03 11:05:00', 'Wonde aan afsluiting', 5, 7, 5),
(9, '2025-09-05 15:30:00', 'Controle wonde', 5, 7, 5),
(10, '2025-09-18 16:00:00', 'Jaarlijkse controle', 1, 3, 3),
(11, '2025-01-10 09:30:00', 'Vaccinatie', 7, 9, 3),
(12, '2025-02-14 14:00:00', 'Manken poot rechtsvoor', 10, 13, 5),
(13, '2025-04-20 11:15:00', 'Controle gewicht', 8, 10, 2);

INSERT INTO Consultatie (ConsultatieID, Datum, Diagnose, AfspraakID) VALUES 
(1, '2025-08-28', 'Ernstige blaasontsteking', 1),
(2, '2025-09-03', 'Genezen. Advies voeding.', 2),
(3, '2025-03-23', 'Snavel bijgevijld', 3),
(4, '2025-09-03', 'Professionele gebitsreiniging onder narcose. Extractie kies.', 4),
(5, '2025-09-03', 'Mogelijk darmstilstand. Opname noodzakelijk.', 5),
(6, '2025-09-03', 'Ouderdom, lijden. Ingeslapen.', 7),
(7, '2025-09-03', 'Ontsmetting en hechting.', 8),
(8, '2025-01-10', 'Jaarlijkse cocktail gegeven', 11),
(9, '2025-02-14', 'Verstuiking, rust voorgeschreven', 12),
(10, '2025-04-20', 'Te zwaar, dieetvoer gestart', 13);

INSERT INTO Consultatie_Personeel (ConsultatieID, PersoneelID) VALUES 
(1, 1), (2, 2), (3, 8), (4, 4), (4, 8), (5, 1), 
(6, 1), (7, 5), (8, 3), (9, 5), (10, 2);

INSERT INTO Opname (OpnameID, StartDatum, EindDatum, HuisdierID, ConsultatieID) VALUES 
(1, '2025-09-03', '2025-09-03', 4, 4),
(2, '2025-09-03', NULL, 6, 5);

-- 5. FACTURATIE
INSERT INTO Factuur (FactuurID, Datum, KlantID) VALUES 
(1, '2025-08-28', 1),
(2, '2025-09-03', 1),
(3, '2025-09-03', 2),
(4, '2025-09-03', 3),
(5, '2025-09-03', 6),
(6, '2025-09-03', 5),
(7, '2025-01-10', 7),
(8, '2025-02-14', 10),
(9, '2025-04-20', 8);

INSERT INTO FactuurRegel (RegelID, Aantal, RegelPrijs, FactuurID, ServiceID, ProductID) VALUES 
(1, 1, 50.00, 1, 1, NULL),
(2, 1, 20.00, 1, NULL, 1),
(3, 1, 40.00, 2, 2, NULL),
(4, 1, 80.29, 2, NULL, 2),
(5, 1, 350.00, 3, 5, NULL),
(6, 1, 14.99, 4, NULL, 3),
(7, 1, 135.00, 5, 6, NULL),
(8, 1, 65.00, 6, 3, NULL),
(9, 1, 20.00, 6, 4, NULL),
(10, 1, 50.00, 7, 1, NULL),
(11, 1, 50.00, 8, 1, NULL),
(12, 1, 20.00, 8, NULL, 1),
(13, 1, 40.00, 9, 2, NULL),
(14, 1, 80.29, 9, NULL, 2);

-- 6. RESET TELLERS
SELECT setval('klant_eigenaarid_seq', (SELECT MAX(EigenaarID) FROM Klant));
SELECT setval('diersoort_diersoortid_seq', (SELECT MAX(DiersoortID) FROM Diersoort));
SELECT setval('ras_rasid_seq', (SELECT MAX(RasID) FROM Ras));
SELECT setval('personeelslid_personeelid_seq', (SELECT MAX(PersoneelID) FROM Personeelslid));
SELECT setval('specialisatie_specialisatieid_seq', (SELECT MAX(SpecialisatieID) FROM Specialisatie));
SELECT setval('wachtdienst_wachtdienstid_seq', (SELECT MAX(WachtdienstID) FROM Wachtdienst));
SELECT setval('product_productid_seq', (SELECT MAX(ProductID) FROM Product));
SELECT setval('service_serviceid_seq', (SELECT MAX(ServiceID) FROM Service));
SELECT setval('huisdier_huisdierid_seq', (SELECT MAX(HuisdierID) FROM Huisdier));
SELECT setval('afspraak_afspraakid_seq', (SELECT MAX(AfspraakID) FROM Afspraak));
SELECT setval('consultatie_consultatieid_seq', (SELECT MAX(ConsultatieID) FROM Consultatie));
SELECT setval('opname_opnameid_seq', (SELECT MAX(OpnameID) FROM Opname));
SELECT setval('factuur_factuurid_seq', (SELECT MAX(FactuurID) FROM Factuur));
SELECT setval('factuurregel_regelid_seq', (SELECT MAX(RegelID) FROM FactuurRegel));
