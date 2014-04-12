url = "https://www.facebook.com/"
page = require('webpage').create()
system = require 'system'


page.onConsoleMessage = (msg) ->
    if not msg.match /^Unsafe/
        console.log msg

email = "your_email"
pw = require('fs').open("pw.txt", "r").read()

page.open url, () ->

    fill_login = (email) ->
        $('input[name="email"]').val(email)

    fill_pass = (pw) ->
        $('input[name="pass"]').val(pw)

    login = () ->
        $('input[value="Log In"]').click()

    scroll_down = () ->
        window.scrollTo(0,document.body.scrollHeight)

    page.injectJs "static/js/jquery.min.js"
    page.evaluate fill_login, email
    page.evaluate fill_pass, pw
    page.evaluate login
    setTimeout () ->
        page.render "start.png"
        page.evaluate scroll_down
        setTimeout () ->
            page.render "finish.png"
            phantom.exit()
        , 5000
    , 5000
