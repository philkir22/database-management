--SQL statements to create the tables from lab 8 as well as to demonstrate that they work
--Philip Kirwin
--11/10/16

--People
CREATE TABLE People(
	pid		    INT NOT NULL,
	firstName   TEXT,
	lastName    TEXT,
	address     TEXT,
	PRIMARY KEY(pid)
);

--Movies
CREATE TABLE Movies(
	movid               INT NOT NULL,
	name                TEXT,
	releaseYear         INT,
	MPAAnum             TEXT,
	domesticSalesUSD    INT,
	foreignSalesUSD     INT,
	diskSalesUSD        INT,
	PRIMARY KEY(movid)
);

--Actors
CREATE TABLE Actors(
	pid            INT NOT NULL REFERENCES People(pid),
	birthDate      DATETIME,
	hairColor      TEXT,
	eyeColor       TEXT,
	heightInches   INT,
	weight         INT,
	favoriteColor  TEXT,
	PRIMARY KEY(pid)
);

--Directors
CREATE TABLE Directors(
	pid                  INT NOT NULL REFERENCES People(pid),
	filmSchool           TEXT,
	favoriteLensMaker    TEXT,
	PRIMARY KEY(pid)
);

--ScreenActorsGuild
CREATE TABLE ScreenActorsGuild(
	pid                 INT NOT NULL REFERENCES Actors(pid),
	anneversaryDate     DATETIME,
	PRIMARY KEY(pid)
);

--DirectorsGuild
CREATE TABLE DirectorsGuild(
	pid                 INT NOT NULL REFERENCES Directors(pid),
	anneversaryDate     DATETIME,
	PRIMARY KEY(pid)
);

--Marriages
CREATE TABLE Marriages(
	pid           INT NOT NULL REFERENCES People(pid),
	spouseName    TEXT,
	PRIMARY KEY(pid)
);

--MovieActors
CREATE TABLE MovieActors(
	pid     INT NOT NULL REFERENCES Actors(pid),
	movid   INT NOT NULL REFERENCES Movies(movid),
	role    TEXT,
	PRIMARY KEY(pid, movid)
);

--MovieDirectors
CREATE TABLE MovieDirectors(
	pid     INT NOT NULL REFERENCES Directors(pid),
	movid   INT NOT NULL REFERENCES Movies(movid),
	PRIMARY KEY(pid, movid)
);

--Show all Directors with whom "Sean Connery" worked
SELECT firstName, lastName
FROM People
WHERE pid IN(SELECT pid
			 FROM MovieDirectors
			 WHERE movid IN(SELECT movid
							FROM MovieActors
						    WHERE pid IN(SELECT pid
										 FROM People
										 WHERE firstName = "Sean"
										   AND lastName = "Connery"
										)
										
						   )
			)