MOCHA = ./node_modules/.bin/mocha
REPORTER = dot
GREP = ""
BROWSER = xdg-open
JSCOVERAGE = jscoverage
COFFEE = ./node_modules/.bin/coffee

test:
	@$(MOCHA) \
		--compilers coffee:coffee-script \
		--reporter $(REPORTER) \
		--grep $(GREP) \
		test/*.coffee
	
test-cov: lib-cov
	@FIXR_COV=1 $(MAKE) --no-print-directory test \
		REPORTER=html-cov > coverage.html
	@$(BROWSER) ./coverage.html
	
lib-cov: lib-compile
	@$(JSCOVERAGE) --no-highlight lib lib-cov
	
lib-compile:
	@$(COFFEE) -c lib
	
clean:
	@rm -rf lib/*.js lib/engines/*.js lib-cov coverage.html
	
.PHONY: test lib-cov
