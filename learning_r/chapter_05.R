#lists
(a_list <- list(
	c(1, 1, 2, 5, 14, 42),
	month.abb,
	matrix(c(3, -8, 1, 3), nrow = 2),
	asin
	))
As with vectors you can name elments during consruction, or afterward wing names function
names(a_list) <- c("catalan", "months", "involutary", "arcsin")
	a_list

	(the_same_list <- list(
		catalan = c(1, 1, 2, 5, 14, 42),
		months = month.abb,
		incolutary - matrix(c(3, -8, 1, -3), nrow = 2),
		arcsin = asin
	))



#It's even possible for elements of lists to be lissts themselves
(main_list <- list(
	middle_list = list(
		element_in_middle_list = diag(3),
		inner_list = list(
			element_in_inner_list - pi ^ 1:4,
			another_element_in_inner_list = "a"
		)
	),
	element_in_main_list = log10(1:10)
))
	#Atomic and Recursive Variables
		#lists are considered recursive because of their recursive nature (lists within lists)
		#Vectors, matrices, and arrays are atomic
		#can test which are which with is.atomic() and is.recursive()
	#List Dimensions and Arithmetic
		#lists have a length
		#like vectors, but unlike matrices, lists don't have dimensions, so dim() will return NULL
		#use NROW and NCOL for lists like with vectors
	#Indexing lists
		#[] and [[]] used as in python
	#Converting between Vectors and lists
		#use as.list to convert vector to a list
	#Combining lists
		#use the c funstion

c(list(a = 1, b = 2), list(3))

		#if used for lists and vector vectors become lists
		#can also use cbind and rbind but results are funky

#Null
	#can be used to remove elements of a list

uk_bank_holidays_2013$Jan <- NULL 			#removes january from list
uk_bank_holidays_2013$Feb <- NULL 			#removes feburary from list
uk_bank_holidays_2013

	#to set an existing element to NULL we must use list(NULL)

uk_bank_holidays_2013["Aug"] <- list(NULL)
uk_bank_holidays_2013


#Pairlists
	#used internally to pass arguments into functions
	#shouldn't have to worry about them

#Data Frames
	#Creating data frames
		#use data.frame function

(a_data_frame <- data.frame(
	x = letters[1:5],
	y = rnorn(5),
	z = runif(5) > 0.5
))
class(a_data_frame)

		#If any of the input vectors had names, then the row names would have been takdn from teh first such vector

y <- rnorm(5)
names(y) <- month[1:5]
data.frame(
	x = letters[1:5],
	y = y,
	z = runif(5) > 0.5
)

		#can be over ridden with row.names = NULL within the data.frame function

y <- rnorm(5)
names(y) <- month[1:5]
data.frame(
	x = letters[1:5],
	y = y,
	z = runif(5) > 0.5
	row.names = NULL
)

		#It is possible to create a data frame by passing different length of vectors, as long as the lengths allow the shorter ones to be reycled an exact number of times. More techniclaly, the lowest common multiple of all the lengths must be equal to the longest vector

data.fram(
	x = 1,
	y = 2:3,
	z = 4:7
)

		#when creating data frames the column names are checked to be unique, valid variable names. turn this off by passing check.names = FALSE to data.frame
	#subset()
		#provides a clean way to subset a data frame for certain conditions
		#takes up to three arguments: a data frame to subset, a logical vector of conditions for rows to include, and a vector of column names to keep(if this last argument is omitted, then all teh columns are kept)

a_data_frame[a_data_frame$y > 0 | a_data_frame$z, "x"]
subset(a_data_frame, y > 0, z, x)

	#Basic data frame manipulation
		#can use t() but all the columns are converted to the same type adn the whoel thing becomes a matrix
		#can use cbind and rbind to join dfs together. rbind is smart enough to reorder the columns to match. cbind doesn't check colmn names for duplicates, though
		#Where two data frames share a column, they can be merged together using the merge function
		#to join with merge you'll need to specify which columns contain tehkey values to match up

merge(a_data_frame, another_data_frame, by = "x")
merge(a_data_frame, another_data_frame, by = "x", all = TRUE)

	#Where a data frame has all numeric values, the functions colSums and colMeans can be used to calculate the sums and meansof ech column, respectively.
	#Same for rowSums and rowMeans

colSums(a_data_frame[,2:3])
colMeans(a_data_fram[,2:3])


#Summary:
	#Lists can contain different sizes and types of variables in each elemetn
	#Lists are recursive variables, since they can contain other lists
	#You can index lists using [], [[]], or $
	#NULL is a special value that can be used to create "empty" list elements
	#Data frames store spreadsheet-like data
	#Data frames have some properties of matrices (they are rectangular), and some of lists (different columns can contain different sorts of variables)
	#Data frames can be indexed like matrices or like lists
	#merge lets you do database-style joins on data frames
