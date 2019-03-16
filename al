#!/bin/bash
# al opens the lexicographically last file in a directory with atom.
atom $(ls | sort | sed '/README.md/d' | tail -1)
