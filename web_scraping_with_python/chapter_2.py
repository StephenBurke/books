from urllib.request import urlopen
from bs4 import BeautifulSoup

html = urlopen('http://www.pythonscraping.com/pages/page1.html')
bs = BeautifulSoup(html.read(), 'html.parser')

nameList = bs.find_all('span', {'class':'green'})
for name in nameList:
	print(name.get_text())

#######################
#to find only children use .children

from urllib.request urlopen
from bs4 improt BeautifulSoup

html = urlopen('http://www.pythonscraping.com/pages/page3.html')
bs = BeautifulSoup(html.read(), 'html.parser')

for child in bs.find('table',{'id':'giftList'}).children:
	print(child)

######################
#Dealing with siblings

from urllib.request urlopen
from bs4 improt BeautifulSoup

html = urlopen('http://www.pythonscraping.com/pages/page3.html')
bs = BeautifulSoup(html.read(), 'html.parser')

for sibling in bs.find('table', {'id':'giftList'}).tr.next_siblings:
	print(sibling)

#####################
#Deading with parents

from urllib.request urlopen
from bs4 improt BeautifulSoup

html = urlopen('http://www.pythonscraping.com/pages/page3.html')
bs = BeautifulSoup(html.read(), 'html.parser')
print(bs.find('img', {'src':'../img/gfts/img1.jpg'}).parent.previous_sibling.get_text())