CREATE DATABASE football;

USE football;

CREATE TABLE eteam(
	Id CHAR(3) PRIMARY KEY,
	Teamname VARCHAR(20) NOT NULL,
	Coach VARCHAR(20) NOT NULL
);

CREATE TABLE game(
	Id INT PRIMARY KEY,
	Mdate DATE NOT NULL,
	Stadium VARCHAR(120) NOT NULL,
	Team1 CHAR(3) NOT NULL,
	Team2 CHAR(3) NOT NULL,
	CONSTRAINT FK_GAME_TEAM1 FOREIGN KEY(Team1) REFERENCES
eteam(Id),
	CONSTRAINT FK_GAME_TEAM2 FOREIGN KEY(Team2) REFERENCES
eteam(Id)
);

CREATE TABLE goal(
	Matchid INT NOT NULL,
	Teamid CHAR(3) NOT NULL,
	Player VARCHAR(20) NOT NULL,
	GTime INT NOT NULL,
	CONSTRAINT FK_GOAL_MID FOREIGN KEY(Matchid) REFERENCES
game(Id),
	CONSTRAINT FK_GOAL_TEAM FOREIGN KEY(Teamid) REFERENCES
eteam(Id)
);

INSERT INTO eteam VALUES('POL', 'Poland', 'Franciszek Smuda');
INSERT INTO eteam VALUES('RUS', 'Russia', 'Guus Hiddink');
INSERT INTO eteam VALUES('CZE', 'Czech Republic', 'Michal Bilek');
INSERT INTO eteam VALUES('GRE', 'Greece', 'Fernando Santos');

INSERT INTO game VALUES(1001, '2012-06-08', 'National Stadium, Warsaw', 'POL', 'GRE');
INSERT INTO game VALUES(1002, '2012-06-08', 'Stadion Miejski (Wroclaw)', 'RUS', 'CZE');
INSERT INTO game VALUES(1003, '2012-06-12', 'Stadion Miejski (Wroclaw)', 'GRE', 'CZE');
INSERT INTO game VALUES(1004, '2012-06-12', 'National Stadium, Warsaw', 'POL', 'RUS');

INSERT INTO goal VALUES(1001, 'POL', 'Robert Lewandowski', 17);
INSERT INTO goal VALUES(1001, 'GRE', 'Dimitris Salpingidis', 51);
INSERT INTO goal VALUES(1002, 'RUS', 'Alan Dzagoev', 15);
INSERT INTO goal VALUES(1004, 'RUS', 'Roman Pavlyuchenko', 82);