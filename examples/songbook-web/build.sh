#!/usr/bin/env sh

DOCUMENT_ROOT='/data/www/songbook.tumbolia.tk/root/'

npm update
npm run build
cp -r public/ "$DOCUMENT_ROOT"
