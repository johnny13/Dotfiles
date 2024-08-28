#!/bin/bash
# CONFIG
FFMPEG=0


# COLOR OPTIONS
_setColors_()
{
    if tput setaf 1 &>/dev/null; then

        # COLOR OPTIONS
        NORMAL="$(tput sgr0)" # Text Reset
        NC="$(tput sgr0)" # Text Reset
        BOLD="$(tput bold)" # Make Bold
        UNDERLINE="$(tput smul)" # Underline
        NOUNDER="$(tput rmul)" # Remove Underline
        BLINK="$(tput blink)" # Make Blink
        REVERSE="$(tput rev)" # Reverse

        if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
            BLK="$(tput setaf 252)" # Black
            RED="$(tput setaf 44)" # Red
            GRN="$(tput setaf 164)" # Green
            YLW="$(tput setaf 21)" # Yellow
            BLU="$(tput setaf 172)" # Blue
            PUR="$(tput setaf 184)" # Purple
            CYN="$(tput setaf 172)" # Cyan
            WHT="$(tput setaf 232)" # White
    else
            BLK="$(tput setaf 0)" # Black
            RED="$(tput setaf 1)" # Red
            GRN="$(tput setaf 2)" # Green
            YLW="$(tput setaf 3)" # Yellow
            BLU="$(tput setaf 4)" # Blue
            PUR="$(tput setaf 5)" # Purple
            CYN="$(tput setaf 6)" # Cyan
            WHT="$(tput setaf 7)" # White
    fi

        # BOLD TEXT COLORS
        BBLK="$(tput setaf 8)" # Black
        BRED="$(tput setaf 9)" # Red
        BGRN="$(tput setaf 10)" # Green
        BYLW="$(tput setaf 11)" # Yellow
        BBLU="$(tput setaf 12)" # Blue
        BPUR="$(tput setaf 13)" # Purple
        BCYN="$(tput setaf 14)" # Cyan
        BWHT="$(tput setaf 15)" # White

        # REGULAR BACKGROUND COLORS
        B_BLK="$(tput setab 0)" # Black
        B_RED="$(tput setab 1)" # Red
        B_GRN="$(tput setab 2)" # Green
        B_YLW="$(tput setab 3)" # Yellow
        B_BLU="$(tput setab 4)" # Blue
        B_PUR="$(tput setab 5)" # Purple
        B_CYN="$(tput setab 6)" # Cyan
        B_WHT="$(tput setab 7)" # White

        # BOLD BACKGROUND COLORS
        BB_BLK="$(tput setab 8)" # Black
        BB_RED="$(tput setab 9)" # Red
        BB_GRN="$(tput setab 10)" # Green
        BB_YLW="$(tput setab 11)" # Yellow
        BB_BLU="$(tput setab 12)" # Blue
        BB_PUR="$(tput setab 13)" # Purple
        BB_CYN="$(tput setab 14)" # Cyan
        BB_WHT="$(tput setab 7)" # White
  else

        # REGULAR TEXT COLORS
        BLK="\e[1;30m" # Black
        RED="\e[1;31m" # Red
        GRN="\e[1;32m" # Green
        YLW="\e[1;33m" # Yellow
        BLU="\e[1;34m" # Blue
        PUR="\e[1;35m" # Purple
        CYN="\e[1;36m" # Cyan
        WHT="\e[1;37m" # White

        # BOLD TEXT COLORS
        BBLK="\e[1;30m" # Black
        BRED="\e[1;31m" # Red
        BGRN="\e[1;32m" # Green
        BYLW="\e[1;33m" # Yellow
        BBLU="\e[1;34m" # Blue
        BPUR="\e[1;35m" # Purple
        BCYN="\e[1;36m" # Cyan
        BWHT="\e[1;37m" # White

        # BACKGROUND COLORS
        B_BLK="\e[40m" # Black
        B_RED="\e[41m" # Red
        B_GRN="\e[42m" # Green
        B_YLW="\e[43m" # Yellow
        B_BLU="\e[44m" # Blue
        B_PUR="\e[45m" # Purple
        B_CYN="\e[46m" # Cyan
        B_WHT="\e[47m" # White

        # BOLD BACKGROUND
        BB_BLK="\e[1;40m" # Black
        BB_RED="\e[1;41m" # Red
        BB_GRN="\e[1;42m" # Green
        BB_YLW="\e[1;43m" # Yellow
        BB_BLU="\e[1;44m" # Blue
        BB_PUR="\e[1;45m" # Purple
        BB_CYN="\e[1;46m" # Cyan
        BB_WHT="\e[1;47m" # White

        # COLOR OPTIONS
        NORMAL="\e[0m" # Text Reset
        BOLD="\e[1m" # Make Bold
        UNDERLINE="\e[4m" # Underline
        NOUNDER="\e[24m" # Remove Underline
        BLINK="\e[5m" # Make Blink
        NOBLINK="\e[25m" # NO Blink
        REVERSE="\e[50m" # Reverse
  fi
}

