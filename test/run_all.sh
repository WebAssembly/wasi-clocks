#!/usr/bin/env

runtime=$1
shift

for input in $@; do
  echo "$input"
  $runtime $input && echo "PASS" || echo "FAIL"
done
