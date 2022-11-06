## Nvidia driver installer

<br>

### Instructions:

1. Manually check if your graphics card is compatible with the `Latest New Feature Branch Version` of the Nvidia driver (Visit https://www.nvidia.com/en-us/drivers/unix/).

2. Make sure python 3 and a cron implementation is installed and its daemon has been added to your system's init process.

3. Install the required libraries for python (This is optional. The installer will install them for you, if you you have a stable internet connection but you can do it manually to check if there are any errors):
```
pip install -r requirements.txt
```

4. Clone the repository and launch the installer:
```
git clone https://github.com/Giann1s/nvidia-driver-installer.git && ./nvidia-driver-installer/installer.sh
```

<br>

### What it does:
Basically downloads the Nvidia driver version that is mentioned above, disables the Nouveau (Open Source) driver, restarts the computer and launches the installer when the boot process is finished using a cron job. (The installation might take a few minutes, depending on your hardware)