#!/bin/bash

python -m pip install -q mkdocs mkdocs-carbon mkdocs-glightbox mkdocs-redirects
mkdocs build --clean --strict
