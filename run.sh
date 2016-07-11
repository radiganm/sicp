#!/bin/zsh
## run.sh
## Mac Radigan

for file in $( find ./chapter-*/sicp*.scm |grep -v sicp_ch1_e1-5 ); do
  d=${file%/*}
  f=${file##*/}
  n=${f%.*}
  e=${f##*.}
  in=./$f
  out=../output/$n.out
  (cd $d; echo "## $in\n" |tee    $out)
  (cd $d; ./$in           |tee -a $out)
done

## *EOF*
