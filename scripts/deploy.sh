#!/usr/bin/env bash

mdbook build
rsync -avhP --stats --del book/ book.hybridscan.app:hybrid-book
