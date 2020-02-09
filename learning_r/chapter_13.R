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