#Getting Data
#You can see all the datasets that are available ii the packages that you have loaded using the data function
data()

#for a more inclusive list, including data from all the packages that have been installed,
data(packaage = .packages(TRUE))

#to access the data in any of these datasets,, call teh dat function, this time passing the name of teh datset and the package where the daat is found (if the package has been loaded, then you can omit the package argument)
data("kidney", package = "survival")

#Now the kidney variable can be used like your own variables
head(kidney)

#Reading files
#the read.table function reads delimited files and stores theresults in a data frame.
#When reading in a dataset if file has header use argument header = TRUE to read.table
#When reading in a dataset if file has missing values pass fill = TRUE replaces the missing values with NA
#The system.file function in the following example is used to locate files in the extdata folder of the package learningr

library(learningr)
deer_file <- system.file(
	"extdata",
	"RedDeerEndocranialVolume.dlm",
	package = "learningr"
	)
deer_data <- read.table(deer_file, header = TRUE, fill = TRUE)
str(deer_data, vec.len = 1)			#vec.len alters the amount of output
head(deer_data)

#There are several voncenienc wrapper functions to read.table. read.csv sets the default separator to a comma, and assumes that the data has a heder row. read.csv2 is its European cousin, using a comma for decimal plaves and a semicolon as a separator. Likewise read.delim and read.delim2 import tab-delimited files with full stops or commas for decimal places, respectively

#This probably makes more sense if you look at the table on page 173

crab_file <- system.file(
	"extdata",
	"crabtag.csv",
	package = "learningr"
	)
(crab_id_block <- read.csv(
	crab_file,
	header = FALSE,
	skip = 3,
	nrow = 2,
	))
(crab_tag_notebook <- read.csv(
	crab_file,
	header = FALSE,
	skip = 8,
	nrow = 5
	))
(crab_lifetime_notebook <- read.csv(
	crab_file,
	header = FALSE,
	skip = 15,
	nrow = 3
	))

#the colbycol and sqldf packages contain functions that allow you to read part of a csv file into R. This can provide a useful speed-up if you don't need all the columns of all the rows
#If your data has been exported form another language, you may need to pass the na.strings argument to read.table. For data exported from SQL, use na.strings = "NULL". For data exported from SAS or Stata, us na.strings = ".". For data exported form Excel, use na.strings = c("", "#N/A", "#DIV/0!", "#NUM!")

#write to files using counterparts to read.table and read.csv; write.table and write.csv

write.csv(
	crab_lifetime_notebook,
	"Data/Cleaned/crab lifetime data.csv",
	row.names = FALSE,
	fileencoding = "utf8"
	)

#Unstructured text files
#use readLines to read in the file as lines of text.

text_file <- system.file(
	"extdata",
	"Shakespeare's The Tempest, from Project Gutenberg pg2235.txt",
	package = "learningr"
	)
the_tempest <- readLines(text_file)
the_tempest[1926:1927]

#writeLines performs the revese operstion to readLines. Takes a character vector and a file to write to

writeLines(
	rev(text_file),
	"Shakespeare's The Tempest, backwards.txt"
	)

#base R doesn't ship with the capability to read XML filex, but the XML package is developed by an R Core member
install.packages("XML")

#When you import an XML file, the XML package gives you a choice of storing the result using internal nodes (that is, objects are stored with C code, the default) or R nodes. Usually you want to store things with internal nodes, because it allows ou to query the node tree using XPath
#xmlParse for parsing
library(XML)
xml_file <- system.file("extdata", "options.xml", package = "learningr")
r_options <- smlParse(xml_file)

#one of the problems with using internal nodes is that summary functions like str and head don't work with them. To use R-level nodes, set useInternalNodes = FALSE (or use xmlTreeParse, which sets this as the default)
xmlParse(xml_file, useInternalNodes = FALSE)
xmlTreeParse(xml_file)

#XPath is a language for interrogating XML documetns, letting you find nodes that correspond to some filter. In this next example we look anywhere in the document (//) for a node named variable where ([]) the name attribute (@) contains the string warn
xpathSAply(r_options, "//variable[contains(@name, 'warn')]")

#super useful for wxtracting data from web pages. The equivalent functions for importing HTML pages are named respectively, htmlParse and htmlTreeParse
#XML is also very useful for seializing (aka saving) objects in a format that can be read by most other pieves of software. The XML package doesn't proide serialization functionality, but it is available via the makexml function in the Runiiveral package. The options.xml file was created with this code
library(Runiiveral)
ops <- as.list(options())
cat(makexml(ops), file = "options.xml")

