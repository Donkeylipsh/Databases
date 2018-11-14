-- -----------------------------------------------------------------------------------------------
-- Author: Colin Van Overschelde
-- Date: 5/27/2018
-- Assignment: Project Step 5: HTML Pages + Data Manipulation Queries
-- Description: Data Definition Queries contains the data defintion queries to create the database
--				for my Project and the INSERT queries to populate my database with sample data
-- ------------------------------------------------------------------------------------------------

-- Create the player table
CREATE TABLE player (
	p_id int(11) NOT NULL AUTO_INCREMENT, 
	p_tag varchar(255) NOT NULL, 
	p_name varchar(255), 
	PRIMARY KEY(`p_id`),
	CONSTRAINT UNIQUE(p_tag)
)ENGINE=INNODB;

-- Create the team table
CREATE TABLE team (
	t_id int(11) NOT NULL AUTO_INCREMENT, 
	t_name varchar(255) NOT NULL, 
	PRIMARY KEY(t_id)
)ENGINE=INNODB;

-- Create the player_team table
CREATE TABLE player_team (
	p_id int(11) NOT NULL, 
	t_id int(11) NOT NULL, 
	PRIMARY KEY(p_id, t_id), 
	FOREIGN KEY(p_id) REFERENCES player(p_id) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY(t_id) REFERENCES team(t_id) ON DELETE CASCADE ON UPDATE CASCADE
)engine=innodb;

-- Create the league table
CREATE TABLE league (
	l_id int(11) NOT NULL AUTO_INCREMENT, 
	l_day int(1), 
	l_skill_rank int(1),
	l_division int(2), 
	l_start_date date, 
	l_end_date date, 
	PRIMARY KEY(l_id),
	CONSTRAINT UNIQUE(l_skill_rank, l_division, l_day)
)engine=innoDB;

-- Create the league-team table
CREATE TABLE league_team (
	l_id int(11) NOT NULL, 
	t_id int(11) NOT NULL, 
	PRIMARY KEY(l_id, t_id),
	FOREIGN KEY(l_id) REFERENCES league(l_id) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY(t_id) REFERENCES team(t_id) ON DELETE CASCADE ON UPDATE CASCADE
)engine=innoDB;

-- Create the result table
CREATE TABLE result (
	r_id int(11) NOT NULL AUTO_INCREMENT,
	r_value varchar(255),
	PRIMARY KEY(r_id),
	CONSTRAINT UNIQUE(r_value)
)engine=innoDB;

-- Create the match table
CREATE TABLE `match` (
	m_id int(11) NOT NULL AUTO_INCREMENT, 
	m_time time(0) NOT NULL, 
	m_day date NOT NULL, 
	m_league int(11) NOT NULL, 
	m_home int(11) NOT NULL, 
	m_away int(11) NOT NULL, 
	m_result int(11) NOT NULL,  
	PRIMARY KEY(m_id),
	FOREIGN KEY(m_league) REFERENCES league(l_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(m_home) REFERENCES team(t_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(m_away) REFERENCES team(t_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(m_result) REFERENCES result(r_id) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=innoDB;

-- Dump data into player table
INSERT INTO player (p_tag, p_name) values
	("tackleberry#1850", "tackleberry"),
	("seagull#123", "seagull"),
	("Harbleu#4512", "Harbleu"),
	("Calvin#123", "Calvin"),
	("xQc#155", "xQc"),
	("iddqd#23", "iddqd"),
	("sinatraa#839", "sinatraa"),
	("fissure#45", "Fissure"),
	("jake#457", "Jake");

-- Dump data into team table
INSERT INTO team (t_name) values
	("Spitfire"),
	("Fuel"),
	("Outlaws"),
	("XL"),
	("Shock"),
	("Gladiators"),
	("Valiant"),
	("Dragons"),
	("Mayhem"),
	("Uprising"),
	("Dynasty"),
	("Fusion");

-- Dump data into the player_team table
INSERT INTO player_team (p_id, t_id) values
	(1, 10),
	(2, 2),
	(3, 10),
	(4, 10),
	(5, 8),
	(6, 5),
	(7, 5),
	(8, 6),
	(9, 3);

-- Dump data into the league table
INSERT INTO league (l_day, l_skill_rank, l_division, l_start_date, 
l_end_date) values
	(0, 5, 3, "2018-03-01", "2018-06-30"),
	(1, 3, 1, "2018-04-15", "2018-08-30"),
	(2, 2, 2, "2018-01-17", "2018-04-30"),
	(3, 4, 1, "2018-02-20", "2018-05-15"),
	(4, 0, 4, "2018-03-29", "2018-09-17"),
	(5, 1, 1, "2018-09-14", "2018-12-30"),
	(6, 6, 2, "2018-11-01", "2019-02-27");

-- Dump data into the league_team table
INSERT INTO league_team (l_id, t_id) values
	(1, 1),
	(1, 2),
	(2, 3),
	(2, 4),
	(3, 5),
	(3, 6),
	(4, 7),
	(4, 8),
	(5, 9),
	(5, 10),
	(6, 11);

-- Dump result data into result table
INSERT INTO result (r_value) values 
	("Unplayed"),
	("Canceled"),
	("Home Forfeit"),
	("Away Forfeit"),
	("Home Wins"),
	("Away Wins"),
	("Draw");

-- Dump match data into the match table
INSERT INTO `match` (m_time, m_day, m_league, m_home, m_away, m_result) values
	("18:00:00", "2018-04-29", 2, 3, 4, 1),
	("19:00:00", "2018-05-29", 3, 5, 6, 2),
	("20:00:00", "2018-05-08", 1, 1, 2, 3),
	("17:00:00", "2018-06-13", 4, 8, 7, 4),
	("18:00:00", "2018-07-22", 5, 10, 9, 5),
	("18:00:00", "2018-04-12", 2, 3, 4, 6),
	("19:00:00", "2018-03-29", 3, 5, 6, 7),
	("20:00:00", "2018-02-08", 1, 1, 2, 1),
	("17:00:00", "2018-01-13", 4, 8, 7, 2),
	("18:00:00", "2018-02-22", 5, 10, 9, 3);