#Vectors, Matrices, and Arrays

#Sequences
	#seq.int()
		#lets us create a sequence from one number to another

		seq.int(3, 12)		#same as 3:12
		## 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
		seq.int(3, 12, 2)
		## 3, 5, 7, 9, 11

	#seq_len()
		#creates a sequence from 1 up to its input
	#seq_along()
		#create a sequence from 1 up to the length of its input

		pp <- c("peter", "Piper", "picked", "a", "peck", "of", "pickeled", "peppers")
		for(i in seq_along(pp) print(pp[i]))


#Lengths
	#tells us how many elements vectors contain

	length(1:5)
	## [1] 5

	nchar()
		#for number of characters in a character vector

#Names
	#you can specify names when you create a vector in the form
		#name = value

	c(apple = 1, banana = 2, "kiwi fruit" = 3, 4)
	## 	apple	banana	kiwi fruit
	## 	1		2		3			4

	#can also add element names

	x <- 1:4
	names(x) <- c("apple", "banana", "kiwi fruit", " ")


#Indexing vectors
	#Passing a vector of positive numbers retruns the slice of the vector conaining the elements at those locations.
	#passing a vector of negative numbers returns the slice of the vector containing the elements everywhere except at hose locations
	#passing a logical vector returns the silce of the vector containing teh elemetns where the index is true
	#for named vectors, passing a character vector of names returns teh slice of teh vector containing the elemetns with those names

	#can't mix positive and negative  numbers

#Vector Recycling and Repetition
	#"what happens if I try to do arithmetic on vectors of different length?"
		#If we try to add a single nember to a vector then that number is added to each elemetn of teh vector

		1:5 + 1
		## 2 3 4 5 6
		1 + 1:5
		## 2 3 4 5 6

		#When adding two vectors together, R will reccle elemetns in the shorter vector to match the longer one

		1:5 + 1:15
		## 2 4 6 8 10 7 9 11 13 15 12 14 16 18 20

		#If the length of the longer vector isn't a multiple of the length of the shorter one, a warning will be given

		1:5 + 1:7
		## Warning: longer object length is not a multiple of shorter oblect length

	#rep()
		#explicitly create equal-length vectors before we operate on them

		rep(1:5, 3)
		## [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
		rep(1:5, each = 3)
		## [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
		rep(1:5, times = 1:5)
		## [1] 1 2 2 3 3 3 4 4 4 4 5 5 5 5 5
		rep(1:5, length.out = 7)
		## [1] 1 2 3 4 5 1 2

		#like seq rep has a simpler adn faster varient, rep.int, for the most common case:

		rep.int(1:5, 3) 		# the same as rep(1:5, 3)
		## [1] 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5

	#rep_len()
		#paralleling seq_len

		rep_len(1:5, 13)
		## [1] 1 2 3 4 5 1 2 3 4 5 1 2 3


#Matrices and Arrays
	#Creating Arrays and Matrices
		#to create an array call the array function, passing in a vector of values and a cector of dimensions. Optionally, you can also provide naems for each dimension

		(three_d_array <- array(
			1:24,
			dim = c(4, 3, 2),
			dimnames = list(
				c("one", "two", "three", "four"),
				c("ein", "zwei", "drei"),
				c("un", "deux")
			)
		))

		#to create a matrix do the same but with matrix() and rather than dim specify the number of rows or the number of columns

		(a_matrix <- matrix(
			1:12,
			nrow = 4,			#ncol = 3 works the same
			dimnames = list(
				c("one", "two", "three", "four"),
				c("ein", "zwei", "drei")
			)
		))

		#This matrix can also be created using the array function

		(two_d_array <- array(
			1:12,
			dim = c(4, 3),
			dimnames = list(
				c("one","two","three", "four"),
				c("ein", "zwei", "drei")
			)
		))

		#when you create a matrix, the values you passed in fill the matrix column-wise. It wis also possible to fill the matrix row-wise by specifiying the arument byrow = TRUE

		matrix(
			1:12,
			nrow = 4,
			byrow = TRUE,
			dimnames = list(
				c("one","two","three", "four"),
				c("ein", "zwei", "drei")
			)
		)

	#Rows Columns and Dimensions
		#dim()
			#returns a cector of integers of the mensions of he variable
		#nrow() and ncol()
			#return the number of rows and columns in a matrix
		#length()
			#works on matrices and arrays
		#ncol(), nrow(), and dim()
			#return NULL when applied to vectors
			#use NROW(), and NCOL() instead
	#Row Column and Dimension Names
		#use rowname(), colname(), and dimnames() for matrices
	#Indexing Arrays
		#use [row, col]
		#to include all of a dimension leave the corresponding index blank
	#Combining Matrices
		#cbind() and rbind()
			#bind matrices together by columns and rows

		cbind(a_matrix, another_matrix)
		rbind(a_matrix, another_matrix)

	#Array Arithmetic
		#The standard operators(+, -, \*, /) work element-wise on matrices and arrays, just like with vectors
		#t()
			#transposes matrices(but not higher-dimensional arrays, where the concept isn't well defined)
		#for inner and outer matrix multipication, we have %*% and %o%. In each case, teh dimensionnaenms are taken from the first input if they exist

		a_matrix %*% t(a_matrix)		#inner multiplication
		1:3 %o% 4:6						#outer multiplication
		outer(1:3, 4:6)					#same as ^^

#Summary:
	#seq and its variants let you create sequence of numbers
	#Vectors have a length that can be accessed or set with teh length function
	#You can name elements of vectors, either when tehy are created or whith the names function
	#You can access slices of a vector by passing an index into square brackets. The rep function creates a vector with repeated elements
	#Arrays are multidimensionsl abjects, withh matrices being the special case of two-dimensional arrays
	#nrow, ncol, and dim provide ways of accessing the dimensions of an array
	#Likewise, rownames, colnames, and dimnames access the names of array dimensions
