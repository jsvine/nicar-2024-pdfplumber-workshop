.PHONY: notebooks

ALL_PDFS=$(patsubst src/%,pdfs/%,$(wildcard src/*.pdf))
ALL_NOTEBOOKS=$(wildcard notebooks/*.ipynb)

pdfs/%: src/%
	mutool clean -c $< $@ 

clear:
	find pdfs -type f -exec rm {} \;

pdfs: $(ALL_PDFS)

requirements.txt: requirements.in
	@pip-compile requirements.in

imagemagick-mac:
	@brew install freetype imagemagick@7
	@if [ ! -f "/usr/local/lib/libMagickWand.dylib" ]; then find $$(brew --prefix imagemagick@7)/lib -name "libMagickWand*.dylib" -type f -exec ln -s {} /usr/local/lib/libMagickWand.dylib \;; fi

venv: requirements.txt
	@if [ ! -d "venv" ]; then python3 -m venv venv; fi
	@venv/bin/pip install -r requirements.txt

lint:
	nbqa black --check notebooks
	nbqa isort --check notebooks
	nbqa flake8 notebooks

format:
	nbqa black notebooks
	nbqa isort notebooks

notebooks:
	nbexec notebooks
