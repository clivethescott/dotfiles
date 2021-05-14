#!/bin/sh

curl \
  -X DELETE \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token $TOKEN" \
   "https://api.github.com/repos/clivethescott/$1"

