#!/bin/bash
# Change hostname
echo -e 'Sitara' | sudo tee /etc/hostname
# Create a hidden vimrc file and enable line number indicators in Vim
touch .vimrc &&
echo "set clipboard+=unnamedplus" > .vimrc
# Add Vim as default Text Editor by editing user bashrc
echo -e "export VISUAL=/usr/bin/vim\nexport EDITOR=/usr/bin/vim" | sudo tee -a ~/.bashrc
# Save display configs in gnome display manager settings
sudo cp ~/.config/monitors.xml ~gdm/.config/ &&
# set tap to click on gdm login screen
xhost SI:localuser:gdm
# enable tap-to-click in the GDM login screen
sudo mkdir -p /etc/dconf/db/gdm.d && echo -e "[org/gnome/desktop/peripherals/touchpad]\ntap-to-click=true" | sudo tee /etc/dconf/db/gdm.d/06-tap-to-click &&
# install native applications
yes | sudo pacman -S switcheroo-control powertop git htop gnome-tweaks wine neofetch cmatrix pcsc-tools ccid opensc base-devel &&
# Setup the AUR helper yay
git clone https://aur.archlinux.org/yay.git &&
cd yay
makepkg -si &&
# Enable switcheroo-control to enable hybrid graphics gnome support
sudo systemctl enable switcheroo-control.service &&
sudo systemctl start switcheroo-control.service &&
# install flatpak applications
flatpak install flathub org.libreoffice.LibreOffice com.valvesoftware.Steam net.lutris.Lutris org.gnome.SoundRecorder org.videolan.VLC flathub com.github.tchx84.Flatseal flathub org.standardnotes.standardnotes com.mattjakeman.ExtensionManager net.davidotek.pupgui2 com.spotify.Client org.gnome.FontManager org.qbittorrent.qBittorrent io.github.aandrew_me.ytdn &&
# perform an update
sudo pacman -Syu &&
# Install packages from the AUR using yay
yay -S microsoft-edge-stable steam-devices


