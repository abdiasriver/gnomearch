#!/bin/bash
set -e
#======================================================================================
#                                
# Author  : Erik Dubois at http://www.erikdubois.be
# License : Distributed under the terms of GNU GPL version 2 or later
# 
# AS ALLWAYS, KNOW WHAT YOU ARE DOING.
#======================================================================================

echo "################################################################"
echo "####             Installing reflector                        ###"
echo "################################################################"


# installing refector to test wich servers are fastest
sudo pacman -S --noconfirm --needed reflector


echo "################################################################"
echo "####   finding fastest servers be patient for the world      ###"
echo "################################################################"

# finding the fastest archlinux servers

sudo reflector -l 100 -f 50 --sort rate --threads 5 --verbose --save /tmp/mirrorlist.new && rankmirrors -n 0 /tmp/mirrorlist.new > /tmp/mirrorlist && sudo cp /tmp/mirrorlist /etc/pacman.d


echo "################################################################"
echo "####       fastest servers  saved                            ###"
echo "################################################################"


cat /etc/pacman.d/mirrorlist


sudo pacman -Sy



echo "################################################################"
echo "###############       pacaur      ###################"
echo "################################################################"

# Make sure our shiny new arch is up-to-date
echo "Checking for system updates..."
sudo pacman -Syu

# Create a tmp-working-dir and navigate into it
mkdir -p /tmp/pacaur_install
cd /tmp/pacaur_install

# If you didn't install the "base-devel" group,
# we'll need those.
sudo pacman -S binutils make gcc fakeroot pkg-config --noconfirm --needed

# Install pacaur dependencies from arch repos
sudo pacman -S expac yajl git --noconfirm --needed

# Install "cower" from AUR
if [ ! -n "$(pacman -Qs cower)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=cower
    makepkg PKGBUILD --skippgpcheck --install --needed
fi

# Install "pacaur" from AUR
if [ ! -n "$(pacman -Qs pacaur)" ]; then
    curl -o PKGBUILD https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pacaur
    makepkg PKGBUILD --install --needed
fi

# Clean up...
cd ~
rm -r /tmp/pacaur_install

echo "###############################  INSTALADO PACAUR #################################"
echo " Xserver setup"

sudo pacman -S xorg-server xorg-apps xorg-xinit --noconfirm --needed
sudo pacman -S xf86-video-intel --noconfirm --needed

echo "################################################################"
echo "###################    xorg installed     ######################"
echo "################################################################"

echo "###################    SOFTWARE NEEDED    ######################"

sudo pacman -S --noconfirm --needed gnome-shell gnome-font-viewer gnome-screenshot gnome-system-monitor termite gnome-tweak-tool 
 
sudo pacman -S --noconfirm --needed gnome-shell-extensions mutter xdg-user-dirs-gtk gnome-photos btrfs-progs awesome-terminal-fonts
###############################################################################################

# installation of zippers and unzippers
sudo pacman -S --noconfirm --needed unace unrar zip unzip sharutils  uudeview  arj cabextract file-roller
sudo pacman -S --noconfirm --needed ipw2100-fw ipw2200-fw intel-ucode intel-tbb wayland wayland-protocols glfw-wayland qt5-wayland xorg-server-xwayland wlc 



sudo pacman -S --noconfirm --needed alsa-utils gstreamer phonon-qt5-gstreamer gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly flashplugin
###############################################################################################

sudo pacman -S --noconfirm exfat-utils libinput xf86-input-keyboard libva-intel-driver libva-vdpau-driver mesa mesa-vdpau
echo "################################################################"
echo "###################    core software installed  ################"
echo "################################################################"
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings --noconfirm --needed

sudo systemctl enable lightdm.service -f
