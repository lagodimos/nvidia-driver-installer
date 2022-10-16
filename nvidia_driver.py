#!/usr/bin/env python3

import os
os.system("pip install beautifulsoup4 > /dev/null 2>&1")

import sys
import requests
from bs4 import BeautifulSoup

if "--url" in sys.argv or "--filename" in sys.argv:

    def get_filename(url):

        last_slash_position = 0 

        for i in range(len(url)):
            if url[i] == "/":
                last_slash_position = i
        
        return url[last_slash_position + 1:]

    unix_drivers = "https://www.nvidia.com/en-us/drivers/unix/"

    result1 = requests.get(unix_drivers)
    page1 = BeautifulSoup(result1.text, "html.parser")
    url = page1.find(text=" Latest Production Branch Version: ").parent.find("a").get("href")

    result2 = requests.get(url)
    page2 = BeautifulSoup(result2.text, "html.parser")
    url = f"""https://www.nvidia.com{page2.find(id="lnkDwnldBtn").get("href")}"""

    start = url.find("url=") + 4
    end = url.find(".run") + 4
    driver_url = f"https://us.download.nvidia.com{url[start:end]}"

    driver_filename = get_filename(driver_url)

    if "--url" in sys.argv:
        print(driver_url)
    if "--filename" in sys.argv:
        print(driver_filename)
