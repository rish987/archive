TYPE="$1"
NAME="$2"
PARENT_DIR="$3"
TEMPLATE="templates/$TYPE.tex"

if [[ ! -e "$TEMPLATE" ]]; then
    echo "No template found for type \"$TYPE\". Exiting..."
    exit
fi

NEW_PATH="$PARENT_DIR/$TYPE/$NAME"

if [[ ! -d "$NEW_PATH" ]]; then
    mkdir -p "$NEW_PATH"
    cp "$TEMPLATE" "$NEW_PATH/$NAME.tex"
    echo "New \"$TYPE\" directory for \"$NAME\" created."
else
    echo "\"$TYPE\" directory for \"$NAME\" already exists."
fi
