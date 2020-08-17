TYPE="$1"
NAME="$2"
PARENT_DIR="$3"
TEMPLATE="templates/$TYPE.tex"

if [[ ! -e "$TEMPLATE" ]]; then
    echo -n "No template found for type \"$TYPE\"."
    exit 1
fi

while ! scripts/is_root.sh $PARENT_DIR; do
    PARENT_DIR=`dirname $PARENT_DIR`
done

NEW_PATH="$PARENT_DIR/$TYPE/$NAME"

FILENAME="$NEW_PATH/$NAME.tex"

if [[ ! -d "$NEW_PATH" ]]; then
    mkdir -p "$NEW_PATH"
    cp "$TEMPLATE" "$FILENAME"
fi

echo -n $FILENAME