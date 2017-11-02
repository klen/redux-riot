$(CURDIR)/node_modules: $(CURDIR)/package.json
	npm install
	@touch $(CURDIR)/node_modules

build: $(CURDIR)/node_modules
	$(CURDIR)/node_modules/.bin/coffee -t -b -o lib/ -c src/

publish:
	npm publish

test t: $(CURDIR)/node_modules
	node tests/runner.js

release:
	make build
	bumpversion patch
	make publish
	git checkout master
	git merge develop
	git checkout develop
	git push origin develop master
