# Regie-script & Checklist: Video Demo Dierenartsenpraktijk

**Bestandsnaam:** `DF_video_team_XX` (bijv. .mp4 of .mkv)  
**Eis:** Video moet afspeelbaar zijn in VLC.  
**Tijdsduur:** Maximaal 15 minuten.

---

## 0. Voorbereiding (Niet opnemen!)

* **Schoonmaak:** Zorg dat je database in pgAdmin volledig leeg is (verwijder alle tabellen indien nodig).
* **Klaarzetten:**
    * Open je documenten: Conceptueel model (PDF), Logisch model (PDF) en Fysiek model (PNG of in DbSchema).
    * Open **pgAdmin 4**.
    * Laad de 4 SQL-scripts alvast in **aparte tabbladen** in de Query Tool, maar voer ze nog niet uit.
        * *Tab 1:* `DF_create_database_team_XX.sql`
        * *Tab 2:* `DF_insert_data_team_XX.sql`
        * *Tab 3:* `DF_query_team_XX.sql`
        * *Tab 4:* `DF_delete_database_team_XX.sql`
* **Techniek:** Test je microfoon. Zorg voor een rustige omgeving.
* **Zoom:** Gebruik `Ctrl +` (of `Command +`) in pgAdmin om de tekstgrootte iets te verhogen voor de leesbaarheid.

---

## Deel 1: Introductie & Modellen (0:00 - 03:00)

**Spreker:** *Start de opname.* "Welkom bij de demo van Team **XX** voor de case Dierenartsenpraktijk."

**Actie:** Open het **Conceptueel Datamodel** (PDF).

**Uitleg:**
* Wijs kort de kernentiteiten aan: `Klant`, `Huisdier`, `Personeel`.
* Benoem een specifieke, slimme ontwerpkeuze.  
    * *Voorbeeld:* "We hebben gekozen om rassen en diersoorten los te koppelen voor normalisatie."
    * *Voorbeeld:* "We hebben een ISA-relatie (subtypes) gebruikt voor het personeel om het verschil tussen artsen en verzorgers duidelijk te maken."

**Actie:** Switch naar het **Logisch Datamodel** (PDF).

**Uitleg:**
* Laat kort zien hoe de relaties zijn vertaald. Wijs bijvoorbeeld op een tussentabel die is ontstaan uit een N:M relatie (zoals `Arts_Specialisatie`).

**Actie:** Switch naar het **Fysiek Model** (DbSchema PNG of applicatie).

**Uitleg:**
* "Dit fysieke model vormt de basis voor ons SQL-script dat we nu gaan uitvoeren."

---

## Deel 2: De Database Bouwen (03:00 - 06:00)

**Spreker:** "We gaan nu de database live opbouwen in pgAdmin."

**Actie:** Switch naar **pgAdmin**.
* Klik met de rechtermuisknop op 'Tables' (links in de boomstructuur) en kies **Refresh**.
* Toon aan dat de lijst leeg is.

**Actie:** Ga naar het tabblad met `DF_create_database_team_XX.sql`.

**Uitleg:**
* "Hier is ons DDL-script. We maken eerst de onafhankelijke tabellen aan zoals `Klant` en `Diersoort`, en daarna pas de tabellen met Foreign Keys zoals `Huisdier` en `Factuur`."

**Actie:** Klik op de **Execute** knop (Play-icoon) of druk op `F5`.

**Controle:**
* Refresh de map 'Tables' aan de linkerkant opnieuw.
* Laat zien dat alle tabellen nu zijn verschenen.

---

## Deel 3: Data Toevoegen (06:00 - 08:00)

**Spreker:** "Nu de structuur er is, vullen we de tabellen met data."

**Actie:** Ga naar het tabblad met `DF_insert_data_team_XX.sql`.

**Uitleg:**
* "In dit script voegen we de casus-specifieke data toe, zoals het gezin Desmedt met hun kat Maurice. Daarnaast genereren we extra testdata om de query's zinvol te maken. We gebruiken expliciete ID's om de relaties correct te houden."

**Actie:** Klik op **Execute** (`F5`).
* Wijs onderaan op de melding *"Query returned successfully"*.

**Controle (Optioneel maar sterk):**
* Klik rechts op de tabel `Klant` > **View/Edit Data** > **All Rows**.
* Toon kort dat er daadwerkelijk namen in de tabel staan.

---

## Deel 4: Query's Uitvoeren (08:00 - 12:00)

**Spreker:** "We demonstreren nu 5 zinvolle query's die inzicht geven in de praktijk."

**Actie:** Ga naar het tabblad met `DF_query_team_XX.sql`.

*Loop de query's één voor één af. Selecteer de code van de specifieke query met je muis en druk op `F5` om **alleen die selectie** uit te voeren.*

1.  **Query 1:**
    * **Uitleg:** "Deze query toont [DOEL, bv. de top 3 klanten qua omzet]. Dit is nuttig voor de praktijk omdat [MOTIVATIE, bv. we deze klanten een korting willen sturen]."
    * **Actie:** Voer uit & toon resultaat.
2.  **Query 2:**
    * **Uitleg:** "Hier berekenen we [DOEL]. We gebruiken hier technische elementen zoals een `GROUP BY` en een `INNER JOIN`."
    * **Actie:** Voer uit & toon resultaat.
3.  **Query 3:**
    * **Uitleg:** [Korte uitleg wat we zien + waarom].
    * **Actie:** Voer uit.
4.  **Query 4:**
    * **Uitleg:** [Korte uitleg wat we zien + waarom].
    * **Actie:** Voer uit.
5.  **Query 5:**
    * **Uitleg:** [Korte uitleg wat we zien + waarom].
    * **Actie:** Voer uit.

---

## Deel 5: Afbreken & Outro (12:00 - 13:30)

**Spreker:** "Tot slot ruimen we de database netjes op."

**Actie:** Ga naar het tabblad met `DF_delete_database_team_XX.sql`.

**Uitleg:**
* "Zoals gevraagd in de opdracht maken we **geen** gebruik van `DROP CASCADE`. We verwijderen de tabellen in de correcte volgorde: eerst de kind-tabellen met foreign keys (zoals `FactuurRegel`), en daarna pas de ouders (zoals `Klant`)."

**Actie:** Klik op **Execute** (`F5`).

**Controle:**
* Refresh de map 'Tables' aan de linkerkant nog één keer.
* Toon aan dat de lijst weer helemaal leeg is.

**Spreker:** "Dit was onze presentatie. Bedankt voor het kijken."

---

## 💡 Belangrijke Tips voor de opname

* **Muisbewegingen:** Beweeg rustig en doelgericht met je muis. Ga niet als een gek rondzwaaien, dat is onrustig voor de kijker.
* **Foutje tijdens opname?** Geen paniek.
    * Als een query faalt, zeg rustig wat er mis ging (bijv. "Ah, ik was vergeten de vorige selectie weg te halen").
    * Fix het rustig.
    * Als het een grote fout is: stop de opname, reset je database en begin dat stukje opnieuw (als je kan editen).
* **Tijd:** Houd een stopwatch bij de hand. Ga niet te snel (wees verstaanbaar), maar blijf zeker onder de 15 minuten.
