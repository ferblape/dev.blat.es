#!/bin/bash

rsync -av --delete --no-perms -I -O * blato03:/var/www/dev.blat.es/
