#!/bin/sh

repo=$1

mkdir -p ~/project/$repo/doc

git clone git@mediba-github:mediba-system/$repo.git ~/project/$repo/$repo || git clone git@mediba-github:mediba-kitada/$repo.git ~/project/$repo/$repo
git clone git@mediba-github:mediba-system/$repo.wiki.git ~/project/$repo/wiki || git clone git@mediba-github:mediba-kitada/$repo.wiki.git ~/project/$repo/wiki
