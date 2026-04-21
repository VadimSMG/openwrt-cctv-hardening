#!/bin/sh
for script in 01 02 03 04 05; do
  f=$(ls $script-*.sh)
  echo "Runnig $f..."
  sh "./$f"
done

echo "All configuration applied!"
