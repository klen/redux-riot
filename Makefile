build:
	$(CURDIR)/node_modules/.bin/coffee -o lib/ -c src/

publish:
	npm publish
