DIFF ?= diff

sort-lines:
	LC_ALL=UTF-8 sort essay.txt > essay.txt.new
	$(DIFF) essay.txt essay.txt.new && rm essay.txt.new || mv essay.txt.new essay.txt
