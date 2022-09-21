#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

# Reset sequences
echo $($PSQL "SELECT setval('teams_team_id_seq', 1, false)")
echo $($PSQL "SELECT setval('games_game_id_seq', 1, false)")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Print test
  # echo "$YEAR | $ROUND | $WINNER | $OPPONENT | $WINNER_GOALS | $OPPONENT_GOALS"

  # Skip header row
  if [[ $YEAR != "year" ]]
  then

    # get team_id for Winner
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found
    if [[ -z $WINNER_ID ]]
    then

      # insert team (name)
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")

      # get new team_id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi

    # TESTS
    
    # Test Winner Inserts
    echo Winner: $WINNER_ID, $WINNER
  fi
    
done
