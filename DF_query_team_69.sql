-- =============================================================================
-- SCRIPT: DF_query_team_XX.sql
-- DOEL: 5 Zinvolle en complexe query's voor de praktijkvoering
-- =============================================================================

-- QUERY 1: TOP 3 KLANTEN (OMZET)
-- Doel: Voor de praktijk is het belangrijk te weten wie de beste klanten zijn 
-- (VIP's) op basis van totale uitgaven, om hen eventueel een bedankje te sturen.
-- Technieken: JOIN, GROUP BY, ORDER BY, LIMIT, AGGREGATE FUNCTION (SUM)

SELECT 
    k.Naam AS KlantNaam, 
    k.Email, 
    COUNT(DISTINCT f.FactuurID) AS AantalFacturen, 
    SUM(fr.Aantal * fr.RegelPrijs) AS TotaleUitgaven
FROM Klant k
JOIN Factuur f ON k.EigenaarID = f.KlantID
JOIN FactuurRegel fr ON f.FactuurID = fr.FactuurID
GROUP BY k.EigenaarID, k.Naam, k.Email
ORDER BY TotaleUitgaven DESC
LIMIT 3;


-- QUERY 2: POPULARITEIT VAN DIENSTEN VS PRODUCTEN
-- Doel: Inzicht krijgen in de verhouding tussen inkomsten uit diensten (consults/operaties)
-- en verkoop van producten (voeding/medicatie) om de winstgevendheid te analyseren.
-- Technieken: LEFT JOIN, CASE STATEMENT (of conditionele telling), GROUP BY

SELECT 
    CASE 
        WHEN fr.ServiceID IS NOT NULL THEN 'Service'
        WHEN fr.ProductID IS NOT NULL THEN 'Product'
    END AS TypeVerkoop,
    COUNT(*) AS AantalVerkocht,
    SUM(fr.Aantal * fr.RegelPrijs) AS TotaleOmzet
FROM FactuurRegel fr
GROUP BY TypeVerkoop
ORDER BY TotaleOmzet DESC;


-- QUERY 3: WERKDRUK PER DIERENARTS
-- Doel: Zien welke artsen de meeste consultaties uitvoeren om de werkdruk 
-- beter te verdelen of planningen aan te passen.
-- Technieken: JOIN, GROUP BY, ORDER BY

SELECT 
    p.Naam AS Dierenarts, 
    COUNT(cp.ConsultatieID) AS AantalConsultaties
FROM Personeelslid p
JOIN Consultatie_Personeel cp ON p.PersoneelID = cp.PersoneelID
WHERE p.Functie = 'Arts'
GROUP BY p.PersoneelID, p.Naam
ORDER BY AantalConsultaties DESC;


-- QUERY 4: MEDISCH DOSSIER VAN DIEREN MET EEN OPNAME
-- Doel: Een lijst genereren van alle dieren die opgenomen zijn geweest, 
-- inclusief de reden (diagnose) en duur van de opname, voor kwaliteitscontrole.
-- Technieken: JOIN, DATE FUNCTION (Verschil in dagen), WHERE

SELECT 
    h.Naam AS DierNaam, 
    d.Naam AS Soort,
    c.Datum AS ConsultDatum, 
    c.Diagnose, 
    o.StartDatum, 
    o.EindDatum,
    (o.EindDatum - o.StartDatum) AS AantalDagenOpname
FROM Opname o
JOIN Huisdier h ON o.HuisdierID = h.HuisdierID
JOIN Ras r ON h.RasID = r.RasID
JOIN Diersoort d ON r.DiersoortID = d.DiersoortID
JOIN Consultatie c ON o.ConsultatieID = c.ConsultatieID
WHERE o.EindDatum IS NOT NULL; -- Alleen afgeronde opnames


-- QUERY 5: GEMIDDELDE KOSTEN PER DIERSOORT
-- Doel: Weten welk type dier gemiddeld het duurst is in onderhoud bij de dierenarts.
-- Dit kan nuttig zijn voor marketing of advies aan nieuwe eigenaars.
-- Technieken: MULTIPLE JOINS, GROUP BY, AVG, ROUND

SELECT 
    d.Naam AS Diersoort, 
    ROUND(AVG(fr.RegelPrijs * fr.Aantal), 2) AS GemiddeldeKostPerRegel,
    SUM(fr.RegelPrijs * fr.Aantal) AS TotaalUitgegevenAanSoort
FROM Diersoort d
JOIN Ras r ON d.DiersoortID = r.DiersoortID
JOIN Huisdier h ON r.RasID = h.RasID
JOIN Afspraak a ON h.HuisdierID = a.HuisdierID
JOIN Consultatie c ON a.AfspraakID = c.AfspraakID
JOIN Factuur f ON f.Datum = c.Datum -- Koppeling via datum/klant is complexer, hier via vereenvoudigde aanname of directe link indien mogelijk in model
JOIN FactuurRegel fr ON f.FactuurID = fr.FactuurID
WHERE f.KlantID = h.EigenaarID -- Zekerheid dat factuur bij juiste eigenaar hoort
GROUP BY d.Naam
ORDER BY GemiddeldeKostPerRegel DESC;
