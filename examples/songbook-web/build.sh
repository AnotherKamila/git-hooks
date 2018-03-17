#!/usr/bin/env sh

set -e

DOCUMENT_ROOT='/data/www/songbook.tumbolia.tk/root/'

npm update
npm run build
cp -r public/ "$DOCUMENT_ROOT"