_setMessages_()
{
    if tput setaf 1 &>/dev/null; then
        GOODSTRING="$(tput bold)$(tput setaf 7)$(tput setab 10)[ OK ]$(tput sgr0)"
        BADSTRING="$(tput bold)$(tput setaf 0)$(tput setab 9)[FAIL]$(tput sgr0)"
        INFOSTRING="$(tput bold)$(tput setaf 7)$(tput setab 12)[INFO]$(tput sgr0)"
        DONESTRING="$(tput bold)$(tput setaf 7)$(tput setab 2)[DONE]$(tput sgr0)"
        MAKESTRING="$(tput bold)$(tput setaf 7)$(tput setab 13)[MAKE]$(tput sgr0)"
        WARNSTRING="$(tput bold)$(tput setaf 0)$(tput setab 11)[WARN]$(tput sgr0)"
  else
        GOODSTRING="\e[1m\e[1;37m\e[1;42m[ OK ]\e[0m"
        BADSTRING="\e[1m\e[1;30m\e[1;41m[FAIL]\e[0m "
        INFOSTRING="\e[1m\e[1;30m\e[1;46m[INFO]\e[0m"
        DONESTRING="\e[1m\e[1;37m\e[42m[DONE]\e[0m"
        MAKESTRING="\e[1m\e[1;37m\e[1;45m[MAKE]\e[0m"
        WARNSTRING="\e[1m\e[1;30m\e[1;43m[WARN]\e[0m"
  fi
}

banner()
{
  # Run this to generate the banner
  # figlet -f rustofat " flacfixr " | lolcat -f &> ban.txt
  echo
  cat ./ban.txt
}

PMSG()
{
  if [[ "$LOGMSG" -ne 0 ]]; then
    if [ -z "${LOGFILE:-}" ]; then
        LOGFILE="$(pwd)/$(basename "$0").log"
    fi
    [ ! -d "$(dirname "${LOGFILE}")" ] && mkdir -p "$(dirname "${LOGFILE}")"
    [[ ! -f ${LOGFILE} ]] && touch "${LOGFILE}"

    # Don't use colors in logs
    local cleanmessage="${2}"
    if command -v gsed &>/dev/null; then
      cleanmessage="$(echo "${2}" | gsed -E 's/(\x1b)?\[(([0-9]{1,2})(;[0-9]{1,3}){0,2})?[mGK]//g')"
    else
      cleanmessage="$(echo "${2}" | sed -E 's/(\x1b)?\[(([0-9]{1,2})(;[0-9]{1,3}){0,2})?[mGK]//g')"
    fi

    echo -e "$(date +"%b %d %R:%S") $(printf "[%4s]" "${1}") [$(/bin/hostname)] ${cleanmessage}" >>"${LOGFILE}"
  fi

  STATS=$( date +'%I:%M.%S')
  STATSTRING="${BWHT}[${BLK}${STATS}${BWHT}]"

  case $1 in

    GOOD)
        printf "\n${GOODSTRING}${STATSTRING} ${BGRN}%s${NC}" "$2"
        ;;

    FAIL)
        printf "\n${BADSTRING}${STATSTRING} ${BRED}%s${NC}" "$2"
        _safeExit_ "1"
        ;;

    INFO)
        printf "\n${INFOSTRING}${STATSTRING} ${BCYN}%s${NC}" "$2"
        ;;

    BAD)
        printf "\n${WARNSTRING}${STATSTRING} ${BYLW}%s${NC}" "$2"
        ;;

    DONE)
        printf "\n${DONESTRING}${STATSTRING} ${BGRN}%s${NC}" "$2"
        ;;

    MAKE)
        printf "\n${MAKESTRING}${STATSTRING} ${BPUR}%s${NC}" "$2"
        ;;

    *)
        printf "\n${INFOSTRING}${STATSTRING} ${BWHT}%s${NC}" "$2"
        ;;

  esac

  echo ""
}

_safeExit_()
{
  if [[ -n ${TMP_DIR:-} && -d ${TMP_DIR:-} ]]; then
    if [[ ${1:-} == 1 && -n "$(ls "${TMP_DIR}")" ]]; then
      # Do something here to save TMP_DIR on a non-zero script exit for debugging
      command rm -r "${TMP_DIR}"
      PMSG "INFO" "Removing temp directory"
    else
      command rm -r "${TMP_DIR}"
      PMSG "INFO" "Removing temp directory"
    fi
  fi

  trap - INT TERM EXIT
  exit ${1:-0}
}

_setColors_
_setMessages_

recurse() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        # echo "dir: $i"
        recurse "$i"
    elif [ -f "$i" ]; then
        
		filename=$(basename -- "$i")
		extension="${i##*.}"
		filename="${i%.*}"
		
		if [[ "$extension" == "flac" ]]; then
	        ## ACTUAL COMMANDS TO RUN
	        if [[ "$FFMPEG" -ne 0 ]]; then
			  PMSG "GOOD" "Converting FLAC file..."
			  output="${i%%.flac}.mp3"
	          ffmpeg -y -i "$i" -aq 0 "$output" </dev/null
	          rm "$i"
		  	else
			  echo "flac file: $i"
	        fi
		fi
    fi
 done
}

FILE="./ff.env"
if [ -f $FILE ]; then
  banner
  PMSG "GOOD" "config file $FILE loaded!"
  echo ""

  IFS=$'\r\n' GLOBIGNORE='*' command eval  'XYZ=($(cat $FILE))'

  # all lines
  # echo "${XYZ[0]}"
  recurse "${XYZ[0]}"
else
  PMSG "BAD" "You must provide an argument or use the .env file"
  show_help
  _safeExit_
fi

