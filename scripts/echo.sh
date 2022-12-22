BOLD=$(tput bold)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

function headline {
    text=$1
    echo "${BOLD}${GREEN}${text}${RESET}"
}

function note {
    text=$1
    echo "${YELLOW}>>> ${text}${RESET}"
}

function warning {
    text=$1
    echo "${BOLD}${RED}${text}${RESET}"
}

