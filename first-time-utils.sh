echo " upgrade all packages for first time use " 
sudo apt update && sudo apt upgrade

echo " install popular fonts and codecs "
sudo apt install ubuntu-restricted-extras

echo " install MPV video player with codecs "
sudo apt install mpv

echo " cleaning up after bootstrapping..."
sudo apt -y autoremove
sudo apt -y clean
