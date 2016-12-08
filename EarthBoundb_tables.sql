--Locations
CREATE TABLE Locations(
    lid INT NOT NULL UNIQUE,
    locationName TEXT NOT NULL,
    PRIMARY KEY(lid)
);

--YourSanctuary
CREATE TABLE YourSanctuary(
    lid INT NOT NULL UNIQUE REFERENCES Locations(lid),
    nessEnvisions TEXT NOT NULL,
    melodyLearned INT NOT NULL UNIQUE,
    PRIMARY KEY(lid)
);

--Towns
CREATE TABLE Towns(
    lid INT NOT NULL UNIQUE REFERENCES Locations(lid),
    humanPopulation INT,
    dogPopulation INT,
    zombiePopulation INT,
    averageTempF INT,
    annualRainfallInches INT,
    PRIMARY KEY(lid)
);

--Items
CREATE TABLE Items(
    itemId INT NOT NULL UNIQUE,
    itemName TEXT NOT NULL,
    itemCostDollars INT,
    itemDescription TEXT NOT NULL,
    PRIMARY KEY(itemId)
);

--HealingItem
CREATE TABLE HealingItems(
    itemId INT NOT NULL UNIQUE REFERENCES Items(itemId),
    HPRestored INT,
    PPRestored INT,
    PooHPRestored INT,
    PRIMARY KEY(itemId)
);

--Weapons
CREATE TABLE Weapons(
    itemId INT NOT NULL UNIQUE REFERENCES Items(itemId),
    offenseUpBy INT NOT NULL,
    errorRate DECIMAL (8, 7),
    PRIMARY KEY(itemId)
);

--Armor
CREATE TABLE Armor(
    itemId INT NOT NULL UNIQUE REFERENCES Items(itemId),
    defenseUpBy INT NOT NULL,
    PRIMARY KEY(itemId)
);

--ContainsItem
CREATE TABLE ContainsItem(
    lid INT NOT NULL REFERENCES Locations(lid),
    itemId INT NOT NULL REFERENCES Items(itemId),
    PRIMARY KEY(lid,itemId)
);

--Characters
CREATE TABLE Characters(
    cid INT NOT NULL UNIQUE,
    characterName TEXT NOT NULL,
    characterAge INT,
    lid INT NOT NULL REFERENCES Locations(lid),
    PRIMARY KEY(cid)
);

--NonPlayerCharacters
CREATE TABLE NonPlayerCharacters(
    cid INT NOT NULL UNIQUE REFERENCES Characters(cid),
    dialogue TEXT NOT NULL,
    PRIMARY KEY(cid)
);

--QuestGivers
CREATE TABLE QuestGivers(
    cid INT NOT NULL UNIQUE REFERENCES NonPlayerCharacters(cid),
    questTrigger TEXT NOT NULL,
    PRIMARY KEY(cid)
);

--PlayerCharacters
CREATE TABLE PlayerCharacters(
    cid INT NOT NULL UNIQUE REFERENCES Characters(cid),
    currentLevel INT NOT NULL,
    maxHitPoints INT NOT NULL,
    maxPsychicPoints INT NOT NULL,
    currentHitPoints INT NOT NULL,
    currentPsychicPoints INT NOT NULL,
    characterOffense INT NOT NULL,
    characterDefense INT NOT NULL,
    characterSpeed INT NOT NULL,
    characterIQ INT NOT NULL,
    characterGuts INT NOT NULL,
    PRIMARY KEY(cid)
);

--Inventory
CREATE TABLE Inventory(
    cid INT NOT NULL REFERENCES PlayerCharacters(cid),
    itemId INT NOT NULL REFERENCES Items(itemId),
    itemQuantity INT NOT NULL,
    PRIMARY KEY(cid, itemId)
);

--Enemies
CREATE TABLE Enemies(
    eid INT NOT NULL UNIQUE,
    enemyName TEXT NOT NULL,
    enemyHitPoints INT NOT NULL,
    enemyPsychicPoints INT NOT NULL,
    enemyOffense INT NOT NULL,
    enemyDefense INT NOT NULL,
    enemySpeed INT NOT NULL,
    enemyIQ INT NOT NULL,
    enemyGuts INT NOT NULL,
    enemyEXPReward INT NOT NULL,
    enemyBountyDollars INT NOT NULL,
    enemyStatus TEXT NOT NULL,
    PRIMARY KEY(eid)
);

