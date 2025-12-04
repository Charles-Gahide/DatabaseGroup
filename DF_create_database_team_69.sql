-- =============================================
-- AANMAKEN DATABASE STRUCTUUR (DDL)
-- =============================================

-- 1. TABELLEN VOOR DE BASISGEGEVENS (Lookup & Personen)

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
    Functie VARCHAR(50) NOT NULL -- Bijv: 'Arts', 'Verzorger', 'Medewerker'
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
    Type VARCHAR(20) -- Bijv: 'Voeding', 'Medicatie'
);

CREATE TABLE Service (
    ServiceID SERIAL PRIMARY KEY,
    Naam VARCHAR(100) NOT NULL,
    StandaardPrijs DECIMAL(10, 2) NOT NULL
);

-- 2. TABELLEN VOOR DE KERNENTITEITEN & RELATIES

CREATE TABLE Huisdier (
    HuisdierID SERIAL PRIMARY KEY,
    Naam VARCHAR(50) NOT NULL,
    Geboortedatum DATE,
    EigenaarID INT NOT NULL,
    RasID INT NOT NULL,
    CONSTRAINT fk_dier_klant FOREIGN KEY (EigenaarID) REFERENCES Klant(EigenaarID),
    CONSTRAINT fk_dier_ras FOREIGN KEY (RasID) REFERENCES Ras(RasID)
);

-- Koppeltabel: Welke arts heeft welke specialisatie?
CREATE TABLE Arts_Specialisatie (
    PersoneelID INT NOT NULL,
    SpecialisatieID INT NOT NULL,
    PRIMARY KEY (PersoneelID, SpecialisatieID),
    CONSTRAINT fk_as_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID),
    CONSTRAINT fk_as_spec FOREIGN KEY (SpecialisatieID) REFERENCES Specialisatie(SpecialisatieID)
);

-- Koppeltabel: Welke arts heeft wanneer wachtdienst?
CREATE TABLE Arts_Wachtdienst (
    PersoneelID INT NOT NULL,
    WachtdienstID INT NOT NULL,
    PRIMARY KEY (PersoneelID, WachtdienstID),
    CONSTRAINT fk_aw_pers FOREIGN KEY (PersoneelID) REFERENCES Personeelslid(PersoneelID),
    CONSTRAINT fk_aw_wacht FOREIGN KEY (WachtdienstID) REFERENCES Wachtdienst(WachtdienstID)
);

-- 3. TABELLEN VOOR HET ZORGPROCES (Afspraak -> Consultatie -> Opname)

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
    AfspraakID INT UNIQUE NOT NULL, -- Zorgt voor de 1-op-1 relatie met Afspraak
    CONSTRAINT fk_consult_afspraak FOREIGN KEY (AfspraakID) REFERENCES Afspraak(AfspraakID)
);

-- Koppeltabel: Wie was er aanwezig bij de consultatie? (Meerdere artsen/verzorgers mogelijk)
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
    ConsultatieID INT, -- Kan leeg zijn als opname niet direct na consult is
    CONSTRAINT fk_opname_dier FOREIGN KEY (HuisdierID) REFERENCES Huisdier(HuisdierID),
    CONSTRAINT fk_opname_consult FOREIGN KEY (ConsultatieID) REFERENCES Consultatie(ConsultatieID)
);

-- 4. TABELLEN VOOR DE FINANCIËN

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
    -- Constraint: Een regel moet OF een product OF een service zijn, niet allebei en niet geen van beide.
    CONSTRAINT check_product_or_service CHECK (
        (ProductID IS NOT NULL AND ServiceID IS NULL) OR 
        (ProductID IS NULL AND ServiceID IS NOT NULL)
    )
);
