#!/bin/bash

# Config
REPO_DIR="."
REMOTE_NAME="origin"
BRANCH_NAME="main"

# Messages de commit aléatoires
MESSAGES=(
  "fix typo"
  "add new feature"
  "remove unused file"
  "update README"
  "refactor code"
  "improve performance"
  "cleanup"
  "add tests"
  "bug fix"
  "update dependencies"
)

# Création ou utilisation du repo
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "Initialisation du repo dans $REPO_DIR"
  git init "$REPO_DIR"
fi

cd "$REPO_DIR" || exit 1

# S’assurer que la branche existe
git checkout -B "$BRANCH_NAME"

for i in $(seq 1 30); do
  echo "Commit #$i"

  # Créer un fichier aléatoire
  FILENAME="file_$(date +%s%N)_$RANDOM.txt"
  echo "Contenu aléatoire $RANDOM" > "$FILENAME"
  git add "$FILENAME"

  # Suppression aléatoire d’un fichier (avec 50% de chance)
  FILES=( $(git ls-files) )
  if [ ${#FILES[@]} -gt 0 ] && [ $((RANDOM % 2)) -eq 0 ]; then
    FILE_TO_DEL="${FILES[$RANDOM % ${#FILES[@]}]}"
    echo "Suppression de $FILE_TO_DEL"
    git rm "$FILE_TO_DEL"
  fi

  # Commit avec message aléatoire
  MSG="${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}"
  git commit -m "$MSG"

  # Push (optionnel : commente si pas besoin)
  git push "$REMOTE_NAME" "$BRANCH_NAME"
done

echo "Terminé boss 😎"
