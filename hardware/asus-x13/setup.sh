#!/usr/bin/env bash

source <(cat ../../.common/*)

#common_setup "../../packages" "hardware/asus-x13"

if [[ -z "$(which ryzenadj)" ]]; then
  echo "Ryzenadj not installed"
  exit 1
elif [[ -z "$(which asusctl)" ]]; then
  echo "Asusctl not installed"
  exit 1
fi

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo cp "$CURRENT_DIR/fan-speed-toggle" "/usr/local/bin/fan-speed-toggle"
sudo chmod +x "/usr/local/bin/fan-speed-toggle"

sudo cp "$CURRENT_DIR/temp-limit-toggle" "/usr/local/bin/temp-limit-toggle"
sudo chmod +x "/usr/local/bin/temp-limit-toggle"

# create_script "fan-speed-toggle-maintain-temp" "
# 
# #!/usr/bin/env bash
# 
# fan-speed-toggle \$@
# sleep 1
# temp-limit-toggle maintain quiet
# 
# "

ryzenadj_path=`which ryzenadj`

sudoers_file="/etc/sudoers.d/asus_x13"
sudoers_file_tmp=/tmp/asus_x13

echo "${USER} ALL=(root) NOPASSWD: ${ryzenadj_path}" > $sudoers_file_tmp
sudo mv $sudoers_file_tmp $sudoers_file
sudo chmod 440 $sudoers_file
sudo chown root:root $sudoers_file

# Setup systemd timers
# Check: sudo systemctl status <name>.timer
# Check: sudo journalctl -u <name>.service

service_file_name="temp-limit.service"
service_file_location="/etc/systemd/system/$service_file_name"

sudo cp "$CURRENT_DIR/temp_limit_service_file" "$service_file_location"
sudo chmod +x "$service_file_location"

service_at_boot_name="temp-limit-at-boot.service"
service_at_boot_location="/etc/systemd/system/$service_at_boot_name"

sudo cp "$CURRENT_DIR/temp_limit_service_at_boot_file" "$service_at_boot_location"
sudo chmod +x "$service_at_boot_location"

timer_file_name="temp-limit.timer"
timer_file_location="/etc/systemd/system/$timer_file_name"

sudo cp "$CURRENT_DIR/temp_limit_timer_file" "$timer_file_location"
sudo chmod +x "$timer_file_location"

if [[ -n "$(which restorecon)" ]]; then
  sudo restorecon -v "/usr/local/bin/fan-speed-toggle"
  sudo restorecon -v "/usr/local/bin/temp-limit-toggle"
  sudo restorecon -v "/usr/local/bin/fan-speed-maintain-temp"
  sudo restorecon -v $service_file_location
  sudo restorecon -v $service_at_boot_location
  sudo restorecon -v $timer_file_location
fi  

sudo systemctl daemon-reload
sudo systemctl enable $service_at_boot_name
sudo systemctl enable $timer_file_name
# DO NOT ENABLE the standalone service file, which is being called by the timer.
#sudo systemctl disable $service_file_name

#set_env_var "JAVA_TOOL_OPTIONS" "-Dsun.java2d.uiScale=3"

echo "=========================================================="
echo "                     Kindly reboot                        "
echo "=========================================================="
