#!/usr/bin/env bash

rsync -avhP --stats --del book/ book.hybridscan.app:hybrid-book
