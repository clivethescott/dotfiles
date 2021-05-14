#!/bin/sh
man $(man -k . | fzf | awk '{ print $1 }')
