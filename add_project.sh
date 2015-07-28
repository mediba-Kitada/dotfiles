#!/bin/sh

repo=$1

mkdir -p ~/project/$repo/doc

git clone git@github.com:mediba-system/$repo.git ~/project/$repo/$repo
git clone git@github.com:mediba-system/$repo.wiki.git ~/project/$repo/wiki
