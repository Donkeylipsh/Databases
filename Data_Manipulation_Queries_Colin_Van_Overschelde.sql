-- -----------------------------------------------------------------------------------------------
-- Author: Colin Van Overschelde
-- Date: 6/12/2018
-- Assignment: Project Step 8: Final Data Manipulation Queries
-- Description: Data Manipulation Queries contains the data manipulation queries to retrieve and update
--  the database for my Project
-- ------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Get All Matches
-- --------------------------------------------------------------------------------
SELECT m_id, m_time, m_day, m_league, m_home, m_away, t1.t_name AS home, t2.t_name AS away, m_result, r.r_value AS result FROM `match` 
LEFT JOIN `team` t1 ON m_home = t1.t_id 
LEFT JOIN `team` t2 ON m_away = t2.t_id 
INNER JOIN `result` r ON m_result = r_id ORDER BY m_day ASC

-- --------------------------------------------------------------------------------
-- Get a target match by id
-- --------------------------------------------------------------------------------
SELECT M.m_time, M.m_day, M.m_league, M.m_home, M.m_away, M.m_result, HT.t_name AS home, AT.t_name AS away, R.r_value, L.l_skill_rank, L.l_division, L.l_day 
FROM `match` M LEFT JOIN team HT ON HT.t_id = M.m_home 
LEFT JOIN team AT ON AT.t_id = M.m_away 
INNER JOIN result R ON R.r_id = M.m_result 
INNER JOIN league L ON L.l_id = M.m_league WHERE M.m_id = [someMatchId]

-- --------------------------------------------------------------------------------
-- Delete a target match
-- --------------------------------------------------------------------------------
DELETE FROM `match` WHERE m_id = [someMatchId]

-- --------------------------------------------------------------------------------
-- Update a match
-- --------------------------------------------------------------------------------
UPDATE `match` SET m_time = [someTime], m_day = [someDate], m_home = [someTeamId], m_away = [someTeamId], m_result = [someResultId] WHERE m_id = [someMatchId]

-- --------------------------------------------------------------------------------
-- Get all leagues
-- --------------------------------------------------------------------------------
SELECT l_id, l_day, l_skill_rank, l_division, l_start_date, l_end_date FROM `league` 
ORDER BY l_day ASC, l_skill_rank DESC, l_division ASC;

-- --------------------------------------------------------------------------------
-- Get all teams in a target league
-- --------------------------------------------------------------------------------
SELECT t_id, t_name FROM `team` t
INNER JOIN `league_team` lt ON t.t_id = lt.t_id
WHERE lt.l_id = [someLeagueId];

-- --------------------------------------------------------------------------------
-- Get a target team
-- --------------------------------------------------------------------------------
SELECT t_id, t_name FROM `team` WHERE t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Delete a target team
-- --------------------------------------------------------------------------------
DELETE FROM `team` WHERE t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Get all the players for a target team
-- --------------------------------------------------------------------------------
SELECT t.t_id, p.p_name, p.p_tag FROM `team` t 
INNER JOIN `player_team` pt ON t.t_id = pt.t_id 
INNER JOIN `player` p ON pt.p_id = p.p_id 
WHERE t.t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Get all the matches for a target team
-- --------------------------------------------------------------------------------
SELECT t.t_id, t1.t_id, m.m_day, m.m_time, m.m_home, m.m_away, t1.t_name as home, t2.t_name as away, r_value FROM `team` t 
INNER JOIN `match` m ON t.t_id = m.m_home OR t.t_id = m.m_away 
INNER JOIN `team` t1 ON m.m_home = t1.t_id 
INNER JOIN `team` t2 on m.m_away = t2.t_id 
INNER JOIN `result` r ON m.m_result = r.r_id 
WHERE t.t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Delete a target league
-- --------------------------------------------------------------------------------
DELETE FROM `league` WHERE l_id = [someLeagueId]

-- --------------------------------------------------------------------------------
-- Get a target league
-- --------------------------------------------------------------------------------
SELECT l_day, l_skill_rank, l_division, l_start_date, l_end_date FROM league 
WHERE l_id = [someLeagueId];

-- --------------------------------------------------------------------------------
-- Get all teams in a target league
-- --------------------------------------------------------------------------------
SELECT t.t_name, t.t_id FROM team t INNER JOIN league_team lt ON lt.t_id=t.t_id 
INNER JOIN league l ON l.l_id = lt.l_id WHERE l.l_id = [someLeagueId];

-- --------------------------------------------------------------------------------
-- Get all matches in a target league
-- --------------------------------------------------------------------------------
SELECT m_id, m_time, m_day, m_league, m_home, m_away, t1.t_name AS home, t2.t_name AS away, m_result, r.r_value AS result 
FROM `match` 
INNER JOIN `team` t1 ON m_home = t1.t_id 
INNER JOIN `team` t2 ON m_away = t2.t_id 
INNER JOIN `result` r ON m_result = r_id 
WHERE m_league = [someleagueId] 
ORDER BY m_day ASC, m_time ASC;

