#the sample function
	gender_char <- sample(c("femal","male"), 10000, replace = TRUE)
	gender_fac <- as.factor(gender_char)
	object.size(gender_char)
	## 80136 bytes
	object.size(gender_fac)
	## 40512 bytes

