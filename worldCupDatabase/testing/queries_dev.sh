#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -c"

echo -e "\nDisplay all games with team names"
echo "$($PSQL "SELECT year,round,win.name AS winner,op.name AS opponent,winner_goals,opponent_goals FROM games LEFT JOIN teams win ON games.winner_id=win.team_id LEFT JOIN teams op ON games.opponent_id=op.team_id")"

echo -e "\nGoal Sums"
echo "$($PSQL "SELECT SUM(winner_goals) AS winner_goals, SUM(opponent_goals) AS opponent_goals, (SUM(winner_goals)+SUM(opponent_goals)) AS total_goals FROM games")"

