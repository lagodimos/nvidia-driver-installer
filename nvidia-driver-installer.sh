#!/usr/bin/env bash

sudo apt install cron -y > /dev/null 2>&1

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

SCRIPT_FILENAME="nvidia-driver-installer.sh"

URL=$(python3 ./nvidia_driver.py --url)
FILENAME=$(python3 ./nvidia_driver.py --filename)

croncmd="$SCRIPT_DIR/$SCRIPT_FILENAME --continue"
cronjob="@reboot $croncmd"

if [[ $1 == "--continue" ]]; then

    if [[ $2 == "--empty-crontab" ]]; then
        # Reset crontab
        sudo crontab -r
    else
        # Remove cron job
        ( sudo crontab -l | grep -v -F "$croncmd" ) | sudo crontab -
    fi

    # Launch installer in silent mode
    sudo $SCRIPT_DIR/$FILENAME -s
else
    clear
    echo -e "\nThe NVIDIA driver installation will begin and\nyour computer will restart during this procedure.\n"
    echo -e "(You can cancel the installation with Ctrl+C)\n"
    read -p "Press ENTER to continue..."

    # Install prerequisites
    sudo apt install linux-headers-$(uname -r) build-essential libglvnd-dev pkg-config -y

    # Blacklist the Nouveau driver
    sudo bash -c 'echo -e "blacklist nouveau\noptions nouveau modeset=0" > /etc/modprobe.d/disable-nouveau.conf'
    # Romove file if exists from previous installation
    sudo rm /usr/lib/modprobe.d/nvidia-installer-disable-nouveau.conf /etc/modprobe.d/nvidia-installer-disable-nouveau.conf > /dev/null 2>&1

    # Rebuild the initrd
    sudo update-initramfs -u

    wget $URL && sudo chmod +x ./$FILENAME

    # Add cron job
    if [[ $(sudo crontab -l | wc -c) -eq 0 ]]; then
        croncmd+=" --empty-crontab"
        cronjob="@reboot $croncmd"
    fi
    ( sudo crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | sudo crontab -

    sudo reboot
fi
