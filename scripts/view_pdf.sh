ORIG=`xdotool getactivewindow`

atril $1 &> /dev/null & 
sleep 2
wmctrl -r :ACTIVE: -N "$1"
TEMP=`wmctrl -lG | grep -Po "(?<=^)\S*(?=.*$1)"`
xdotool windowmove ${TEMP} 1920 0
xdotool mousemove 2460 960
xrandr --output HDMI-2 --rotate left
xinput set-prop 6 136 -1 0 1 0 -1 1 0 0 1;

xdotool windowactivate ${ORIG}