--EnemyHabitat
CREATE TABLE EnemyHabitat(
    eid INT NOT NULL REFERENCES Enemies(eid),
    lid INT NOT NULL REFERENCES Locations(lid),
    PRIMARY KEY(eid, lid)
);

--EnemyLoot
CREATE TABLE EnemyLoot(
    eid INT NOT NULL REFERENCES Enemies(eid),
    itemId INT NOT NULL REFERENCES Items(itemId),
    dropChance DECIMAL(8,7) NOT NULL,
    PRIMARY KEY(eid, itemId)
);

--Battle
CREATE TABLE Battle(
    bid INT NOT NULL UNIQUE,
    cid INT NOT NULL REFERENCES PlayerCharacters(cid),
    eid INT NOT NULL REFERENCES Enemies(eid),
    victory BOOLEAN,
    PRIMARY KEY(bid)
);

--PSI
CREATE TABLE PSI(
    PSId INT NOT NULL UNIQUE,
    psiName TEXT NOT NULL,
    psiDescription TEXT NOT NULL,
    powerLevel TEXT NOT NULL,
    PPCost INT NOT NULL,
    target TEXT NOT NULL,
    PRIMARY KEY(PSId)
);

--OffensePSI
CREATE TABLE OffensePSI(
    PSId INT NOT NULL UNIQUE REFERENCES PSI(PSId),
    damageDealt INT NOT NULL,
    statusInflicted TEXT,
    PRIMARY KEY(PSId)
);

--RecoverPSI
CREATE TABLE RecoverPSI(
    PSId INT NOT NULL UNIQUE REFERENCES PSI(PSId),
    HPRestored INT,
    PPRestored INT,
    PRIMARY KEY(PSId)
);

--AssistPSI
CREATE TABLE AssistPSI(
    PSId INT NOT NULL UNIQUE REFERENCES PSI(PSId),
    statusInflicted TEXT,
    statAffected TEXT,
    statModifier INT,
    PRIMARY KEY(PSId)
);

--OtherPSI
CREATE TABLE OtherPSI(
    PSId INT NOT NULL UNIQUE REFERENCES PSI(PSId),
    PSIEffect TEXT,
    PSILimitations TEXT,
    PRIMARY KEY(PSId)
);

--CharacterHasPSI
CREATE TABLE CharacterHasPSI(
    cid INT NOT NULL REFERENCES PlayerCharacters(cid),
    PSId INT NOT NULL REFERENCES PSI(PSId),
    PRIMARY KEY(cid, PSId)
);

--EnemyHasPSI
CREATE TABLE EnemyHasPSI(
    eid INT NOT NULL REFERENCES Enemies(eid),
    PSId INT NOT NULL REFERENCES PSI(PSId),
    PRIMARY KEY(eid, PSId)
);

--Insert statements
INSERT INTO Locations(lid, locationName)
VALUES (1, 'Onett'),
       (2, 'Twoson'),
       (3, 'Threed'),
       (4, 'Fourside'),
       (5, 'Giant Step'),
       (6, 'Lilliput Steps'),
       (7, 'Milky Well'),
       (8, 'Winters'),
       (9, 'Dalaam'),
       (10, 'Grapefruit Falls'),
       (11, 'Peaceful Rest Valley');
	   
INSERT INTO YourSanctuary(lid, nessEnvisions, melodyLearned)
VALUES (5, 'A small, cute puppy', 1),
       (6, 'A baby in a red cap', 2),
	   (7, '"His mother, telling him to be a thoughtful, strong boy', 3);
	   
INSERT INTO Towns(lid, humanPopulation, dogPopulation, zombiePopulation, averageTempF,annualRainfallInches)
VALUES(1, 3500, 2, 0, 72, 10),
      (2, 3711, 1, 0, 72, 12),
      (3, 1500, 2, 2000, 62, 56),
      (4, 313003, 0, 0, 67, 32),
      (8, 506, 0, 0, 1, 20),
      (9, 1033, 0, 0, 70, 0);
	  
