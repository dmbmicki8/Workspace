--1--What range of years for baseball games played does the provided database cover?
SELECT 
	MIN(yearid) AS earliest,
	MAX(yearid) AS latest
FROM teams;

--Earliest 1871	--Latest 2016--


--2--Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?
-- "min"	"playerid"	"namefirst"	"namelast"	"g_all"	"teamid"
--  43		"gaedeed01"	"Eddie"		"Gaedel"		1	"SLA" St.Louis Browns

SELECT MIN(height),
	people.playerid, 
	people.namefirst, 
	people.namelast,
	g_all, 
	appearances.teamid
FROM people
	JOIN appearances
	ON people.playerid = appearances.playerid
	GROUP BY 
	people.playerid, 
	people.namefirst, 
	people.namelast,
	g_all, 
	appearances.teamid
ORDER BY height ASC
LIMIT 1;

SELECT teams.name
FROM teams
WHERE teams.teamid ='SLA';


--3--Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

--"namefirst"	"namelast"	"schoolname"			"total_salary"
--"David"		"Price"		"Vanderbilt University"		245553888

SELECT 
	people.namefirst, 
	people.namelast, 
	schools.schoolname,
	SUM(salaries.salary) AS total_salary
FROM people
	JOIN collegeplaying
	ON people.playerid = collegeplaying.playerid
	JOIN schools
	ON collegeplaying.schoolid = schools.schoolid
	JOIN salaries
	ON people.playerid = salaries.playerid
WHERE schoolname = 'Vanderbilt University'
GROUP BY people.namefirst, 
	people.namelast, 
	schools.schoolname
ORDER BY total_salary DESC;


--4--Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.

--	"position_grp"	"total_putouts"
--	"Infield"			58934
--	"Battery"			41424
--	"Outfield"			29560

WITH pos_group AS(
SELECT
	fielding.playerid AS player,
	CASE
		WHEN fielding.pos = 'OF' THEN 'Outfield'
		WHEN fielding.pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
		WHEN fielding.pos IN ('P', 'C') THEN 'Battery'
		ELSE NULL
	END AS position_grp, 
			po
FROM fielding
WHERE yearID = 2016
)
SELECT 
	position_grp,
	SUM(po) AS total_putouts
FROM pos_group
WHERE position_grp IS NOT NULL
GROUP BY position_grp
ORDER BY total_putouts DESC;

--5--Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?

--"decade"	"strikeouts"
--	1920		5.63
--	1930		6.63
--	1940		7.10
--	1950		8.80
--	1960		11.43
--	1970		10.29
--	1980		10.73
--	1990		12.30
--	2000		13.12
--	2010		15.04

SELECT
	(yearID/10)*10 AS decade,
	ROUND(2.0*SUM(SOA)/SUM(G)::NUMERIC/2,2) AS strikeouts
FROM teams
WHERE yearID >= 1920
GROUP BY (yearID/10)*10
ORDER BY decade;

-- Both trend upward as the decades go on. 

SELECT
	(yearID/10)*10 AS decade,
	ROUND(2.0*SUM(HR)/SUM(G)::NUMERIC/2,2) AS home_runs
FROM teams
WHERE yearID >= 1920
GROUP BY (yearID/10)*10
ORDER BY decade;


--6--Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.

WITH stbases_tot AS(
SELECT 
	people.namefirst,
	people.namelast,
	SUM(batting.sb) AS total_stolen,
	SUM(batting.cs) AS total_caught
FROM people
	JOIN batting
	ON people.playerid = batting.playerid
WHERE batting.yearID = 2016
GROUP BY 
	people.namefirst,
	people.namelast
)
SELECT
	namefirst,
	namelast, 
	total_stolen/(total_caught) AS success_rate
FROM stbases_tot
WHERE (total_stolen + total_caught) >=20
ORDER BY success_rate DESC;
	

--7a--From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?:: SEA -116::

SELECT teams.teamID,
		MAX(W) AS wins,
		WSWin,
		teams.yearID
FROM teams
WHERE WSWin = 'N' 
	AND yearID BETWEEN 1970 AND 2016
GROUP BY teams.teamID, WSWin, teams.yearID
ORDER BY wins DESC;

--7b--What is the smallest number of wins for a team that did win the world series? ::LAN - 63 In 1981 due to the mid-season strike from June-Aug.::

SELECT teams.teamID,
		teams.W,
		WSWin,
		teams.yearID
FROM teams
WHERE WSWin = 'Y' 
	AND yearID BETWEEN 1970 AND 2016
GROUP BY teams.teamID, WSWin, teams.w, teams.yearID
ORDER BY teams.w ASC;

--7c--Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. ::"teamid"	"w"	"wswin"	"yearid"
					--"SLN"		83		"Y"		2006

SELECT teams.teamID,
		teams.W,
		WSWin,
		teams.yearID
FROM teams
WHERE WSWin = 'Y' 
	AND yearID BETWEEN 1970 AND 2016
	AND yearID <> 1981
GROUP BY teams.teamID, WSWin, teams.w, teams.yearID
ORDER BY teams.w ASC;

