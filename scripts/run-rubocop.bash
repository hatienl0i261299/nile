#!/usr/bin/env bash

set -e

cd "${0%/*}/.."

echo "Running rubocop"
rubocop -A