#Advanced looping
#rep repeats its input several times
#replicate, calls an expression several times
#rep and replicate are slightly different as the next two examples dimenstrat
#rep same answer each time to funciton
#replicate same funciton different answer each time
rep(runif(1), 5)
replicate(5, runif(1))

#time_to_commute function uses sample to randomly pick a mode of transport, then uses rnorm or rlnorm to find a normally or lognormally distributed travel time

time_for_commute <- function()
{
	#choose a mode of transport for the day
	mode_of_transport <- sample(
		c("car", "bus", "train", "bike"),
		size = 1,
		prob = c(0.1, 0.2, 0.3, 0.4)
		)
	#Find the tiem to travel, depending upon mode of transport
	time <- switch(
		mode_of_transport,
		car = rlnorm(1, log(30), 0.5),
		bus = rlnorm(1, log(40), 0.5),
		train = rnorm(1, 30, 10),
		bike = rnorm(1, 60, 5)
		)
	names(time) <- mode_of_transport
	time
}

#The presence of a switch statement makes htis function very hard to vectorize. That means that to find the distribution of commuting times, we need ot repeatedly call time_for_commute to generate data for each day. replicate gives us instanct vectorization
replicate(5, time_for_commute())

#looping over lists
#apply faimly of functions can giveyou pretend vectorization, without the pain
#lapply short for list apply; takes a list and function as inputs, applies the function to each element of the list in turn, and returns another list of results

prime_factors <- list(
	two = 2,
	three = 3,
	four = c(2, 2),
	five = 5,
	six = c(2, 3),
	seven = 7,
	eight = c(2, 2, 2),
	nine = c(3, 3),
	ten = c(2, 5)
	)
head(prime_factors)

#trying to find the unique value in each list elemetn is diffficult to do in a vectorized way. we could write a for loop to examine each elemetn, but that's a little bit clunky

unique_primes <- vector("list", length(prime_factors))
for(i in seq_along(prime_factors))
{
	unique_primes[[i]] <- unique(prime_factors[[i]])
}
names(unique_primes) <- names(prime_factors)
unique_primes

#lapply makes this so much easier
lapply(prime_factors, unique)

#When the return value from the function is the same size each time, and you know what that size is, you can use a variant of lapply called vapply.Stands for "list apply that returns a vector." As before, you pass it a list and a function, but vapply takes a third argument that is a template for the return values. Rather than returning a list, it simplifies the result ot be a vctor or an array

vapply(prime_factors, length, numeric(1))

#sapply; "simplifying list apple"

sapply(prime_factors, unique) 		#returns a list
sapply(prime_factors, length)		#returns a vector
sapply(prime_factors, summary)		#returns an array

#if list has length zero, then sapply always returns a list

#the source function is used to read and evaluate the contents of an R file. Unfornunately it isn't vectorized, so if we wanted to run all the R scripts in a directory, then we need to wap the directory ina call to lapply
#In the next emple, dir returns the names of files in a gien director, defaulting to the current working dirrecoty. The argument patern = "\\.R$" means "only return filenames that end with .R"

r_files <- dir(pattern = "\\.R$")
lapply(r_files, source)

#to pass other scalar arguments ito teh function. To do this, pass in named arguments to the lapply(or s/v-apply) call, and they wil be passed to the inner function

complemented <- c(2, 3, 6, 18)
lapply(complemented, rep.int, times = 4)

#If the vector argument isn't the first one, we have to create our own function to wrap the function that we really wanted to call. You can do this on a separate line, but it is most common to include the function definition within the call to lapply

rep4x <- function(x) rep.int(4, times = x)
lapply(complemented, rep4x)

#This last code chunck can be made a little simpler by passing an anonymous function to lapply

lapply(complemented, function(x) rep.int(4, times = x))

#if you need to loop oevr every variable in an environment rather than a list, use eapply

env <- new.env()
env$molien <- c(1, 0, 1, 0, 1, 1, 2, 1, 3)
env$larry <- c("Really", "leery", "rarely", "Larry")
eapply(env, length)

#matlab
install.packages("matlab")
library(matlab)

#the magic function cretes a magic square - an n-by-n square matrix of the numebers from 1 to n^2, where each row and each column has the same total
(magic4 <- magic(4))

#A classic problem requiring us to apply a function by row is calculating the row totals. This can be achieved using the rowSUms function
rowSums(magic4)

#the apply function provide the row/column-wise equivalent of laply, taking a matrix, a dimension number, and a function as arguments. The dimension number is 1 for "apply the function across each row", or 2 "apply the function downw each column"( or bigger numbers for higher dimensional arrays)

apply(magic4, 1, sum)
apply(magic4, 1, toString)
apply(magic4, 2, toDtring)

