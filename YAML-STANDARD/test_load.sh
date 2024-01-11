#!/bin/bash

# URL de FastAPI
URL="https://mystreamingapp.crs-datascientest.cloudns.biz"

# Nombre de requêtes à envoyer
TOTAL_REQUESTS=5000

# Délai entre les requêtes
DELAY=0.002

# Compteur de requêtes
COUNT=0

while [ $COUNT -lt $TOTAL_REQUESTS ]
do
  curl -s $URL > /dev/null
  echo "Requête $COUNT envoyée"
  COUNT=$((COUNT+1))
  sleep $DELAY
done

echo "Test de charge terminé."
