#Packages
#to load a package that is already installed on your machine, cal the library function
library(lattice)
dotplot(
	variety ~ yield | site,
	data = barley,
	groups = year
	)
#to load multiple packages use qutoes and character.only = TRUE
pkgs <- c("lattice", "utils", "rpart")
for(pkg in pkgs)
{
	library(pkg, character.only = TRUE)
}
#require; like library, require loads a package, but rather tahn throwing an error it returns TURE or FALSE, depending upon whether or not the package was successfully loaded

if(!require(apackagethatmightnotbeinstalled))
{
	warning("The package 'apackagethatmightnotbeinstalled' is not available.")
	#perhaps try to download it
	#...
}
# You can see the packages that are loadedd with the search function
search()

#the function installed.packages returns a data frame with information about all the packages that R knows about on our machine.
View(installed.packages())

#Installing packages
# This command will (try to) download the time-series analysis packages xts and zoo and all the dependencies for each, and hen install the into the default library location (the first value returned by .libPaths)

install.packages(
	c("xts", "zoo"),
	repos = 'https://www.stats.bris.ac.uk/R/'
	)

#To install to a differetn location, you can pass the lib argument to install.packages

install.packages(
	c("stx", "zoo"),
	lib = "some/other/foler/to/install/to",
	repos = 'http://www.stats.bris.ac.uk/R/'
	)

#if running into intenet conection issues use setInternet2() to make R look like internet exployer
#To install a package directly from GitHub, you first need to install the devtools package
install.packages("devtools")
#The install_github function accepts the name of the GitHub repository that contains the package (usually the same as teh name of teh package itself) and the name of teh suer that maintains that repository.
library(devtools)
install_github("knitr", "yihui")

#Maintaining Packages
#to update packages use update.packages
#set ask = FALSE to not have to agree to each package updata
update.packages(ask = FALSE)

#to delete a package use remove.packages
remove.packages("zoo")

#Summary
#There are thousands of R packages available from online repositories
#You can install these packages with install.packages, and load tehm with library or require
#When you load packages, they are added to the search path, which lets R find their variables
#You can view the installed packages with installed.packages, keep them up-to-date with update.packages, and clean your system with remove.packages