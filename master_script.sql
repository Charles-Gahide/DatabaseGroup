-- =============================================================================
-- FINAL MASTER SCRIPT: EXPLICIETE IDs & CORRECTIES
-- =============================================================================

-- -----------------------------------------------------------------------------
-- STAP 1: OPRUIMEN
-- -----------------------------------------------------------------------------
DROP TABLE IF EXISTS FactuurRegel CASCADE;
DROP TABLE IF EXISTS Factuur CASCADE;
DROP TABLE IF EXISTS Opname CASCADE;
DROP TABLE IF EXISTS Consultatie_Personeel CASCADE;
DROP TABLE IF EXISTS Consultatie CASCADE;
DROP TABLE IF EXISTS Afspraak CASCADE;
DROP TABLE IF EXISTS Arts_Wachtdienst CASCADE;
DROP TABLE IF EXISTS Arts_Specialisatie CASCADE;
DROP TABLE IF EXISTS Huisdier CASCADE;
DROP TABLE IF EXISTS Service CASCADE;
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Wachtdienst CASCADE;
DROP TABLE IF EXISTS Specialisatie CASCADE;
DROP TABLE IF EXISTS Personeelslid CASCADE;
DROP TABLE IF EXISTS Ras CASCADE;
DROP TABLE IF EXISTS Diersoort CASCADE;
DROP TABLE IF EXISTS Klant CASCADE;

-- -----------------------------------------------------------------------------
-- STAP 2: AANMAKEN TABELLEN
-- -----------------------------------------------------------------------------
CREATE TABLE Klant (
    EigenaarID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL,
    Telefoon VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Diersoort (
    DiersoortID SERIAL PRIMARY KEY,
    Naam VARCHAR(50) NOT NULL
);

CREATE TABLE Ras (
    RasID SERIAL PRIMARY KEY,
    Naam VARCHAR(50) NOT NULL,
    DiersoortID INT NOT NULL,
    CONSTRAINT fk_ras_diersoort FOREIGN KEY (DiersoortID) REFERENCES Diersoort(DiersoortID)
);

CREATE TABLE Personeelslid (
    PersoneelID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL,
    Functie VARCHAR(50) NOT NULL
);

CREATE TABLE Specialisatie (
    SpecialisatieID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL
);

CREATE TABLE Wachtdienst (
    WachtdienstID SERIAL PRIMARY KEY,
    StartDatumTijd TIMESTAMP NOT NULL,
    EindDatumTijd TIMESTAMP NOT NULL
);

CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL,
    Prijs DECIMAL(10, 2) NOT NULL,
    Type VARCHAR(20)
);

CREATE TABLE Service (
    ServiceID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL,
    StandaardPrijs DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Huisdier (
    HuisdierID SERIAL PRIMARY KEY,
    Naam VARCHAR(50) NOT NULL,
    Geboortedatum DATE,
    EigenaarID INT NOT NULL,
    RasID INT NOT NULL,
    CONSTRAINT fk_dier_klant FOREIGN KEY (EigenaarID) REFERENCES Klant(EigenaarID),
    CONSTRAINT fk_dier_ras FOREIGN KEY (RasID) REFERENCES Ras(RasID)
);

CREATE TABLE Arts_Specialisatie (
    PersoneelID INT NOT NULL,
    SpecialisatieID INT NOT NULL,
    PRIMARY KEY (PersoneelID, SpecialisatieID),
    CONSTRAINT fk_as_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID),
    CONSTRAINT fk_as_spec FOREIGN KEY (SpecialisatieID) REFERENCES Specialisatie(SpecialisatieID)
);

CREATE TABLE Arts_Wachtdienst (
    PersoneelID INT NOT NULL,
    WachtdienstID INT NOT NULL,
    PRIMARY KEY (PersoneelID, WachtdienstID),
    CONSTRAINT fk_aw_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID),
    CONSTRAINT fk_aw_wacht FOREIGN KEY (WachtdienstID) REFERENCES Wachtdienst(WachtdienstID)
);

