#!/bin/bash

# ╔════════════════════════════════════════════════════════════════╗
# ║        GhostRecon v2.0 – Username Intelligence Scanner        ║
# ║        Developed by HackOps Academy (IG: @_hack_ops_)         ║
# ╚════════════════════════════════════════════════════════════════╝

trap 'echo -e "\n[!] Exit Detected. Saving progress..."; exit 1' 2

banner() {
    clear
    echo -e "\e[1;95m"
    echo "   ▄████  ▒█████   ██▀███ ▓██   ██▓ ▒█████   ██▀███   ▄████▄   ▒█████  ▒██   ██▒"
    echo "  ██▒ ▀█▒▒██▒  ██▒▓██ ▒ ██▒▒██  ██▒▒██▒  ██▒▓██ ▒ ██▒▒██▀ ▀█  ▒██▒  ██▒▒▒ █ █ ▒░"
    echo " ▒██░▄▄▄░▒██░  ██▒▓██ ░▄█ ▒ ▒██ ██░▒██░  ██▒▓██ ░▄█ ▒▒▓█    ▄ ▒██░  ██▒░░  █   ░"
    echo " ░▓█  ██▓▒██   ██░▒██▀▀█▄   ░ ▐██▓░▒██   ██░▒██▀▀█▄  ▒▓▓▄ ▄██▒▒██   ██░ ░ █ █ ▒ "
    echo " ░▒▓███▀▒░ ████▓▒░░██▓ ▒██▒ ░ ██▒▓░░ ████▓▒░░██▓ ▒██▒▒ ▓███▀ ░░ ████▓▒░▒██▒ ▒██▒"
    echo -e "\e[0m"
    echo -e "\e[1;93m[~] GhostRecon v2.0 | Made by HackOps Academy | @_hack_ops_\e[0m"
    echo
}

search_username() {
    username=$1
    echo -e "\n[+] Scanning for username: \e[1;92m$username\e[0m"
    echo -e "[*] Results saved to: \e[1;94m$username.txt\e[0m"
    echo "" > "$username.txt"

    sites=(
        "https://github.com/$username"
        "https://instagram.com/$username"
        "https://twitter.com/$username"
        "https://www.facebook.com/$username"
        "https://www.reddit.com/user/$username"
        "https://www.pinterest.com/$username"
        "https://www.tumblr.com/$username"
        "https://soundcloud.com/$username"
        "https://medium.com/@$username"
        "https://keybase.io/$username"
        "https://www.twitch.tv/$username"
        "https://www.snapchat.com/add/$username"
        "https://www.quora.com/profile/$username"
        "https://www.linkedin.com/in/$username"
        "https://www.youtube.com/$username"
        "https://pastebin.com/u/$username"
    )

    for url in "${sites[@]}"; do
        code=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")
        if [[ "$code" == "200" ]]; then
            echo -e "\e[1;92m[✔] Found:\e[0m $url"
            echo "$url" >> "$username.txt"
        else
            echo -e "\e[1;91m[✘] Not Found:\e[0m $url"
        fi
    done
}

custom_buttons() {
    echo -e "\n\e[1;96m[+] Quick Search Links (tap in Termux or browser):\e[0m"
    echo -e "\e[1;93m🔎 Instagram:\e[0m    https://instagram.com/$username"
    echo -e "\e[1;93m🔎 Facebook:\e[0m     https://facebook.com/$username"
    echo -e "\e[1;93m🔎 GitHub:\e[0m       https://github.com/$username"
    echo -e "\e[1;93m🔎 LinkedIn:\e[0m     https://linkedin.com/in/$username"
    echo -e "\e[1;93m🔎 YouTube:\e[0m      https://youtube.com/$username"
    echo -e "\e[1;93m🔎 Twitter:\e[0m      https://twitter.com/$username"
    echo -e "\e[1;93m🔎 Snapchat:\e[0m     https://www.snapchat.com/add/$username"
    echo -e "\e[1;93m🔎 TikTok:\e[0m       https://www.tiktok.com/@$username"
    echo
}

banner
read -p $'\e[1;94m[>] Enter a username to scan: \e[0m' username
custom_buttons
search_username "$username"
