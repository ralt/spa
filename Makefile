all:
	mkdir -p dist/
	buildapp --output dist/spa --load-system spa --asdf-tree ~/quicklisp/ --entry spa::main --compress-core

install:
	cp dist/spa /usr/local/bin/

clean:
	rm -rf dist/
