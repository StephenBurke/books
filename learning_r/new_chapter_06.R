#Environment and Functions
#
#Environments
#	to create a new environment use new.env()

an_environment <- new.env()

#	assigning variables into environment

an_environment[["pythag"]] <- c(12 ,15, 20, 21)
an_environment$root <- polyroot (c(6, -5, 1))

#	assign()
#		takes an optinal environment argument that can be used to specify where the variable is stored

assign(
	"moonday",
	weekdays(as.Date("199/0/20")),
	an_environment
)

#	retrieving variables works in the same way - you can either use list-indexing syntax or assign's opposite, the get function

an_environment[["pythag"]]
an_environment$root
get("moonday", an_environment)

#	the ls and ls.str frunctions also take an environment argument, allowing yu to list their contents

ls(encir = an_environment)
ls.str(envir = an_environment)

#	test if a variable exists in an environment using the exists function

exists("pythag", an_environment)

#	Conversion from an environment to list and back again using the obvious finctions, as.list and as.environment. In the latter case ther is also a function list2env that allows for a little more flexibility in the creation of the environment

#convert to a list
(a_list <- as.list(an_environment))
#and back
as.environment(a_list)
list2env(a_list)


#Functions
#	hypotenuse function

hypotenuse <- function(x, y)
	{
	sqrt(x^2 + y^2)
	}
## can be represented as one line as in python
hypotenuse <- function(x,y) sqrt(x^2 + y^2)

#	retrieving arguments
#		can use formals(), arge(), or formalArgs

formals(hypotenuse)
args(hypotenuse)
formalArgs(hypotenuse)

#	retrieving body
#		body retrieved using the body function
#		use deparse() to find functions that call another function

(body_of_hypotenuse <- body(hypotenuse))
deparse

#
#	Variable Scope
#		the set of places from which you can se the variable
#Summary:
#	Environments store variables and can be creted with new.env
#	You can treat environments like lists most of the time
#	All environments have a parent environment
#	Functions consist of formal arguments and a body
#	You can assign and use functions just as yu would any other variable type
#	R will look for variables in the current environment and its parents
