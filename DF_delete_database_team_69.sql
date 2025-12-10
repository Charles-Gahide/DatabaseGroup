-- =============================================================================
-- SCRIPT: DF_delete_database_team_XX.sql
-- DOEL: Opruimen van de database (Drop tables in correct order, no cascade)
-- =============================================================================

-- Stap 1: Verwijder tabellen met Foreign Keys (de 'kinderen')
DROP TABLE IF EXISTS FactuurRegel;
DROP TABLE IF EXISTS Opname;
DROP TABLE IF EXISTS Consultatie_Personeel;
DROP TABLE IF EXISTS Arts_Wachtdienst;
DROP TABLE IF EXISTS Arts_Specialisatie;

-- Stap 2: Verwijder tabellen die afhangen van andere kernentiteiten
DROP TABLE IF EXISTS Consultatie;
DROP TABLE IF EXISTS Factuur;
DROP TABLE IF EXISTS Afspraak;
DROP TABLE IF EXISTS Huisdier;
DROP TABLE IF EXISTS Ras;

-- Stap 3: Verwijder de onafhankelijke 'ouder' tabellen
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Wachtdienst;
DROP TABLE IF EXISTS Specialisatie;
DROP TABLE IF EXISTS Personeelslid;
DROP TABLE IF EXISTS Diersoort;
DROP TABLE IF EXISTS Klant;