INSERT INTO Items (itemId, itemName, itemCostDollars, itemDescription)
VALUES(1, "Cracked Bat", 18, "Ness can equip this weapon."),
      (2, "Fry Pan", 56, "Paula can equip this weapon."),
      (3, "Laser Gun", 0, "Jeff can equip this weapon."),
      (4, "Copper Bracelet", 349, "Must be equipped on your arm. It increses your Defense."),
      (5, "Cookie", 7, "When eaten, you revover about 6 HP."),
      (6, "Hamburger", 14, "When eaten, you recover about 50 HP. 100% beef."),
      (7, "Hard Hat", 298, "Should be worn when searching for buried treasure, or while you are at the construction site."),
      (8, "Magic Tart", 480, "Replenishes 20 PP."),
	  (9, 'Picnic Lunch', 24, 'When eaten, you recover about 80 HP. There is even a slice of your favorite cake!');;

INSERT INTO HealingItems(itemId, HPRestored, PPRestored, PooHPRestored)
VALUES(5, 6, 0, 6),
      (6, 48, 0, 6),
      (7, 0, 20, 0),
	  (9, 84, 0, 6);
	   
INSERT INTO Weapons(itemId, offenseUpBy, errorRate)
VALUES(1, 4, 0.0625),
      (2, 10, 0.0625000),
      (3, 48, 0.0000000);
	  
INSERT INTO Armor(itemId, defenseUpBy)
VALUES(4, 10),
      (7, 15);
	  
INSERT INTO ContainsItem(lid, itemId)
VALUES(1, 1),
      (2, 2),
      (8, 3),
      (2, 4),
      (3, 4),
      (1, 5),
      (2, 5),
      (3, 5),
      (4, 5),
      (8, 5),
      (1, 6),
      (2, 6),
      (4, 6),
      (3, 7),
      (11, 7),
	  (4, 9),
      (8, 9);

INSERT INTO Characters(cid, characterName, characterAge, lid)
VALUES(1, 'Ness', 13, 1),
      (2, 'Paula Polestar', 13, 2),
      (3, 'Jeff Andonuts', 13, 8),
      (4, 'Poo', 14, 9),
      (5, 'Pokey Minch', 13, 1),
      (6, 'Apple Kid', 13, 2),
      (7, 'Geldegarde Monotoli', 50, 4),
      (8, 'The Camera Man', 60, 1);
	  
INSERT INTO NonPlayerCharacters(cid, dialogue)
VALUES(5, 'Spankety, spankety, spankety!'),
      (6, 'Yeah, everything is...*KABOOOOM!* Uh, Ivegotsomeproblemsheregottago, bye!'),
      (7, 'Look at my skinny arms, thin body, and gray hair... Ive become so weak since I lost the Mani Mani Statue.'),
      (8, 'Look at the camera... Ready... Say, "fuzzy pickles."');
      
INSERT INTO QuestGivers(cid, questTrigger)
VALUES(6, 'Pay $100'),
      (7, 'Reach the top of the Monotoli Building');
	  

INSERT INTO PlayerCharacters(cid, currentLevel, maxHitPoints, maxPsychicPoints, currentHitPoints, currentPsychicPoints, characterOffense, characterDefense, characterSpeed, characterIQ, characterGuts)
VALUES(1, 35, 277, 95, 277, 95, 100, 65, 20, 19, 25),
      (2, 32, 137, 125, 137, 125, 70, 74, 32, 25, 17),
      (3, 31, 156, 0, 156, 0, 80, 66, 22, 29, 17),
      (4, 30, 175, 112, 175, 112, 94, 48, 27, 23, 19);

INSERT INTO Inventory(cid, itemId, itemQuantity)
VALUES(1, 1, 1),
      (2, 2, 1),
      (3, 3, 1),
      (1, 4, 1),
      (4, 8, 3),
      (3, 6, 4),
      (2, 5, 2),
      (2, 7, 1),
      (1, 7, 1);
	  
