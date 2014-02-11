#!/bin/sh

repo=$1

git clone git@github.com:mediba-system/$repo.git ~/project/$repo

mkdir -p ~/project/$repo/doc
