#!/usr/bin/env bash

source <(cat ../../.common/*)

common_setup "../../packages" "hardware/asus-x13"

create_script "fan-speed-toggle" "

#!/usr/bin/env bash

current_profile=\$(asusctl profile -p | awk '{print \$NF}')

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

max_beginning=\`asusctl fan-curve -g | head -n 1 | awk -F',' '{print \$2}' | grep \":100%\"\`
zero_ending=\`asusctl fan-curve -g | head -n 1 | awk -F',' '{print \$NF}' | grep \":0%\"\`

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

