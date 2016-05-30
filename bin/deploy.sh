#!/bin/bash

rm -rf _site/
JEKYLL_ENV=production jekyll build
rsync -av --delete --no-perms -I -O * blato03:/var/www/dev.blat.es/