-- --------------------------------------------------------------------------------
-- Get all players and their teams
-- --------------------------------------------------------------------------------
SELECT P.p_id, P.p_tag, P.p_name , T.t_name FROM `player` P 
LEFT JOIN `player_team` PT ON PT.p_id = P.p_id 
LEFT JOIN `team` T ON T.t_id = PT.t_id 
ORDER BY T.t_name ASC;

-- --------------------------------------------------------------------------------
-- Get all players for a target team
-- --------------------------------------------------------------------------------
SELECT P.p_id, P.p_tag, P.p_name, T.t_name, T.t_id FROM `player` P 
LEFT JOIN `player_team` PT ON PT.p_id = P.p_id 
LEFT JOIN `team` T ON T.t_id = PT.t_id 
WHERE T.t_id = [someTeamId]
ORDER BY P.p_name ASC;

-- --------------------------------------------------------------------------------
-- Get a target player
-- --------------------------------------------------------------------------------
SELECT P.p_id, P.p_tag, P.p_name FROM `player` P 
WHERE p_id = [somePlayerId];

-- --------------------------------------------------------------------------------
-- Delete a target player
-- --------------------------------------------------------------------------------
DELETE FROM `player` WHERE p_id = [somePlayerId];

-- --------------------------------------------------------------------------------
-- Get all teams for a target player
-- --------------------------------------------------------------------------------
SELECT p.p_id, t.t_name FROM `player` p 
INNER JOIN `player_team` pt ON p.p_id = pt.p_id 
INNER JOIN `team` t ON pt.t_id = t.t_id 
WHERE p.p_id = [somePlayerId];

-- --------------------------------------------------------------------------------
-- Get all matches for a target player
-- --------------------------------------------------------------------------------
SELECT p.p_id, t1.t_id, m.m_day, m.m_time, m.m_home, m.m_away, t2.t_name as home, t3.t_name as away, r_value FROM `player` p 
INNER JOIN `player_team` pt ON p.p_id = pt.p_id 
INNER JOIN `team` t1 ON pt.t_id = t1.t_id 
INNER JOIN `match` m ON t1.t_id = m.m_home OR t1.t_id = m.m_away 
INNER JOIN `team` t2 ON m.m_home = t2.t_id 
INNER JOIN `team` t3 on m.m_away = t3.t_id 
INNER JOIN `result` r ON m.m_result = r.r_id 
WHERE p.p_id = [somePlayerId]
ORDER BY m.m_day ASC;

-- --------------------------------------------------------------------------------
-- Get all result values
-- --------------------------------------------------------------------------------
SELECT r_id, r_value FROM result WHERE 1

-- --------------------------------------------------------------------------------
-- Get all matches for a target player where m_date >= current date
-- --------------------------------------------------------------------------------
SELECT m.m_id, m.m_day, m.m_time, m.m_home, m.m_away, m_result FROM `match` m
INNER JOIN team t ON m.m_home = t.t_id OR m.m_away = t.t_id
INNER JOIN player_team pt ON t.t_id = pt.t_id
INNER JOIN player p ON pt.p_id = p.p_id
WHERE p.p_tag = [somePlayerTag] and m.date >= [current_date];

-- --------------------------------------------------------------------------------
-- Remove player from team
-- --------------------------------------------------------------------------------
DELETE FROM player_team WHERE p_id = [somePlayerId] and t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Add player to a team
-- --------------------------------------------------------------------------------
INSERT INTO player_team (p_id, t_id) values
    ([some_p_id], [some_t_id]);

-- --------------------------------------------------------------------------------
-- Get the home win count for a target team
-- --------------------------------------------------------------------------------
SELECT l_id, l_day, l_skill_rank, l_division, l_start_date, l_end_date FROM league;

-- --------------------------------------------------------------------------------
-- Remove a league
-- --------------------------------------------------------------------------------
DELETE FROM league WHERE l_id = [someLeagueId];

-- --------------------------------------------------------------------------------
-- Create a league
-- --------------------------------------------------------------------------------
INSERT INTO league (l_day, l_skill_rank, l_division, l_start_date, l_end_date) values 
([someDay], [someRank], [someDivision], [someStartDate], [someEndDate]);

-- --------------------------------------------------------------------------------
-- Get the teams
-- --------------------------------------------------------------------------------
SELECT t_id, t_name FROM league;

-- --------------------------------------------------------------------------------
-- Create new team
-- --------------------------------------------------------------------------------
INSERT INTO team (t_name) values ([someTeamName]);

-- --------------------------------------------------------------------------------
-- Delete team
-- --------------------------------------------------------------------------------
DELETE FROM team WHERE t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Add team to league
INSERT INTO league_team (l_id, t_id) values ([someLeagueId], [someTeamId]);
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Remove a team form a league
-- --------------------------------------------------------------------------------
DELETE FROM league_team WHERE t_id = [someTeamId] and l_id = [someLeagueId];

-- --------------------------------------------------------------------------------
-- Remove player from team
-- --------------------------------------------------------------------------------
DELETE FROM player_team WHERE p_id = [somePlayerId] and t_id = [someTeamId];

-- --------------------------------------------------------------------------------
-- Add player to a team
-- --------------------------------------------------------------------------------
INSERT INTO player_team (p_id, t_id) values
    ([some_p_id], [some_t_id]);