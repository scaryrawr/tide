#!/bin/bash
set -e

# Use Makefile targets to install tide and test dependencies to avoid drift
make install littlecheck.py
