echo " upgrading all packages for the first time " 
sudo apt update && sudo apt upgrade

echo " installing popular fonts and codecs "
sudo apt install ubuntu-restricted-extras

echo " installing MPV video player with codecs "
sudo apt install mpv

echo " installing Telegram messenger "
sudo snap install telegram-desktop

echo " cleaning up after bootstrapping..."
sudo apt -y autoremove
sudo apt -y clean
