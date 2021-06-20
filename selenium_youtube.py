from selenium.webdriver import Firefox
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException
import time
import subprocess

resolution = sys.argv[1]

#/mnt/vol1/vulatest/pcap
#/home/max/
#tcpdump = 'sudo timeout 930 tcpdump -i d1-eth0 -w /mnt/vol1/youtubetest.pcap'
#process = subprocess.Popen(tcpdump.split())
opts = Options()

# Turn to false to open friefox
opts.headless = False

starttime = time.time()

# Load youtube in firefox
browser = Firefox(options=opts)
browser.get('https://www.youtube.com/')
delay = 15
try:
    myElem = WebDriverWait(browser, delay).until(EC.presence_of_element_located((By.ID, 'overlays')))
    print("Page is ready")
except TimeoutException:
    print("Loading took too much time")
time.sleep(2)

# Find video thumbnail and click on it
print("playing first video")
videos = browser.find_elements_by_id('img')
videos[3].click()
try:
    myElem = WebDriverWait(browser, delay).until(EC.presence_of_element_located((By.ID, 'overlays')))
    print("Page is ready")
except TimeoutException:
    print("Loading took too much time")
time.sleep(2)

try:
    print("Loading ad")
    time.sleep(10)
    print("Skipping ad")
    browser.find_element_by_class_name("ytp-ad-skip-button-container").click()
    
except NoSuchElementException:
    print("There was no ad")
    pass

print("Loading video")
time.sleep(5)

print("Changing quality to " + resolution)
browser.find_element_by_css_selector('button.ytp-button.ytp-settings-button').click()
browser.find_element_by_xpath("//div[contains(text(),'Quality')]").click()
time.sleep(2)
quality = browser.find_element_by_xpath("//span[contains(string(),'" + resolution + "')]")
quality.click()


time.sleep(900)

print("First video finished")

#time.sleep(640)

    
browser.quit()
