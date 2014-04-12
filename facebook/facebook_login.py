from time import sleep
from getpass import getpass
from splinter import Browser

with Browser("chrome") as browser:
    url = "https://www.facebook.com"
    browser.visit(url)
    browser.fill('email', 'your_email')
    browser.fill('pass', getpass())
    button = browser.find_by_id('u_0_n').first
    button.click()
    while True:
        sleep(1)
        browser.execute_script("window.scrollTo(0,document.body.scrollHeight)")
