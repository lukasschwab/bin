# Just a util Makefile for regenerating README documentation.
#
# There's a bunch of unpleasant escaping to deal with the relationship between
# make variables and shell variables.

# Append subheadings and bashdoc output for each file to README.md.
docs: clean
	for file in $(shell git ls-files); do \
		if [ -x "$$file" ]; then \
			echo "\n### \`$$file\`\n" >> README.md; \
			echo "\`\`\`\n`bashdoc $$file | cut -c 3-`\n\`\`\`" >> README.md; \
		fi; \
	done

# Clear the generated docs: everything after the GENERATEDCONTENT line.
clean:
	sed -i '' '1,/GENERATEDCONTENT/!d' README.md;
