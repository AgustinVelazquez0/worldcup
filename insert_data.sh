#!/bin/bash

# Conexión a la base de datos
PSQL="psql -U postgres -d worldcup -t --no-align -c"

# Limpiar las tablas antes de insertar datos
$PSQL "TRUNCATE matches, teams RESTART IDENTITY;"

# Leer el archivo línea por línea
cat games.csv | while IFS=',' read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    # Insertar equipo ganador si no existe
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    if [[ -z $TEAM_ID ]]
    then
      $PSQL "INSERT INTO teams(name) VALUES('$WINNER');"
    fi

    # Insertar equipo oponente si no existe
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    if [[ -z $TEAM_ID ]]
    then
      $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');"
    fi

    # Obtener IDs
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

    # Insertar el partido
    $PSQL "INSERT INTO matches(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
           VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
  fi
done
