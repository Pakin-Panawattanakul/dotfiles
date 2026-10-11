// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    //{"", "brightnessctl i | grep -q backlight && brightnessctl | grep Current | cut -d ' ' -f 4 | sed 's|[()]||g;s|^|^fg(8ba4b0)󰃟 |;s|$|^fg()|'", 5, 3 },
    {"", "sed 's/.*/^fg(8a9a7b)&^fg()/' /tmp/dwl-keymap", 5, 3},
    {"", "wpctl get-volume @DEFAULT_SINK@ | awk '{if(/MUTED/)icon=\"󰝟\";else if($2<0.33)icon=\"󰕿\";else if($2<0.66)icon=\"󰖀\";else icon=\"󰕾\";printf \"^fg(a292a3)%s %.0f%%^fg()\",icon,$2*100}'", 5, 4},
    {"", "e=$(nmcli -t -f device,type,state device 2>/dev/null | awk -F: '$2==\"ethernet\"&&$3 ~ /^connected/{print $1; exit}'); if [ -n \"$e\" ]; then ip=$(nmcli -t -f IP4.ADDRESS device show \"$e\" 2>/dev/null | head -1 | cut -d: -f2 | cut -d/ -f1); printf \"^fg(8ea4a2)󰈀 %s^fg()\" \"$ip\"; else w=$(nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | awk -F: '$1==\"yes\"{print $2\",\"$3; exit}'); if [ -n \"$w\" ]; then ssid=${w%,*}; sig=${w#*,}; printf \"^fg(8ea4a2) %s %s%%^fg()\" \"$ssid\" \"$sig\"; else printf \"^fg(8ea4a2)  disconnected^fg()\"; fi; fi", 5, 0},
    {"", "upower -e | grep BAT | xargs -I{} upower -i {} \
      | awk '/state:/{state=$2} /energy:/&&!/energy-empty/&&!/energy-full/{e+=$2} /energy-full:/&&!/energy-full-design/{f+=$2} END{if(f>0){p=e/f*100;if(state==\"charging\")icon=\"󰂄\";else if(state==\"fully-charged\"||state==\"not-charging\"||state==\"pending-charge\")icon=\"󱐋\";else if(p<20)icon=\"󰁺\";else if(p<45)icon=\"󰁾\";else icon=\"󰁹\";c=\"8a9a7b\";if(p<20)c=\"c4746e\";else if(p<45)c=\"c4b28a\";printf \"^fg(%s)%s %.0f%%^fg()\",c,icon,p}}'", 5, 0},
    {"", "date '+^fg(8ba4b0)󰃭 %b %d (%a)^fg()'", 5, 0},
    {"", "date '+^fg(c4746e) %H:%M ^fg()'", 5, 0},
};

// sets delimeter between status commands. NULL character ('\0') means no
// delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
