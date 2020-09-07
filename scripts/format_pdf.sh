ORIG=`xdotool getactivewindow`

pdf=`scripts/get_pdf.sh $1`
echo ${pdf}
wmctrl -lG | grep -Po "(?<=^)\S*(?=.*${pdf})"
TEMP=`wmctrl -lG | grep -Po "(?<=^)\S*(?=.*${pdf})"`
xdotool windowactivate ${TEMP}
xdotool key F11
xdotool key ctrl+Right
xdotool key ctrl+Right

xdotool windowactivate ${ORIG}
