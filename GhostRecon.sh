#!/bin/bash

trap 'echo -e "\n[!] Exit Detected. Saving progress..."; exit 1' 2

banner() {
    clear
    echo -e "\e[1;95m"
    echo " @@@@@@@@  @@@  @@@   @@@@@@    @@@@@@  @@@@@@@  @@@@@@@   @@@@@@@@   @@@@@@@   @@@@@@   @@@  @@@"
    echo "@@@@@@@@@  @@@  @@@  @@@@@@@@  @@@@@@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@ @@@"
    echo "!@@        @@!  @@@  @@!  @@@  !@@        @@!    @@!  @@@  @@!       !@@       @@!  @@@  @@!@!@@@"
    echo "!@!        !@!  @!@  !@!  @!@  !@!        !@!    !@!  @!@  !@!       !@!       !@!  @!@  !@!!@!@!"
    echo "!@! @!@!@  @!@!@!@!  @!@  !@!  !!@@!!     @!!    @!@!!@!   @!!!:!    !@!       @!@  @!@  @!@ !!@!"
    echo "!!! !!@!!  !!!@!!!!  !@!  !!!   !!@!!!    !!!    !!@!@!    !!!!!:    !!!       !@!  !!!  !@!  !!!"
    echo ":!!   !!:  !!:  !!!  !!:  !!!       !:!   !!:    !!: :!!   !!:       :!!       !!:  !!!  !!:  !!!"
    echo ":!:   !::  :!:  !:!  :!:  !:!      !:!    :!:    :!:  !:!  :!:       :!:       :!:  !:!  :!:  !:!"
    echo " ::: ::::  ::   :::  ::::: ::  :::: ::     ::    ::   :::   :: ::::   ::: :::  ::::: ::   ::   ::"
    echo " :: :: :    :   : :   : :  :   :: : :      :      :   : :  : :: ::    :: :: :   : :  :   ::    :"
    echo -e "\e[0m"
    echo -e "\e[1;93m[~] GhostRecon v2.1 | Made by HackOps Academy | @_hack_ops_\e[0m"
    echo
}

# Menu Function
menu() {
    echo -e "\e[1;96mChoose an option:\e[0m"
    echo "  [1] Enter Username to search"
    echo "  [2] Exit"
    echo -n -e "\n>> "
    read choice
    case $choice in
        1)
    read -p $'\n[?] Enter username to search: ' username
    search_username "$username"
    ;;
        2) echo -e "\e[1;91m[!] Exiting GhostRecon. Stay anonymous...\e[0m"; exit 0 ;;
        *) echo -e "\e[1;91m[!] Invalid choice. Try again.\e[0m"; sleep 1; clear; banner; menu ;;
    esac
}

search_username() {
    username=$1
    echo -e "\n[+] Scanning for username: \e[1;92m$username\e[0m"
    echo -e "[*] Results saved to: \e[1;94m$username.txt\e[0m"
    echo "" > "$username.txt"

    declare -A sites
    sites=(
        ["GitHub"]="https://github.com/$username"
        ["Instagram"]="https://instagram.com/$username"
        ["Twitter"]="https://twitter.com/$username"
        ["Facebook"]="https://facebook.com/$username"
        ["Reddit"]="https://reddit.com/user/$username"
        ["Pinterest"]="https://pinterest.com/$username"
        ["Tumblr"]="https://$username.tumblr.com"
        ["SoundCloud"]="https://soundcloud.com/$username"
        ["Medium"]="https://medium.com/@$username"
        ["Keybase"]="https://keybase.io/$username"
        ["Twitch"]="https://twitch.tv/$username"
        ["Snapchat"]="https://www.snapchat.com/add/$username"
        ["Quora"]="https://www.quora.com/profile/$username"
        ["LinkedIn"]="https://www.linkedin.com/in/$username"
        ["YouTube"]="https://www.youtube.com/$username"
        ["Pastebin"]="https://pastebin.com/u/$username"
        ["TikTok"]="https://www.tiktok.com/@$username"
        ["About.me"]="https://about.me/$username"
        ["Vimeo"]="https://vimeo.com/$username"
        ["Roblox"]="https://www.roblox.com/user.aspx?username=$username"
        ["Spotify"]="https://open.spotify.com/user/$username"
        ["GitLab"]="https://gitlab.com/$username"
        ["Mastodon"]="https://mastodon.social/@$username"
        ["Bitbucket"]="https://bitbucket.org/$username"
    )

    for platform in "${!sites[@]}"; do
        url="${sites[$platform]}"

        if [[ "$platform" == "Instagram" || "$platform" == "Facebook" || "$platform" == "Twitter" || "$platform" == "Reddit" ]]; then
            title=$(curl -s -A "Mozilla/5.0" "$url" | grep -i "<title>")
            if echo "$title" | grep -qiE "not found|page not available|doesn't exist|404"; then
                echo -e "\e[1;91m[✘] Not Found:\e[0m $platform ($url)"
            else
                echo -e "\e[1;92m[✔] Found:\e[0m $platform ($url)"
                echo "$url" >> "$username.txt"
            fi
        else
            html=$(curl -s -L "$url")
            if echo "$html" | grep -qiE "not found|doesn.t exist|404|unavailable|page not available"; then
                echo -e "\e[1;91m[✘] Not Found:\e[0m $platform ($url)"
            else
                echo -e "\e[1;92m[✔] Found:\e[0m $platform ($url)"
                echo "$url" >> "$username.txt"
            fi
        fi
    done
}

# Start Script
clear
banner
while true; do
    menu
done
