#!/bin/zsh

whole_path="$1"
line_number="$2"
dir_name="$3"
file_name="$4"

#escape spaces
whole_path="${whole_path// /\\\ }"
dir_name="${dir_name// /\\\ }"

#whole_path=$(printf %q "$whole_path")
#dir_name="$(printf %q "$dir_name")"

echo whole_path $whole_path
echo line_number $line_number
echo dir_name $dir_name
echo file_name $file_name

#file_name_no_dot=${file_name##*(.)}
file_name_no_dot=$(echo $file_name | sed 's/^\.//')
swp_file_name=".${file_name_no_dot}.swp"

echo file_name_no_dot $file_name_no_dot
echo swp_file_name $swp_file_name

whole_command="mv ${dir_name}/${swp_file_name} /tmp/ ; vim $whole_path -c 'norm! ${line_number}gg'"
echo whole_command $whole_command
#eval $whole_command

osascript -e "tell application \"iTerm2\"
                  set newWindow to (create window with default profile)
                  tell current session of newWindow
                      write text \"$whole_command\"
                  end tell
              end tell"

