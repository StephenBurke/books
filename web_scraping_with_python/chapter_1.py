# first web scraper
# pg 8 

from urllib.request import urlopen
from bs4 import BeautifulSoup

html = urlopen('http://www.pythonscraping.com/pages/page1.html')
bs = BeautifulSoup(html.read(), 'html.parser')
print(bs.h1)

#pg 11
#using try catch statements to web scrape
from urllib.request import urlopen
from urllib.error import HTTPError

try: 
	html = urlopen('http://www.pythonscraping.com/pages/page1.html')
except HTTPError as e:
	print(e)

except URLError as e:
	print('the server could not be found')

else:

	print('It worked!')