CREATE TABLE Afspraak (
    AfspraakID SERIAL PRIMARY KEY,
    DatumTijd TIMESTAMP NOT NULL,
    Reden TEXT,
    KlantID INT NOT NULL,
    HuisdierID INT NOT NULL,
    PersoneelID INT NOT NULL,
    CONSTRAINT fk_afspraak_klant FOREIGN KEY (KlantID) REFERENCES Klant(EigenaarID),
    CONSTRAINT fk_afspraak_dier FOREIGN KEY (HuisdierID) REFERENCES Huisdier(HuisdierID),
    CONSTRAINT fk_afspraak_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID)
);

CREATE TABLE Consultatie (
    ConsultatieID SERIAL PRIMARY KEY,
    Datum DATE NOT NULL,
    Diagnose TEXT,
    AfspraakID INT UNIQUE NOT NULL,
    CONSTRAINT fk_consult_afspraak FOREIGN KEY (AfspraakID) REFERENCES Afspraak(AfspraakID)
);

CREATE TABLE Consultatie_Personeel (
    ConsultatieID INT NOT NULL,
    PersoneelID INT NOT NULL,
    PRIMARY KEY (ConsultatieID, PersoneelID),
    CONSTRAINT fk_cp_consult FOREIGN KEY (ConsultatieID) REFERENCES Consultatie(ConsultatieID),
    CONSTRAINT fk_cp_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID)
);

CREATE TABLE Opname (
    OpnameID SERIAL PRIMARY KEY,
    StartDatum DATE NOT NULL,
    EindDatum DATE,
    HuisdierID INT NOT NULL,
    ConsultatieID INT,
    CONSTRAINT fk_opname_dier FOREIGN KEY (HuisdierID) REFERENCES Huisdier(HuisdierID),
    CONSTRAINT fk_opname_consult FOREIGN KEY (ConsultatieID) REFERENCES Consultatie(ConsultatieID)
);

CREATE TABLE Factuur (
    FactuurID SERIAL PRIMARY KEY,
    Datum DATE NOT NULL,
    KlantID INT NOT NULL,
    CONSTRAINT fk_factuur_klant FOREIGN KEY (KlantID) REFERENCES Klant(EigenaarID)
);

CREATE TABLE FactuurRegel (
    RegelID SERIAL PRIMARY KEY,
    Aantal INT NOT NULL DEFAULT 1,
    RegelPrijs DECIMAL(10, 2) NOT NULL,
    FactuurID INT NOT NULL,
    ProductID INT,
    ServiceID INT,
    CONSTRAINT fk_regel_factuur FOREIGN KEY (FactuurID) REFERENCES Factuur(FactuurID),
    CONSTRAINT fk_regel_prod FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    CONSTRAINT fk_regel_serv FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
    CONSTRAINT check_product_or_service CHECK (
        (ProductID IS NOT NULL AND ServiceID IS NULL) OR 
        (ProductID IS NULL AND ServiceID IS NOT NULL)
    )
);

-- -----------------------------------------------------------------------------
-- STAP 3: DATA TOEVOEGEN (MET EXPLICIETE IDs)
-- -----------------------------------------------------------------------------

-- 3.1 REFERENTIEDATA
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

INSERT INTO Personeelslid (PersoneelID, Naam, Functie) VALUES 
(1, 'Els Martens', 'Arts'),
(2, 'Geert Vanaken', 'Arts'),
(3, 'Sara Vanderelst', 'Arts'),
(4, 'Aïsha El Founti', 'Arts'),
(5, 'Walter Malfliet', 'Arts'),
(6, 'Jan Peeters', 'Arts'),
(7, 'Ine De Smet', 'Arts'),
(8, 'Ruth Bertels', 'Verzorger'),
(9, 'Tom Willems', 'Verzorger'),
(10, 'Sofie Casterman', 'Medewerker');

INSERT INTO Arts_Specialisatie (PersoneelID, SpecialisatieID) VALUES (4, 1);

