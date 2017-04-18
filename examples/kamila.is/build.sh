#!/usr/bin/env sh

# Used together with `post-receive-clone-and-build` for a Jekyll site
# see https://github.com/AnotherKamila/kamila.is/tree/master/_bin

DOCUMENT_ROOT='/data/www/kamila.is/root/'

_bin/setup
_bin/deploy "$DOCUMENT_ROOT"