--7d--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

WITH best_teams_per_year AS (
    SELECT yearID, teamID, W, WSWin
    FROM Teams
    WHERE yearID BETWEEN 1970 AND 2016
    AND W = (
        SELECT MAX(W)
        FROM Teams t2
        WHERE t2.yearID = Teams.yearID
    )
)
SELECT 
    COUNT(CASE WHEN WSWin = 'Y' THEN 1 END) AS years_best_won_ws,
    COUNT(*) AS total_years,
    ROUND(100.0 * COUNT(CASE WHEN WSWin = 'Y' THEN 1 END) / COUNT(*), 2) AS percentage
FROM best_teams_per_year;

--8--Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

SELECT 
	teams.name AS team_name,
	parks.park_name,
	(homegames.attendance/homegames.games) AS avg_attendance
FROM homegames
JOIN parks 
	ON homegames.park = parks.park
JOIN teams
	ON homegames.team = teams.teamid
	AND homegames.year = teams.yearid
WHERE homegames.year = 2016
    AND homegames.games >=10
ORDER BY avg_attendance DESC
LIMIT 5;

--"team_name"				"park_name"				"avg_attendance"
--"Los Angeles Dodgers"		"Dodger Stadium"			45719
--"St. Louis Cardinals"		"Busch Stadium III"			42524
--"Toronto Blue Jays"		"Rogers Centre"				41877
--"San Francisco Giants"	"AT&T Park"					41546
--"Chicago Cubs"			"Wrigley Field"				39906


--LOWEST
SELECT 
	teams.name AS team_name,
	parks.park_name,
	(homegames.attendance/homegames.games) AS avg_attendance
FROM homegames
JOIN parks 
	ON homegames.park = parks.park
JOIN teams
	ON homegames.team = teams.teamid
	AND homegames.year = teams.yearid
WHERE homegames.year = 2016
    AND homegames.games >=10
ORDER BY avg_attendance ASC
LIMIT 5;
--"team_name"			"park_name"						"avg_attendance"
--"Tampa Bay Rays"		"Tropicana Field"					15878
--"Oakland Athletics"	"Oakland-Alameda County Coliseum"	18784
--"Cleveland Indians"	"Progressive Field"					19650
--"Miami Marlins"		"Marlins Park"						21405
--"Chicago White Sox"	"U.S. Cellular Field"				21559


--9--Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.


SELECT 
    people.namefirst,
    people.namelast,
    teams.name,
    awardsmanagers.yearid,
    awardsmanagers.lgid
FROM awardsmanagers
JOIN people ON awardsmanagers.playerid = people.playerid
JOIN managers ON awardsmanagers.playerid = managers.playerid 
              AND awardsmanagers.yearid = managers.yearid
JOIN teams ON managers.teamid = teams.teamid
           AND managers.yearid = teams.yearid
WHERE awardsmanagers.awardid = 'TSN Manager of the Year'
AND awardsmanagers.lgid = 'NL'
AND awardsmanagers.playerid IN (
    SELECT playerid
    FROM awardsmanagers
    WHERE awardid = 'TSN Manager of the Year'
    AND lgid = 'AL'
);
--"namefirst"		"namelast"		"name"				"yearid"	"lgid"
--"Jim"				"Leyland"		"Pittsburgh Pirates"	1988	"NL"
--"Jim"				"Leyland"		"Pittsburgh Pirates"	1990	"NL"
--"Jim"				"Leyland"		"Pittsburgh Pirates"	1992	"NL"
--"Davey"			"Johnson"		"Washington Nationals"	2012	"NL"


--10--Find all players who hit their career highest number of home runs in 2016. Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016. Report the players' first and last names and the number of home runs they hit in 2016.

WITH eligible_players AS (
    SELECT playerid
    FROM batting
    GROUP BY playerid
    HAVING COUNT(DISTINCT yearid) >= 10
),
player_hr_by_year AS (
    SELECT 
        playerid,
        yearid,
        SUM(hr) as total_hr
    FROM batting
    WHERE playerid IN (SELECT playerid FROM eligible_players)
    GROUP BY playerid, yearid
),
player_max_hr AS (
    SELECT 
        playerid,
        MAX(total_hr) as career_max_hr
    FROM player_hr_by_year
    GROUP BY playerid
)
SELECT 
    p.namefirst,
    p.namelast,
    hr2016.total_hr as hr_in_2016
FROM player_hr_by_year hr2016  
JOIN player_max_hr pmax 
    ON hr2016.playerid = pmax.playerid
JOIN people p 
    ON hr2016.playerid = p.playerid
WHERE hr2016.yearid = 2016
    AND hr2016.total_hr = pmax.career_max_hr  
    AND hr2016.total_hr >= 1;  
	
--"namefirst"	"namelast"	"hr_in_2016"
--"Mike"		"Napoli"		34
--"Robinson"	"Cano"			39
--"Edwin"		"Encarnacion"	42
--"Rajai"		"Davis"			12
--"Justin"		"Upton"			31
--"Angel"		"Pagan	"		12
--"Bartolo"		"Colon"			1
--"Adam"		"Wainwright"	2
--"Francisco"	"Liriano"		1