#JSON and YAML files
#JSON and YAML files are good for big datassets, XML is very verbose
#There are two packages for dealing with JSON data: RJSONIO and rjson. doesn't really matter unless you run into malformed or nonstandard JSON
#RJSONIO is generaly more forgiving than json when reading incorrect JSON. Wheter this si a good thing or not depends upon your use case. If you think its better to improt JSON with minimal fuss, then RJSONIO is best. If you want to be alerted to problems with the JSON data (perhaps it was generted by a colleage = Im sure you would never generate malformed JSON), then rjson is best
#In the followingk example :: are used to distinguish which package each function should be taken from (if you only load one of the two packagee, then yuou don't need the double colons)

library(RJSONIO)
library(rjson)
jamaican_city_file <- system.file(
	"extdata",
	"Jamaizan Cities.json",
	package = "learningr"
	)
(jamaican_cities_RJSONIO <- RJSONIO::fromJSON(jamaican_city_file))
(jamaican)cities_rjson <- rjson::fromJSON(file = jamaican_city_file))

#Notice that RJSONIO simplfies the coordinate for each city to be a vector. This behavior can be turned off with simplify = FALSE, resulting in exactly the same object as the one generated by rjson
#Annoyingly, the JSON spec doesn't allow infinite or NaN values, and it's a little fuzzy on what a missing number should look like. The two packages deal with these values differently - RJSONIO maps NaN and NA to JSON's null value but preserves positive and negaive infinity, while rjson converts all these values to strings
special_numbers <- c(NaN, NA, Inf, -Inf)
RJSONIO::toJSON(special_numbers)
rjson::toJSON(special_numbers)

#Since bothe these methods are hacks to deal with JSON's limited spec, if you find yourself dealing with these special number types a lot (or want to write comments in your data object), then you are better off using YAML. The yaml package has two functions for importing YAML data. yaml.load accepts a string of YAML and converts it to an R obect, and yaml.load_file does the same, but treates its string input as a path to a file containing YAML

library(yaml)
yaml.load_file(jamaican_city_file)

#as.yaml performs the oposite task, converting R objects into YAML strings

#Reading Binary Files
#don't unless you have to

#Reading excel files
#xlsx package used to read in excel files
#Provides a choice of functions for reading Excel files: spreadsheets can be imported with read.xlsx and read.xlsx2, which do more processing inR and in Java, respectively. The choice of two engines is rather superfluous; you want read.xlsx2, since it's faster and the underlying Java library is more mature than R code

#In the next example the colClasses argument determines what class each column should have in the resulting data frame. It isn't compulsory, but it saves you having to manipulate the resulting data afterward
library(xlsx)
bike_file <- system.file(
	"extdata",
	"Alpe d'Huez.xls",
	package = "learningr"
	)
bike_data <- read.xlsx2(
	bike_file,
	sheetIndex = 1,
	startRow = 2,
	endRow = 38,
	colIndex = 2:8,
	colClasses = c(
		"character", "numeric", "character", "integer", "character", "character", "character"
		)
	)
head(bike_data)

#The counter part to read.xlcx2 is write.xlsx2...obviously. It works the same way as write.csv, taking a data frame and a filename. Unless you really need to use Excel spreadsheets, you're better off using txt

#Reading SAS, Stats, SPSS, and MATLAB Files
#The foreign package contains methods to read SAS permanent datasets (SAS&BDAT) using read.ssd, Stata DTA files with read.dta, and SPSS data files with read.spss. Each of these files can be written with write.foreign
#MATLAB binary data file (Level 4 and level5) can be read and written using readMat and writeMat in the R.matlab package

#Reading other file types
#If you need to reference the book

#Web data
#The world bank makes its World Development Indicators data publivally available, and the WDI package lets you easily import the data without leaving R. To run the next example, you first need to install the WDI package

install.packages("WDI")
library(WDI)
#list all available datasets
wdi_datasets <- WDIsearch()
head(wdi_datasets)
#retrieve one of them
wdi_trade_in_services <- WDI(
	indicator = "BG.GSR.NFSW.GD.ZS"
	)
str(wdi_trade_in_services)

#The twitteR package provides access to Twitter's users and their tweets
#Scraping Web pages
salary_url <- "http://www.justinmrao.com/salary_data.csv"
salary_data <- read.csv(salary_url)
str(salary_data)

#to download use download.file
salary_url <- "http://www.justinmrao.com/salary_data.csv"
local_copy <- "my_local_copy.csv"
download.file(salary_url, local_copy)
salary_data <- read.csv(local_copy)

