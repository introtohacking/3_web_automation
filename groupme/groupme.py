from time import sleep
from getpass import getpass
from splinter import Browser
import operator

with Browser("chrome") as browser:
    url = "https://app.groupme.com/signin"
    browser.visit(url)
    browser.fill('username', 'your_username')
    browser.fill('password', getpass())
    button = browser.find_by_value('Log in').first
    button.click()
    chat = browser.find_by_css('a.chat').first
    chat.click()
    sleep(1)

    for t in range(10):
        browser.execute_script("$('div.message')[0].scrollIntoView(true);")
        sleep(1)

    chatlog = {}

    for message in browser.find_by_css('div.message'):
        author = message.find_by_css('div.nickname').first.text
        body = message.find_by_css('span.body').first.text

        if not author:
            continue

        if not author in chatlog:
            chatlog[author] = []
        chatlog[author].append(body)

    counts = {author: len(chatlog[author]) for author in chatlog}
    sorted_counts = sorted(counts.iteritems(), key=operator.itemgetter(1))
    for (author, count) in sorted_counts:
        print author + ": " + str(count) + " messages"
