#!/usr/bin/env bash

mdbook build
rsync -avhP --stats --del book/ book.index.acuity.network:book.index.acuity.network
