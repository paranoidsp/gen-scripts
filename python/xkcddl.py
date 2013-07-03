import re
import mechanize

b = mechanize.browser()
b.open("http://www.xkcd.com/1214")

response1 = b.follow_link(text_regex=r"*.png",nr=1)
assert b.viewing_html()
print b.title
print response1.info()
print response1.geturl()
print response1.read()


