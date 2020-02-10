#Cleaning and Transforming
#to replace "Y" and "N" with TRUE or FALSE respectivly

yn_to_logical <- function(x){
	y <- rep.int(NA, length(x))
	y[x == "Y"] <- TRUE
	y[x == "N"] <- FALSE
}

#Setting the values to NA by default lets us deal with strings that don't match "Y" or "N". We call the function in the obvious way

alpe_d_huez$DrugUse <- yn_to_logical(alpe_d_huez$DrugUse)

#the grep, grepl, adn regexpr functions all find strings that match a pattern, and sub and gsub replece matching strings.

#to detect a pattern, we use the str_detect function. The fixed fuction tells str_detect that we are looking for a fixed string rather than a regex. str_detect returns a logical vector that we can use for an index

library(stringr)
multiple_kingdoms <- str_detect(english_monarchs$domain, fixed(","))
english_monarchs[multiple_kingdoms, c("name", "domain")]

#searching for a comma or the word 'and' using regex

multiple_rulers <- str_detect(english_monarchs$name, ",|and")
english_monarchs$name[multiple_rulers & !is.na(multiple_rulers)]

#suppose we want to addd a column to the english_monarchs data frame denoting the number of years the rulers were in power. WE can use standard assignment to achieve this:

english_monarchs$length.of.reign.years <- english_monarchs$end.of.reign - english_monarchs$start.of.reign

#This works but there's an easier way
#The with function makes things easier by letting you call variables directly. It taeks a data frame or environment and an expression to evaluate

english_monarchs$length.of.reign.years <- with(
	english_monarchs,
	end.of.reign - start.of.reign
	)

#The within function works in a similar way, but returns the whole data frame

english_monarchs <- within(
	english_monarchs,
	{
		length.of.reign.years <- end.of.reign - start.of.reign
	}
	)

#although within requires more efort in this example, it becomes more useful if ou want to change multiple columns

english_monarchs<- within(
	english_monarchs,
	{
		length.of.reign.years <- end.of.reign - start.of.reign
		reign.was.more.than.30.years <- length.of.reign.years > 30
	}
	)

# A good heuristic is that if you are creating or chaning one column, then use with; if you want to manipulate weveral columns at once, then use within.

# An alternative approach is taken by the mutate function in the plyr package, which accepts new an revised columns as name-value pairs

english_monarchs <- mutate(
	english_monarchs,
	length.of.reign.years = end.of.reign - start.of.reign,
	reign.was.more.than.30.years = length.of.reign.years > 30
	)

#Sorting
#the sort value will sort numeric data
x <- c(2, 32, 4, 16, 8)
sort(x)
sort(x, decreasing = TRUE)

#Functional Programming
#The negate function accepts a predicate (that is, a function that reutrns a logical vector), and returns another predicate that does the oposite. It returns TRUE when the input returns FALSE and FALSE when the input returns TRUE

ct2 <- deer_endocranial_volume$VolCT2
isnt.na <- Negate(is.na)
identical(isnt.na(ct2), !is.na(ct2))

#Filter takes a function taht returns a logical vector and an input vector, and returns only hose values where the function returns TRUE

Filter(isnt.na, ct2)

#The position function behaves a little bit like which which we saw in "VECTORS". It reutrns the first index where applying a predicate to a vector returns TRUE

Position(isnt.na, ct2)

#Find is similar to Posistion, but it returns teh first value rather than the first index

Find(isnt.na, ct2)

#Map applies a function element-wase to its inputs. It's just a wrapper to mapply, with SIMPLIFY = FLASE. In this next example, we retrieve the average measurement using each method fo reach deer in the red deer dataset. First, we need a function to pass to Map to find the colume of each deer skull

get_volume <- function(ct, bead, lwh, finarelli, ct2, bead2, lwh2)
{
	#If there is a second measurement, take the average
	if(!is.na(ct2))
	{
		ct < (ct + ct2) / 2
		bead <- (bead + bead2) / 2
		lwh <- (lwh + lwh2) / 2
	}
	#Divide lwh by4 to bring it in line with other measurements
	c(ct = ct, bead = bead, lwh.4 = lwh / 4, finarelli = finarelli)
}

#Then Map behaves like mapply - it taeks a function and then each argument to pass to that function

measurements_by_deer <- with(
	deer_endocranial_volume,
	Map(
		get_volume,
		VolCT,
		VolLWH,
		VolFinarelli,
		VolCT2,
		VolBead2,
		VolLWH2
		)
	)
head(measurements_by_deer)

#Summary
#The stringr packaeg is useful for maipulating strings
#Columns of a data frame can be added, subtracted, or manipulated
#Data frames can exist in wide or long form
#Vectors can be sorted, ranked, and ordered