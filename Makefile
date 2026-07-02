DIFF ?= diff -u

.PHONY: sort-lines unique clean

unique: sort-lines
	LC_ALL=UTF-8 sort -u -k1,1 essay.txt > essay.txt.unique
	$(DIFF) essay.txt essay.txt.unique && rm essay.txt.unique || exit 0

sort-lines:
	LC_ALL=UTF-8 sort essay.txt > essay.txt.new
	$(DIFF) essay.txt essay.txt.new && rm essay.txt.new || mv essay.txt.new essay.txt

clean:
	@rm -fv essay.txt.unique
