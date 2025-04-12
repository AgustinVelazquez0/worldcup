#!/bin/bash

# 1. Total number of goals in all games from winning teams
echo "Total number of goals in all games from winning teams:"
psql -U postgres -d worldcup -t --no-align -c "SELECT SUM(winner_goals) FROM matches;"

# 2. Total number of goals in all games from both teams combined
echo "Total number of goals in all games from both teams combined:"
psql -U postgres -d worldcup -t --no-align -c "SELECT SUM(winner_goals + opponent_goals) FROM matches;"

# 3. Average number of goals in all games from the winning teams
echo "Average number of goals in all games from the winning teams:"
psql -U postgres -d worldcup -t --no-align -c "SELECT AVG(winner_goals) FROM matches;"

# 4. Average number of goals in all games from the winning teams rounded to two decimal places
echo "Average number of goals in all games from the winning teams rounded to two decimal places:"
psql -U postgres -d worldcup -t --no-align -c "SELECT ROUND(AVG(winner_goals), 2) FROM matches;"

# 5. Average number of goals in all games from both teams
echo "Average number of goals in all games from both teams:"
psql -U postgres -d worldcup -t --no-align -c "SELECT AVG(winner_goals + opponent_goals) FROM matches;"

# 6. Most goals scored in a single game by one team
echo "Most goals scored in a single game by one team:"
psql -U postgres -d worldcup -t --no-align -c "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM matches;"

# 7. Number of games where the winning team scored more than two goals
echo "Number of games where the winning team scored more than two goals:"
psql -U postgres -d worldcup -t --no-align -c "SELECT COUNT(*) FROM matches WHERE winner_goals > 2;"

# 8. Winner of the 2018 tournament team name
echo "Winner of the 2018 tournament team name:"
psql -U postgres -d worldcup -t --no-align -c "SELECT name FROM matches JOIN teams ON matches.winner_id = teams.team_id WHERE year = 2018 AND round = 'Final';"

# 9. List of teams who played in the 2014 'Eighth-Final' round
echo "List of teams who played in the 2014 'Eighth-Final' round:"
psql -U postgres -d worldcup -t --no-align -c "
SELECT DISTINCT name FROM teams
JOIN matches ON teams.team_id = matches.winner_id OR teams.team_id = matches.opponent_id
WHERE year = 2014 AND round = 'Eighth-Final'
ORDER BY name;" > output.log

cat output.log



# 10. List of unique winning team names in the whole data set
echo "List of unique winning team names in the whole data set:"
psql -U postgres -d worldcup -t --no-align -c "
SELECT DISTINCT name FROM teams
JOIN matches ON teams.team_id = matches.winner_id
ORDER BY name;"

# 11. Year and team name of all the champions
echo "Year and team name of all the champions:"
psql -U postgres -d worldcup -t --no-align -c "
SELECT year, name FROM matches
JOIN teams ON matches.winner_id = teams.team_id
WHERE round = 'Final'
ORDER BY year;"

# 12. List of teams that start with 'Co'
echo "List of teams that start with 'Co':"
psql -U postgres -d worldcup -t --no-align -c "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name;"
