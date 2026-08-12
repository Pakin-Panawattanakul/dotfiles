// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    //{"", "brightnessctl i | grep -q backlight && brightnessctl | grep Current | cut -d ' ' -f 4 | sed 's|[()]||g;s|^|^fg(a6dbff)󰃟 |;s|$|^fg()|'", 5, 3 },
    {"", "sed 's/.*/^fg(b3f6c0)&^fg()/' /tmp/dwl-keymap", 5, 3},
    {"", "wpctl get-volume @DEFAULT_SINK@ | awk '{if(/MUTED/)icon=\"󰝟\";else if($2<0.33)icon=\"󰕿\";else if($2<0.66)icon=\"󰖀\";else icon=\"󰕾\";printf \"^fg(ffcaff)%s %.0f%%^fg()\",icon,$2*100}'", 5, 4},
    {"", "w=$(nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | awk -F: '$1==\"yes\"{print $2\",\"$3; exit}'); if [ -n \"$w\" ]; then ssid=${w%,*}; sig=${w#*,}; printf \"^fg(8cf8f7) %s %s%%^fg()\" \"$ssid\" \"$sig\"; else e=$(nmcli -t -f device,type,state device 2>/dev/null | awk -F: '$2==\"ethernet\"&&$3==\"connected\"{print $1; exit}'); if [ -n \"$e\" ]; then ip=$(nmcli -t -f IP4.ADDRESS device show \"$e\" 2>/dev/null | head -1 | cut -d: -f2 | cut -d/ -f1); printf \"^fg(8cf8f7)󰈀 %s^fg()\" \"$ip\"; else printf \"^fg(8cf8f7)  disconnected^fg()\"; fi; fi", 5, 0},
    {"", "upower -e | grep BAT | xargs -I{} upower -i {} \
      | awk '/energy:/&&!/energy-empty/&&!/energy-full/{e+=$2} /energy-full:/&&!/energy-full-design/{f+=$2} END{if(f>0){p=e/f*100;c=\"b3f6c0\";if(p<=15)c=\"ffc0b9\";else if(p<=30)c=\"fce094\";printf \"^fg(%s)󰁹 %.0f%%^fg()\",c,p}}'", 5, 0},
    {"", "date '+^fg(a6dbff)󰃭 %b %d (%a)^fg()'", 5, 0},
    {"", "date '+^fg(ffc0b9) %H:%M ^fg()'", 5, 0},
};

// sets delimeter between status commands. NULL character ('\0') means no
// delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
