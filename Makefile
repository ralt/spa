all:
	mkdir -p dist/
	sbcl --no-userinit --no-sysinit --non-interactive \
		--load ~/quicklisp/setup.lisp \
		--eval '(ql:quickload "swank")' \
		--eval '(ql:quickload "spa")' \
		--eval '(ql:write-asdf-manifest-file "quicklisp-manifest.txt")'
	buildapp --manifest-file quicklisp-manifest.txt --load-system spa --entry spa::main --compress-core

install:
	cp dist/spa /usr/local/bin/

clean:
	rm -rf dist/
	rm quicklisp-manifest.txt