INSERT INTO Enemies(eid, enemyName, enemyHitPoints, enemyPsychicPoints, enemyOffense, enemyDefense, enemySpeed, enemyIQ, enemyGuts, enemyEXPReward, enemyBountyDollars, enemyStatus)
VALUES(1, 'Spiteful Crow', 24, 0, 5, 3, 77, 0, 0, 3, 5, 'Common'),
      (2, 'New Age Retro Hippie', 87, 0, 19, 14, 5, 0, 10, 160, 23, 'Common'),
      (3, 'Urban Zombie', 171, 0, 31, 24, 10, 0, 15, 700, 58, 'Common'),
      (4, 'Titanic Ant', 235, 102, 19, 23, 6, 20, 9, 685, 150, 'Boss'),
      (5, 'Master Belch', 650, 0, 50, 88, 16, 0, 20, 12509, 664, 'Boss'),
	  (6, 'Ranboob', 232, 42, 41, 63, 20, 8, 1, 2486, 158, 'Common');

INSERT INTO EnemyHabitat(eid, lid)
VALUES(1, 1),
      (2, 2),
      (3, 3),
      (4, 5),
      (5, 10),
      (6, 7);
	  
INSERT INTO EnemyLoot(eid, itemId, dropChance)
VALUES(1, 5, 1),
      (3, 6, 0.03125),
      (6, 9, 0.015625);
	  

INSERT INTO Battle(bid, cid, eid)
VALUES(1, 1, 4),
      (2, 2, 1),
      (3, 1, 5),
      (4, 2, 5),
      (5, 3, 5),
      (6, 4, 6);
	  
INSERT INTO PSI(PSId, psiName, psiDescription, powerLevel, PPCost, target)
VALUES(1, 'Lifeup', 'Restores 300 HP to one person.', 'beta', 8, 'one ally'),
      (2, 'PK Fire', 'Fire bursts from the fingers and a row of enemies take about 240 points of damage each.', 'gamma', 20, 'one row of foes'),
      (3, 'Brainshock', 'Makes one enemy feels strange.', 'alpha', 10, 'one enemy'),
      (4, 'Teleport', 'Allows you to immediately return to a place where you have already been. You need a good running approach for this to work.', 'alpha', 2, 'all allies'),
      (5, 'PK Rockin', 'A deadly PSI attack which only Ness can use. It is a psychokinetic wave generated by concentration that deals each enemy about 640 points of damage.', 'omega', 98, 'all enemies'),
      (6, 'PSI Magnet', 'Grabs 2-8 points of PP from one enemy and adds it to your own.', 'alpha', 0, 'one enemy'),
      (7, 'Offense Up', 'Increase one persons Offense for the duration of the current battle.', 'alpha', 10, 'one ally'),
      (8, 'Healing', 'In addition to the effects of Healing α, this cures poisonings, nausea, feeling strange and uncontrollable crying.', 'beta', 8, 'one ally'),
      (9, 'PK Starstorm', 'The method of "shaking off the stars" which Poo learned in his training. It deals about 720 points of damage to each enemy.', 'omega', 42, 'all enemies'),
      (10, 'Lifeup', 'Restores 400 HP to everyone.', 'omega', 24, 'all allies'),
      (11, 'Shield', 'Protect one person with the shield of light. It reduces the damage caused by enemy attacks by 50%.', 'alpha', 6, 'one ally'),
	  (12, 'PK Freeze', 'Causes a very cold wind to swirl around one enemy, inflicting about 360 points of damage. May freeze the enemy completely.', 'beta', 9, 'one enemy');

INSERT INTO OffensePSI(PSId, damageDealt, statusInflicted)
VALUES(2, 240, 'none'),
      (5, 640, 'none'),
      (9, 720, 'none'),
      (12, 360, 'frozen');
	  
INSERT INTO RecoverPSI(PSId, HPRestored, PPRestored)
VALUES(1, 300, 0),
      (6, 0, 5),
      (10, 400, 0);

INSERT INTO CharacterHasPSI(cid, PSId)
VALUES(1, 1),
      (4, 1),
      (2, 2),
      (4, 2),
      (4, 3),
      (1, 4),
      (4, 4),
      (1, 5),
      (2, 6),
      (4, 6),
      (2, 7),
      (1, 8),
      (4, 8),
      (4, 9),
      (1, 10),
      (1, 11),
      (4, 11),
      (2, 12),
      (4, 12);