--**Open-ended questions**

--11. Is there any correlation between number of wins and team salary? Use data from 2000 and later to answer this question. As you do this analysis, keep in mind that salaries across the whole league tend to increase together, so you may want to look on a year-by-year basis.

SELECT teams.teamid, teams.yearid, w, salaries
FROM teams
	JOIN salaries
	ON teams.teamid = salaries.teamid
	AND teams.playerid = salaries.playerid
WHERE teams.yearid >= 2000

--I took this data and used a pivot table to look at the data. You can see a clear distinction that not all the most winning teams are the top earners. 
--Seattle Mariners 2001 — had the lowest salary in the dataset ($4.6M) and won 116 games, which is the all-time MLB record for wins in a season. Meanwhile the Yankees had the highest salary and won 95.
--Oakland Athletics 2001-2002 — this is literally the Moneyball story. Mid-tier salary, consistently 100+ wins. They were finding undervalued players the market hadn't priced correctly yet.
--St. Louis Cardinals — repeatedly 90-100 win seasons on a relatively modest payroll throughout the 2000s.



--12--In this question, you will explore the connection between number of wins and attendance.

--12a--Does there appear to be any correlation between attendance at home games and number of wins? - Yes, there seems to be a trending upwards pattern when the number of wins increase

SELECT
    CASE
        WHEN t.w < 60  THEN '1. < 60 wins'
        WHEN t.w < 70  THEN '2. 60–69 wins'
        WHEN t.w < 80  THEN '3. 70–79 wins'
        WHEN t.w < 90  THEN '4. 80–89 wins'
        WHEN t.w < 100 THEN '5. 90–99 wins'
        ELSE                '6. 100+ wins'
    END                       	  AS win_bucket,
    COUNT(*)                      AS team_seasons,
    SUM(hg.attendance)            AS total_attendance,
    ROUND(AVG(hg.attendance), 0)  AS avg_total_attendance,
    ROUND(AVG(hg.attendance * 1.0 / hg.games), 0)  AS avg_attendance_per_game
FROM teams t
JOIN homegames hg
    ON  t.teamid = hg.team
    AND t.lgid   = hg.league
    AND t.yearid = hg.year
WHERE hg.attendance > 0
  AND t.yearid >= 2000
GROUP BY win_bucket
ORDER BY win_bucket;

--12b--Do teams that win the world series see a boost in attendance the following year? What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner. - Not making the playoffs is the only negative on attendance. Winning the world series or making the playoffs didn't have a huge impact on overall attendance

SELECT
    t.yearid,
    t.teamid,
    t.wswin,
    hg.attendance,
    hg.games,
    ROUND(hg.attendance * 1.0 / hg.games, 0) AS avg_attendance_per_game
FROM teams t
JOIN homegames hg
    ON  t.teamid = hg.team
    AND t.lgid   = hg.league
    AND t.yearid = hg.year
WHERE t.yearid >= 2000
  AND hg.attendance > 0
ORDER BY t.teamid, t.yearid;

--13. It is thought that since left-handed pitchers are more rare, causing batters to face them less often, that they are more effective. Investigate this claim and present evidence to either support or dispute this claim. 

--First, determine just how rare left-handed pitchers are compared with right-handed pitchers. --Being a left-handed pitcher is rare. It is not super rare, but out of the total players in this database, only 19.12% are listed as left-handed compared to 75.76% of those listed as right-handed. 
SELECT 	
	COUNT(*) AS total_players,
	SUM(CASE WHEN p.throws = 'L' THEN 1 ELSE 0 END) AS left_handed,
	SUM(CASE WHEN p.throws = 'R' THEN 1 ELSE 0 END) AS right_handed,
	ROUND(SUM (CASE WHEN p.throws = 'L' THEN 1.0 ELSE 0 END) / COUNT(*) *100,2) AS pct_left,
	ROUND(SUM (CASE WHEN p.throws = 'R' THEN 1.0 ELSE 0 END) / COUNT (*) * 100,2) AS pct_right
FROM people AS p;

--Are left-handed pitchers more likely to win the Cy Young Award? -- Out of the 112 who have been awarded the CY Young Award, only 37 have been lefthanded so I would say that is not a precursor to being an awardee. 
SELECT
    p.throws,
    COUNT(*) AS cy_young_winners
FROM people AS p
JOIN awardsplayers AS awpl
    ON p.playerid = awpl.playerid
WHERE awpl.awardid LIKE '%Cy%'
GROUP BY p.throws
ORDER BY p.throws;
	
--Are they more likely to make it into the hall of fame? --No, the majority of those inducted into the HOF are right-handed. 
SELECT
    p.throws,
    COUNT(*) AS hof_inductees
FROM people AS p
JOIN halloffame AS hof
    ON p.playerid = hof.playerid
WHERE hof.inducted = 'Y'
GROUP BY p.throws
ORDER BY p.throws;
		