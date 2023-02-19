# `pdfplumber`: A NICAR 2023 Workshop

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/jsvine/nicar-2023-pdfplumber-workshop/HEAD)

## Local installation instructions

### MacOS

```
make imagemagick-mac
make venv
```

### Linux

```
make imagemagick-linux
make venv
```

## To test that the installation worked

```
venv/bin/nbexec notebooks
```

... should not throw an error.

### If you encounter a "PolicyError"

Follow [these instructions](https://stackoverflow.com/a/52701227).

## Running Jupyter Lab

```
venv/bin/jupyter lab
```