INSERT INTO EnemyHasPSI(eid, PSId)
VALUES(4, 6),
      (6, 11);

--Views
CREATE VIEW CharacterAndPSI AS
    SELECT characterName, maxPsychicPoints, psiName, powerLevel
    FROM PlayerCharacters, Characters, CharacterHasPSI, PSI
    WHERE PlayerCharacters.cid = Characters.cid
      AND PlayerCharacters.cid = CharacterHasPSI.cid
      AND PSI.PSId = CharacterHasPSI.PSId;

CREATE VIEW EnemyAndPSI AS
    SELECT enemyName, enemyPsychicPoints, psiName, powerLevel
    FROM Enemies, EnemyHasPSI, PSI
    WHERE Enemies.eid = EnemyHasPSI.eid
      AND PSI.PSId = EnemyHasPSI.PSId;

CREATE VIEW AreaBoss AS
    SELECT locationName, enemyName, enemyHitPoints, enemyEXPReward, enemyBountyDollars
    FROM Locations, Enemies, EnemyHabitat
    WHERE Locations.lid = EnemyHabitat.lid
      AND Enemies.eid = EnemyHabitat.eid
      AND Enemies.enemyStatus = 'Boss';

--Stored Procedues
CREATE OR REPLACE FUNCTION findPerson(TEXT) RETURNS TABLE(characterName TEXT, locationName TEXT) AS
$$
DECLARE
    soughtPerson  TEXT := $1;
BEGIN
    RETURN QUERY 
    SELECT Characters.characterName, Locations.locationName
    FROM Characters, Locations
    WHERE Locations.lid = Characters.lid
      AND Characters.characterName = soughtPerson;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getCharacterPSI(TEXT) RETURNS TABLE(characterName TEXT, psiName TEXT, powerLevel TEXT) AS
$$
DECLARE
    searchCharacter  TEXT := $1;
BEGIN
    RETURN QUERY 
    SELECT Characters.characterName, PSI.psiName, PSI.powerLevel
    FROM Characters, PSI, CharacterHasPSI
    WHERE Characters.cid = CharacterHasPSI.cid
      AND PSI.PSId = CharacterHasPSI.PSId
      AND Characters.characterName = searchCharacter;
END;
$$ LANGUAGE plpgsql;	  

--Triggers 
CREATE OR REPLACE FUNCTION battleVictory() RETURNS TRIGGER AS
$$
BEGIN
    IF new.enemyHitPoints <= 0
    THEN
        UPDATE Battle
        SET victory = true
        WHERE Battle.eid = new.eid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER battleVictory
AFTER UPDATE on Enemies
FOR EACH ROW
EXECUTE PROCEDURE battleVictory();


CREATE OR REPLACE FUNCTION battleDefeat() RETURNS TRIGGER AS
$$
BEGIN
    IF new.currentHitPoints <= 0
    THEN
        UPDATE Battle
        SET victory = false
        WHERE Battle.cid = new.cid;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER battleDefeat
AFTER UPDATE on PlayerCharacters
FOR EACH ROW
EXECUTE PROCEDURE battleDefeat();

--Reports
--Shows current inventory size of each character
SELECT characterName, SUM(itemQuantity) AS InventorySize
FROM PlayerCharacters INNER JOIN Characters ON PlayerCharacters.cid = Characters.cid
                      INNER JOIN Inventory ON PlayerCharacters.cid = Inventory.cid
GROUP BY characterName;

--Shows a list of PSI that can only be learned by one character
SELECT psiName, powerLevel, COUNT(characterName) AS UserCount
FROM Characters, PlayerCharacters, CharacterHasPSI, PSI
WHERE Characters.cid = PlayerCharacters.cid
  AND PlayerCharacters.cid = CharacterHasPSI.cid
  AND CharacterHasPSI.PSId = PSI.PSId
GROUP BY psiName, PowerLevel
HAVING COUNT(characterName) = 1;

--Security
CREATE ROLE admin;
GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;

CREATE ROLE player;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM player;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO player;
GRANT INSERT ON Inventory, Battle TO Player;
GRANT UPDATE ON Inventory, Battle, PlayerCharacters TO Player;