INSERT INTO Wachtdienst (WachtdienstID, StartDatumTijd, EindDatumTijd) VALUES
(1, '2025-09-05 18:00:00', '2025-09-06 09:00:00'),
(2, '2025-09-06 09:00:00', '2025-09-07 09:00:00'),
(3, '2025-09-07 09:00:00', '2025-09-08 08:00:00');

INSERT INTO Arts_Wachtdienst (PersoneelID, WachtdienstID) VALUES (2, 1), (5, 2), (1, 3);

-- 3.2 KLANTEN & DIEREN
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

-- 3.3 PROCES
INSERT INTO Afspraak (AfspraakID, DatumTijd, Reden, KlantID, HuisdierID, PersoneelID) VALUES 
(1, '2025-08-28 15:00:00', 'Bloed in urine', 1, 1, 1),
(2, '2025-09-03 09:00:00', 'Controle blaas', 1, 1, 2),
(3, '2025-03-23 14:00:00', 'Snavelprobleem', 1, 2, 8),
(4, '2025-09-03 09:00:00', 'Tandsteen', 2, 4, 4),
(5, '2025-09-03 10:25:00', 'Eet niet meer', 4, 6, 1), -- Fluffy is ID 6
(6, '2025-09-04 13:45:00', 'Bespreking toestand', 4, 6, 1),
(7, '2025-09-03 11:00:00', 'Euthanasie', 6, 8, 1), -- Garfield is ID 8
(8, '2025-09-03 11:05:00', 'Wonde aan afsluiting', 5, 7, 5), -- White Shadow is ID 7
(9, '2025-09-05 15:30:00', 'Controle wonde', 5, 7, 5),
(10, '2025-09-18 16:00:00', 'Jaarlijkse controle', 1, 3, 3),
(11, '2025-01-10 09:30:00', 'Vaccinatie', 7, 9, 3),
(12, '2025-02-14 14:00:00', 'Manken poot rechtsvoor', 10, 13, 5),
(13, '2025-04-20 11:15:00', 'Controle gewicht', 8, 10, 2);

-- Consultaties koppelen aan afspraken (IDs nu ook hardcoded)
INSERT INTO Consultatie (ConsultatieID, Datum, Diagnose, AfspraakID) VALUES 
(1, '2025-08-28', 'Ernstige blaasontsteking', 1),
(2, '2025-09-03', 'Genezen. Advies voeding.', 2),
(3, '2025-03-23', 'Snavel bijgevijld', 3),
(4, '2025-09-03', 'Professionele gebitsreiniging onder narcose. Extractie kies.', 4),
(5, '2025-09-03', 'Mogelijk darmstilstand. Opname noodzakelijk.', 5),
(6, '2025-09-03', 'Ouderdom, lijden. Ingeslapen.', 7), -- Afspraak 7 (Garfield)
(7, '2025-09-03', 'Ontsmetting en hechting.', 8),    -- Afspraak 8 (White shadow)
(8, '2025-01-10', 'Jaarlijkse cocktail gegeven', 11),
(9, '2025-02-14', 'Verstuiking, rust voorgeschreven', 12),
(10, '2025-04-20', 'Te zwaar, dieetvoer gestart', 13);

-- Nu kloppen de IDs zeker:
INSERT INTO Consultatie_Personeel (ConsultatieID, PersoneelID) VALUES 
(1, 1), (2, 2), (3, 8), (4, 4), (4, 8), (5, 1), 
(6, 1), -- Garfield (ID 6) gedaan door Els (ID 1)
(7, 5), -- White shadow (ID 7) gedaan door Walter (ID 5)
(8, 3), 
(9, 5), 
(10, 2);

INSERT INTO Opname (OpnameID, StartDatum, EindDatum, HuisdierID, ConsultatieID) VALUES 
(1, '2025-09-03', '2025-09-03', 4, 4),
(2, '2025-09-03', NULL, 6, 5); -- Fluffy

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

-- -----------------------------------------------------------------------------
-- STAP 4: RESET TELLERS (Zodat je zelf ook nog data kan toevoegen later)
-- -----------------------------------------------------------------------------
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
