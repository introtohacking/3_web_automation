from splinter import Browser
from time import sleep

with Browser("chrome") as browser:
    # Visit URL
    url = "http://www.tmz.com/category/who-would-you-rather/"
    browser.visit(url)

    # Find and click the 'search' button
    for i in range(20):
        choice = browser.find_by_xpath(
            '//*[@id="poll-4385-ed8e84fd6bf71cd622d54bffe374bdb7-form"]/form/ul/li[1]/div').first
        choice.click()
        button = browser.find_by_xpath(
            '//*[@id="poll-4385-ed8e84fd6bf71cd622d54bffe374bdb7-vote"]').first
        button.click()
        browser.cookies.delete()
        browser.reload()
        sleep(1)
