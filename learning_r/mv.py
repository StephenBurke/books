#function that copy and pastes files
def mv(file_1, file_2):
	r = open(file_1, "r")
	s = open(file_2, "w")

	for line in r:
		s.write(line)
	r.close()
	s.close()

mv("new_chapter_06.R", "chapter_06.R")