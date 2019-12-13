#!/bin/bash
# al opens the lexicographically last file in a directory with atom.
# The custom exemptions might become unwieldy; this may not be extensible.

atom $(ls | sort | sed '/README.md/d; /Makefile/d' | tail -1)