#apply can also be used on data frames, though the mixed-data-type nature means that this is less common (for example, you can't sensibly calculate a sum or a product when there are charater columns)

(balwins <- data.frame(
	name = c("Alec", "Daniel", "Bily", "Stephen"),
	date_of_birth = c(
		"1958-Apr-03", "1960-Oct-05", "1963-Feb-21", "1966-May-12"
		),
	n_spouses = c(2, 3, 1, 1),
	n_children = c(1, 5, 3, 2),
	stringsAsFactors = FALSE
	))
apply(baldwins, 1, toString)
apply(baldwins, 2, toString)

sapply(baldwins, toString)
sapply(baldwins, range)

#Multiple-input apply
#mapply; "multiple argument list apply" lets you pass in as many vectors as you like, solving the first problem

msg <- function(name, factors)
{
	ifelse(
		length(factors) == 1,
		paste(name, "is prime"),
		paste(name, "has factors", toString(factors))
		)
}
mapply(msg, names(prime_factors), prime_factors)

#instant Vectorization
#The function Vectorize is a wrapper to mapply that takes a function that usually accepts a scaler input, and returns a new function that accepts vectors. This next function is not vectorized because of its use of switch, which requires a scaler input
baby_gender_report <- function(gender)
{
	switch(
		gender,
		male = "It's a boy",
		female = "It's a girl",
		"Um..."
		)
}

#If we pass a vector into the function, it will through an error
gender <- c("male", "female", "other")
baby_gender_report(genders)

#While it is theoretically possible to do a complete rewrite of a function that is inherently vectorized, it is easier to use the Vectorize function

vectorized_baby_gender_report <- Vectorize(baby_gender_report)
vectorized_baby_gender_report(genders)

#Split-Apply-Combine
# A really common problem when investigating data is how to calculate some sattistic on a variable that has been split inot groupd. Here are some scores on the classic road safety awareness computer game,  Frogger

(frogger_scores <- data.frame(
	player = rep(c("Tom", "Dick", "Harry"), times = c(2, 5, 3)),
	score = round(rlnorm(10, 8), -1)
	))

#If we want to calculate teh mean score for each player, then there are three seps. First we split the dataswt by player

(scores_by_player <- with(
	frogger_scores,
	split(score, player)
	))

#Next we apply the (mean) function to each element

(list_of_means_by_player <- lapply(scores_by_player, mean))

#Finally, we combine the result into a single vector

(mean_by_player <- unlist(list_of_means_by_player))

#The last two steps can be condensed into one by using vapply or sapply, but split-apply-combine is such a common task taht we need something easier. That something is the tapply function, whcih performs all three steps in one go

with(frogger_scores, tapply(score, player, mean))

#The plyr Package
#the *apply family of functions are mostly wonderful, but htey have three drawbacks. First the naems are a bit obscure. Secondly the arguments aren't entirely consistent. Thirdly the for of the output isn't as controllable as it could be.
#This is where the plyr package comes in handy. The package contains a set of functions named **ply, where the blanks (asterisks) denote the form of teh input and output, respectively. So , pply takes a list input, applies a function to each element, and returns a list, making it a drop-in replacement for lapply

library(plyr)
llply(prime_factors, unique)

#raply replaces replicate, but there are also rlply and rdply functions that let you return the result in list or data frame form, and an r_ply functionthat discards the result (useful for drawing plots)

raply(5, runif(1))		#array output
rlply(5, runif(1)) 		#list output
rdply(5, runif(1))		#data frame output
r_ply(5, runif(1))		#discarded output

#perhaps the most commonly used function in plyr is ddply, which takes data frames as inputs adn outputs and can be used as a replacemetn for tapply. Its big stregnth is that it makes it easy to make calculation on several columns at once. Lets add a level column to the Frogger dataset, denoting the level the player reached in the game

frogger_scores$level <- flor(log(frogger_scores$score))

#There are several different ways of calling ddply. All methods take a data frame, the name of the column(s) to split by, and the function to apply to each piece. The column is passed without quotes, but wrapped in a call to the . function
#For the function, you can either use colwise to ell ddply to call the function on every column (that you didn't mention in the second argument), or use summarize and specify manipulations of specific columns

ddply(
	frogger_scores,
	.(player),
	colwise(mean)
	)
ddply(
	frogger_scores,
	.(player),
	summarize,
	mean_score = mean(score),
	max_level = max(level)
	)

#colwise is quicker to specify, but you have to do teh same thing with each oclumn, wheras summarize is more flexible but requires more typing
#there is no direct replacement for mapply, though the m*ply fuctions allow looping with multiple arguments. likewise, there is no replacement for vapply or rapply

#Summary
#The apply family of functions provide cleaner code for looping
#Split-aply-combine problems, where you manipulate data split into groups, are really common
#The plyr package is a syntactically cleaner replavement for many apply functions