echo " upgrading all packages for the first time " 
sudo apt update && sudo apt upgrade

echo " installing popular fonts and codecs "
sudo apt install ubuntu-restricted-extras

echo " installing MPV video player with codecs "
sudo apt install mpv

echo " install Viber desktop "
wget https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
sudo apt -y install ./viber.deb

echo " installing Telegram messenger "
sudo snap install telegram-desktop

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
