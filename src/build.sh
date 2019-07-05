#!/bin/bash

# create template
# stack install hakyll

# cd ~/git/hakyll

# ~/.local/bin/hakyll-init faesmath
# stack new faesmath hakyll-template # keep getting problems with this one

# cd faesmath
# git add origin git@github.com:faesmath/faesmath.github.io.git

#  rm -rf /Users/soutomaiormenc2/.stack/precompiled/x86_64-osx/ghc-8.4.3/2.2.0.1/haddock-library-1.5.0.1\@sha256\:bbfba77cecd79afb92b6f9eb43d08e092000e91638df1f265b1f061c20bd5f3a\,4684/
# https://github.com/commercialhaskell/stack/issues/4071

# stack init  # creates stack.yaml file based on my-site.cabal

# stack build

# stack exec site build
# stack exec site watch  # http://127.0.0.1:8000/.

HOMEDIR=$1

# Temporarily store uncommited changes
cd $HOMEDIR/git/faesmath.github.io/src
#git stash

# Verify correct branch
git checkout develop
cp -r $HOMEDIR/git/faesmath.github.io/src/ $HOMEDIR/git/faesmathsrccopy/

# git stage <modified files here>
git stage .
git commit -m "shell build"
git push origin develop

# Build new files
stack exec site clean
stack exec site build
# stack exec site watch

# Get previous files
#git fetch --all
cd ..
git checkout master # --track origin/master

# Overwrite existing files with new files
# cp -archive _site/. ../
cp -a src/_site/. .

# Commit
git stage -A
git commit -m "publish"

# Push
git push origin master
git checkout develop

# Restoration
#git checkout develop
#git branch -D master
#git stash pop