#!/system/bin/sh
# ============================================
#  BGMI Login Reset Script (Ultimate Edition)
# ============================================
#  Made By RICHGURU | Channel: @RICHCLAN
# ============================================

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
CYAN="\033[1;36m"
YELLOW="\033[1;33m"
WHITE="\033[1;37m"
RESET="\033[0m"

VERSION="1.0"
# GitHub Raw Links (Yahan apne links dalein)
UPDATE_URL="https://raw.githubusercontent.com/resetupdate37-hub/bgmi-update-tool/refs/heads/main/version.txt"
SCRIPT_URL="https://raw.githubusercontent.com/resetupdate37-hub/bgmi-update-tool/3b6aaaa0c6daeb60e8022a780fdb1c1422268629/RICHCLAN_FIXED.sh"

PKG="com.pubg.imobile"

# --- Functions ---
loading_bar() {
    echo -ne "${YELLOW}[$1] Processing: "
    for i in {1..20}; do
        echo -ne "█"
        sleep 0.05
    done
    echo -e " Done!${RESET}"
}

clear
echo -e "${CYAN}============================================${RESET}"
echo -e "${WHITE}        RICH CLAN BGMI LOGIN RESET TOOL${RESET}"
echo -e "${WHITE}        Author: RICHGURU | Version: $VERSION${RESET}"
echo -e "${CYAN}============================================${RESET}"

# --- 1. Auto-Update Logic ---
echo -e "${YELLOW}[*] Checking for updates...${RESET}"
LATEST_VERSION=$(curl -s "$UPDATE_URL")

if [ "$LATEST_VERSION" != "" ] && [ "$LATEST_VERSION" != "$VERSION" ]; then
    echo -e "${RED}[!] New Update V$LATEST_VERSION Found!${RESET}"
    echo -e "${CYAN}[+] Downloading latest version...${RESET}"
    curl -s "$SCRIPT_URL" -o "$HOME/richclan_temp"
    if [ -f "$HOME/richclan_temp" ]; then
        mv "$HOME/richclan_temp" "$0"
        chmod +x "$0"
        echo -e "${GREEN}[+] Update Success! Restarting...${RESET}"
        sleep 2
        exec "$0"
    else
        echo -e "${RED}[X] Update Failed! Check @RICHCLAN${RESET}"
        exit 1
    fi
fi

# --- 2. Device Info ---
echo -e "\n${YELLOW}[i] Device Info:${RESET}"
echo -e "    - Model   : $(getprop ro.product.model)"
echo -e "    - Android : $(getprop ro.build.version.release)"

# --- 3. Forced Telegram Join ---
echo -e "\n${WHITE}Join Channel to Unlock? (y/n): ${RESET}"
read choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    am start -a android.intent.action.VIEW -d "https://t.me/RICHCLAN" > /dev/null 2>&1
    sleep 2
else
    echo -e "${RED}[X] Access Denied! Join @RICHCLAN first.${RESET}"
    exit 1
fi

# --- 4. Root Check ---
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[X] ERROR: Root Access Required!${RESET}"
    exit 1
fi

# --- 5. Main Reset Process ---
echo -e "\n${CYAN}[*] Initializing Cleanup...${RESET}"
loading_bar "1"

echo -e "${GREEN}[+] Stopping BGMI...${RESET}"
am force-stop $PKG

echo -e "${GREEN}[+] Resetting Data...${RESET}"
# Deleting login files
rm -rf /data/data/$PKG/shared_prefs/*
rm -rf /data/data/$PKG/databases/*
rm -rf /data/data/$PKG/app_webview/*
rm -rf /data/data/$PKG/cache/*
rm -rf /data/data/$PKG/code_cache/*

loading_bar "2"

echo -e "\n${CYAN}============================================${RESET}"
echo -e "${GREEN}SUCCESS: BGMI Login Has Been Reset!${RESET}"
echo -e "${WHITE}Join @RICHCLAN for Support.${RESET}"
echo -e "${CYAN}============================================${RESET}"
