url = "http://www.tmz.com/category/who-would-you-rather/"

# 'page' is our open webpage
page = require('webpage').create()
system = require 'system'

page.onConsoleMessage = (msg) ->
    if not msg.match /^Unsafe/
        console.log msg

page.onResourceError = (resourceError) ->
    page.reason = resourceError.errorString
    page.reason_url = resourceError.url

phantom.clearCookies()

vote_once = (i, lim) ->
    if i == lim
        phantom.exit()
    else
        page.open url, (status) ->
            if status isnt 'success'
                console.log "Error opening url \"" + page.reason_url + "\": " + page.reason
                console.log i
                console.log status
                phantom.exit 1
            else
                # Need jQuery?
                page.injectJs "static/js/jquery.min.js"

                # This code runs in 'page'
                vote = () ->
                    parent = $("#poll-4243-c0044532ce317139fd2aede5d237e48e-form")

                    choices = parent.find("li.options")
                    target = $(choices[1])
                    target.find("input").click()

                    button = parent.find("button")
                    button.click()
                    return $.trim target.text()

                # Run code on page itself with 'evaluate'
                console.log page.evaluate vote
                setTimeout () ->
                    if i == lim - 1
                        page.render "end.png"
                    page.clearCookies()
                    vote_once i+1, lim
                , 1000

vote_once(0, 10)
