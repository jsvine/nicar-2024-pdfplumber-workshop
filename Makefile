.PHONY: notebooks

ALL_PDFS=$(patsubst src/%,pdfs/%,$(wildcard src/*.pdf))
ALL_NOTEBOOKS=$(wildcard notebooks/*.ipynb)

pdfs/%: src/%
	mutool clean -c $< $@ 

clear:
	find pdfs -type f -exec rm {} \;

pdfs: $(ALL_PDFS)

requirements: config/requirements.in
	@cd config && pip-compile requirements.in

venv: config/requirements.txt
	@if [ ! -d "venv" ]; then python3 -m venv venv; fi
	@venv/bin/pip install -r config/requirements.txt

test:
	@venv/bin/nbexec notebooks

lab:
	@venv/bin/jupyter lab

lint:
	venv/bin/nbqa black --check notebooks
	venv/bin/nbqa isort --check notebooks
	venv/bin/nbqa flake8 notebooks --max-line-length 88

format:
	venv/bin/nbqa black notebooks
	venv/bin/nbqa isort notebooks

notebooks:
	venv/bin/nbexec notebooks
