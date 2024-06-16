## Nvidia driver installer

### Instructions:

1. Manually check if your graphics card is compatible with the `Latest Production Branch Version` of the Nvidia driver. (Visit https://www.nvidia.com/en-us/drivers/unix/)

2. Make sure python 3 and a cron implementation is installed and its daemon has been added to your system's init process.

3. Clone the repository and cd into it:
```
git clone https://github.com/lagodimos/nvidia-driver-installer.git && cd ./nvidia-driver-installer
```

4. Install the required libraries:
```
pip install -r requirements.txt
```

4. Launch the installer:
```
chmod a+x installer.sh && ./installer.sh
```

### What it does:
Basically downloads the Nvidia driver version that is mentioned above, disables the Nouveau (Open Source) driver, restarts the computer and launches the installer when the boot process is finished using a cron job. (The installation might take a few minutes, depending on your hardware)
