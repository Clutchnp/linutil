set_qt(){
 printf "${YELLOW}Configuring qt6ct...${RC}\n"
wget -O "${HOME}"/.config/qt6ct/"$1".conf https://raw.githubusercontent.com/catppuccin/qt5ct/main/themes/Catppuccin-"$1".conf

mkdir -p "$HOME/.config/qt6ct/"
cat <<EOF > "$HOME/.config/qt6ct/qt6ct.conf"
[Appearance]
style=kvantum
color_scheme_path="$HOME/.config/qt6ct/$1.conf"
icon_theme=breeze
EOF
printf "${YELLOW}Configured qt6ct...${RC}\n"
}
set_k(){
 printf "${YELLOW}Configuring kvantum...${RC}\n"
 wget -P "$HOME/.config/Kvantum/catppuccin-$1-$2/"  https://raw.githubusercontent.com/catppuccin/Kvantum/main/themes/catppuccin-"$1"-"$2"/catppuccin-"$1"-"$2".svg
 wget -P "$HOME/.config/Kvantum/catppuccin-$1-$2/"  https://raw.githubusercontent.com/catppuccin/Kvantum/main/themes/catppuccin-"$1"-"$2"/catppuccin-"$1"-"$2".kvconfig
cat <<EOF > "$HOME/.config/Kvantum/kvantum.kvconfig"
[General]
theme=catppuccin-$1-$accent
EOF
printf "${YELLOW}Configured kvantum...${RC}\n"
echo "Theme set to catppuccin-$1-$accent."
}
set_accent(){
  echo -e "\n1. blue\n 2. flamingo \n 3. green \n 4. lavender \n 5. maroon \n 6. mauve \n 7. peach \n 8. pink \n 9. red \n 10. rosewater \n 11. sapphire \n 12. sky \n 13. teal \n 14. yellow"
    while true; do
    read -rp "Enter your choice (the word): " accent
    if [[ $(curl -o /dev/null -s -w "%{http_code}" "https://github.com/catppuccin/Kvantum/tree/main/themes/catppuccin-${1,,}-$accent") == "200" ]]; then
    set_k ${1,,} $accent
    break
  else
    echo "write a valid accent bro :("
  fi
    done
}

set_theme() {
  set_qt $1
  set_accent $1
  echo "Catppuccin theme is set:)"
}
configure_flavour() {
    while true; do
      read -rp "Flavour (mocha,latte,mt (for macchiato),fp (for frappe))" flavour
        case $flavour in
          mocha ) set_theme "Mocha" ;;
          latte ) set_theme "Latte" ;;
          mt ) set_theme  "Macchiato";;
          frappe ) set_theme "Frappe";;
            * ) printf "Write a valid flavour" ;;
        esac
        break
    done
  }
. ./system-setup/3-global-theme.sh
configure_flavour


