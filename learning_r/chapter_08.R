#Flow Control and Loops
#Flow Control
if and else

	if(TRUE) message("It was true!")
	if(FLASE) message("It wan't true!")

#missing values aren't allowed to be passed to if; doing so throws an error

if (NA) message("Who knows if it was true?")
#	where you may have a missing value, you should test for it using is.na
if(is.na(NA)) message("The value is missing!")

#	In this next example runif(1) generates one uniformly distributed random number between 0 and 1. If that value is more than 0.5, then the message is displayed
if(tunif(1)>0.5) message("This message appears with a 50% chance.")

#	If you want to conditionally execute several statements, you can wrap them in curly braces

x <- 3
if(x > 2)
{
	y <- 2 * x
	z <- 3 * y
}

#	if else example

if(FALSE)
{
	message("This won't execute...")
} else
{
	message("but this will.")
}

#the else statement must occur on the same line as teh closing curl race from the if clause. If you move it to the next line you'll get an error
#else if statements
(r <- round(rnorm(2), 1))
	(x <- r[1] / r[2])
	if(is.nan(x))
	{
		message("x is missing")
	}else if(is.infinite(x))
	{
		message("x is infinite")
	}else if(x > 0)
	{
		message("x is positive")
	}else if(x < 0)
	{
		message("x is negative")
	}else
	{
		message("x is zero")
	}

# r unlike many languages, has a nifty trick that lets you reorder the code and do conditional assignment. In the next example, Re returns the real compenent of a complex number (Im returns the imaginary component)

x <- sqrt(-1 + 0i)
(reality <- if(Re(x) == 0) "real" else "imaginary")

#vectorized if
# standard if statement takes a single logical value, to use more than one use ifelse. It has three arguments. first is logical vector of conditions, The second contains values that are returned when the vactor is TRUE. The third contains values that are returned when the first vector is FALSE.
# In the following  example rbinom generates random numbers from a binomial distribution to simulate a coin flip

ifelse(rbinom(10, 1, 0.5), "Head", "Tail")

#ifelse can also caaept vectors in the soind and third arguments. These should be the same size as the first vector( if different then elements in the second and third arguments are recyled or ignored to make them the same size as the first)

#Multiple Selection
# If you have a lot of else use switch statement instead
(greek <- switch(
	"gamma",
	alpha = 1,
	beta = sqrt(4),
	gamma =
	{
		a <- sin(pi /3)
		4 * a ^ 2
	}
))
# Switch can also take a first argument that returns an integer
switch(
	3,
	"first",
	"second",
	"third",
	"forth"
	)

#Loops
# repeat loop; like do while
#this will never end need to include a break statement
repeat{
	message("Happy Groundhog Day!")
}
#break statement example
repeat
{
	message("Happy Groundhog Day!")
	action <- sample(
		c(
			"Learn French",
			"Make an ice statue",
			"Rob a bank",
			"Win heart of Andie Mcdowell"
			),
		1
	)
	message("action = ", action)
	if(action == "Win heart of Andie Mcdowell")break
}
# using next; like continue for python
repeat
{
	message("Happy Groundhog Day!")
	action <- sample(
		c(
			"Learn French",
			"Make an ice statue",
			"Rob a bank",
			"Win heart of Andie Mcdowell"
			),
		1
	)
	if(action = "Rob a bank")
	{
		message("Quietly skipping to the next iteration")
		next
	}
	message("action = ", action)
	if(action == "Win heart of Andie Mcdowell")break
}

#While loops
#like backward repeat
action <- sample(
	c(
		"Learn French",
		"Make an ice statue",
		"Rob a bank",
		"Win heart of Andie Mcdowell"
		),
	1
)
while(action != "Win heart of Andie Mcdowell")
{
	message("Happy Groundhog Day!")
	action <- sample(
		c(
			"Learn French",
			"Make an ice statue",
			"Rob a bank",
			"Win heart of Andie Mcdowell"
		),
		1
	)
	message("action = ", action)
}
#For loops
for(i in 1:5) message("i = ", i)
#for multiple expressions, as with other loops they must be surrounded by curly braces
for(i in 1:5)
{
	j <- i ^ 2
	message("j = ", j)
}
#R's for loops are flexible, not limited to ints, or numbers in general; can pass char vectors, log vectors or lists
for (month in month.name)
{
	message("The month of ", month)
}

#Summary
#You can conditionally execute statements using if and else
#The ifelse function is a vectorized equivalent of these
#R has three kinds of loops: repeat, while, and for