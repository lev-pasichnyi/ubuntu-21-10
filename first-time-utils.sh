echo -e "\n  OS version: \n"
lsb_release -a
echo -e " \n VGA cards in the system \n"
lspci | grep VGA
echo -e "\n Amount of RAM \n"
free -h
sleep 10

echo " upgrading all packages for the first time " 
sudo apt update && sudo apt upgrade

echo " installing popular fonts and codecs "
sudo apt install ubuntu-restricted-extras

echo " installing MPV video player with codecs "
sudo apt install mpv

echo " installing gdebi package manager "
sudo apt -y install gdebi-core wget

echo " installing Chrome browser "
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# or sudo gdebi google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

echo " install Viber desktop "
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt -y install ./viber.deb

echo " installing Telegram messenger "
sudo snap install telegram-desktop

echo " installing qbittorrent client "
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt update
sudo apt -y install qbittorrent

echo " installing KVM virtualization"
# number of CPU with virtualization capabilities
egrep -c '(vmx|svm)' /proc/cpuinfo
sleep 4
sudo apt -y install cpu-checker
sudo apt update
sudo apt -y install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo adduser $USER kvm
sudo systemctl status libvirtd
sleep 4
sudo apt -y install virt-manager

echo " cleaning up after bootstrapping..."
sudo apt -y autoremove
sudo apt -y clean
