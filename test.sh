#!/usr/bin/env bash

teststr="askj ndakjsdn;k ajsdnkasjnd;kdajsnd;akjsn d"

folderParams=()

IFS=";"
for folderParam in $teststr; do
  folderParams+=("$folderParam")
  echo "loop $folderParam"
done

echo "${folderParams[0]}"
echo "${folderParams[1]}"
echo "${folderParams[2]}"
