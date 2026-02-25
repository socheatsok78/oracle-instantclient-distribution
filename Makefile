SCRIPTDIR := scripts

it: tags.json releases.json library
releases.json:
	./$(SCRIPTDIR)/releases.sh tags.json | tee releases.json
tags.json:
	./$(SCRIPTDIR)/tags.sh | tee tags.json
library:
	./$(SCRIPTDIR)/library.sh releases.json
