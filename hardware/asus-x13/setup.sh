#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "hardware/asus-x13"

create_script "fan-speed-toggle" "#!/usr/bin/env bash

# Usage 1: fan-speed-toggle
# Usage 2: fan-speed-toggle <max|default|zero>
# Usage 3 (no notification): fan-speed-toggle <max|default|zero> true

current_profile=\$(asusctl profile -p | tail -n 1 | awk '{print \$NF}')

mode_to_set=\"\$1\"
is_quiet=\"\$2\"

fans_max() {
  asusctl fan-curve -m \$current_profile -f cpu -D 30c:100%,49c:100%,59c:100%,69c:100%,79c:100%,89c:100%,99c:100%,109c:100%
  asusctl fan-curve -m \$current_profile -f gpu -D 30c:100%,49c:100%,59c:100%,69c:100%,79c:100%,89c:100%,99c:100%,109c:100%
  asusctl fan-curve -e true -m \$current_profile
  echo \"Fans MAX speed!\"
  [[ -z \$is_quiet ]] && notify-send -a \"Fan toggle\" \"Fans MAX speed!\"
}

fans_zero() {
  asusctl fan-curve -m \$current_profile -f cpu -D 30c:0%,49c:0%,59c:0%,69c:0%,79c:0%,89c:0%,99c:0%,109c:0%
  asusctl fan-curve -m \$current_profile -f gpu -D 30c:0%,49c:0%,59c:0%,69c:0%,79c:0%,89c:0%,99c:0%,109c:0%
  asusctl fan-curve -e true -m \$current_profile
  echo \"Fans zero speed!\"
  [[ -z \$is_quiet ]] && notify-send -a \"Fan toggle\" -u critical \"Fans zero speed!!!!\"
}

fans_default() {
  asusctl fan-curve -d
  echo \"Fans default speed.\"
  [[ -z \$is_quiet ]] && notify-send -a \"Fan toggle\" \"Fans default speed\"
}

max_beginning=\`asusctl fan-curve -g > /tmp/faninfo && sed -n '2p' /tmp/faninfo | awk -F',' '{print \$2}' | grep \":100%\"\`
zero_ending=\`asusctl fan-curve -g > /tmp/faninfo && sed -n '2p' /tmp/faninfo | awk -F',' '{print \$NF}' | grep \":0%\"\`

# If no specific mode is provided by the user
# Set it to toggle between default and max
if [[ -z \"\$mode_to_set\" ]]; then
 
  if [[ -n \$max_beginning ]]; then

    # Current state : Max speed
    # Perform : max -> default 
    mode_to_set=\"default\"

  elif [[ -n \$zero_ending ]]; then

    # Current state : Zero speed
    # Perform : zero -> default  
    mode_to_set=\"default\"
  
  else

    # Neither zero speed, nor max speed.
    # Current state : Default
    # Perform : default -> max
    mode_to_set=\"max\"

  fi

fi

case \$mode_to_set in
  default)
    fans_default
    ;;
  max)
    fans_max
    ;;
  zero)
    fans_zero
    ;;
  maintain)
    if [[ -n \$max_beginning ]]; then
      fans_max
    elif [[ -n \$zero_ending ]];then
      fans_zero
    else
      fans_default
    fi
    ;;
esac

"

create_script "temp-limit-toggle" "#!/usr/bin/env bash

# Arguments: blank (simple toggle), \"limited\", \"not-limited\"

user_input=\"\$1\"
is_quiet=\"\$2\"

last_state_file=/tmp/last_temperature_state
last_state=\"\$(cat \$last_state_file 2> /dev/null)\"
last_state=\"\${last_state:-\"not-limited\"}\"

new_state=\"\"

if [[ \"\$user_input\" == \"maintain\" ]]; then
  new_state=\"\$last_state\"
elif [[ -n \"\$user_input\" ]]; then
  new_state=\"\$user_input\"
elif [[ \"\$last_state\" == \"not-limited\" ]]; then
  new_state=\"limited\"
else
  new_state=\"not-limited\"
fi

if [[ \"\$new_state\" == \"limited\" ]]; then
  sudo ryzenadj --tctl-temp=65
  echo \"Limited temperature\"
  [[ -z \$is_quiet ]] && notify-send -a \"Temp. limit toggle\" \"Limited temperature\"
else
  fan-speed-toggle maintain quiet
  echo \"Temperature limits lifted (if any)\"
  [[ -z \$is_quiet ]] && notify-send -a \"Temp. limit toggle\" \"Temperature limits lifted.\"
fi

echo \"\$new_state\" > \$last_state_file
[[ \"\$(whoami)\" == "root" ]] && chmod 666 \$last_state_file

log_file=/tmp/temp-toogle-log
echo \"\$(date) - \$(whoami) - \$@\" - \$new_state >> \$log_file
[[ \"\$(whoami)\" == "root" ]] && chmod 666 \$log_file

"

create_script "fan-speed-toggle-maintain-temp" "

#!/usr/bin/env bash

fan-speed-toggle \$@
sleep 1
temp-limit-toggle maintain quiet

"

ryzenadj_path=`which ryzenadj`

# make a sudoers entry to allow running ryzenadj without root
sudoers_content="
${USER} ALL=(root) NOPASSWD: ${ryzenadj_path}
"

sudoers_file="/etc/sudoers.d/asus_x13"

write_to_file "$sudoers_file" "$sudoers_content" append=false use_sudo=true backup_original=false
sudo chmod 440 $sudoers_file

# Setup systemd timers
# Check: sudo systemctl status <name>.timer
# Check: sudo journalctl -u <name>.service

service_file_content="
[Unit]
Description=Run temp-limit-toggle

[Service]
ExecStart=$(which temp-limit-toggle) maintain quiet
"

service_file_name="temp-limit.service"
service_file_location="/etc/systemd/system/$service_file_name"

service_at_boot_content="
[Unit]
Description=Limit temp. at boot
After=network.target

[Service]
Type=oneshot
ExecStart=$(which temp-limit-toggle) limited quiet
RemainAfterExit=false

[Install]
WantedBy=multi-user.target
"

service_at_boot_name="temp-limit-at-boot.service"
service_at_boot_location="/etc/systemd/system/$service_at_boot_name"

timer_file_content="
[Unit]
Description=Run temp-limit-toggle every minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=$service_file_name

[Install]
WantedBy=timers.target
"

timer_file_name="temp-limit.timer"
timer_file_location="/etc/systemd/system/$timer_file_name"

write_to_file "$service_file_location" "$service_file_content" append=false use_sudo=true backup_original=false
sudo chmod +x "$service_file_location"
write_to_file "$service_at_boot_location" "$service_at_boot_content" append=false use_sudo=true backup_original=false
sudo chmod +x "$service_at_boot_location"
write_to_file "$timer_file_location" "$timer_file_content" append=false use_sudo=true backup_original=false
sudo chmod +x "$timer_file_location"

sudo systemctl daemon-reload
sudo systemctl enable $service_at_boot_name
sudo systemctl enable $timer_file_name
# DO NOT ENABLE the standalone service file, which is being called by the timer.
#sudo systemctl disable $service_file_name

echo "=========================================================="
echo "                     Kindly reboot                        "
echo "=========================================================="
