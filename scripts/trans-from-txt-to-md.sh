#!/bin/bash
set -e
show_help () {
cat << USAGE
usage: $0 [ -f TRANSFORM-FROM ] [ -t TRANSFORM-TO ]

    -f : Specify the file that transform from.  
    -t : Specify the file that transform to.  

USAGE
exit 0
}
# Get Opts
while getopts "hf:t:" opt; do # 选项后面的冒号表示该选项需要参数
    case "$opt" in
    h)  show_help
        ;;
    f)  FROM=$OPTARG
        ;;
    t)  TO=$OPTARG
        ;;
    ?)  # 当有不认识的选项的时候arg为?
        echo "unkonw argument"
        exit 1
        ;;
    esac
done
[ -z "$*" ] && show_help
chk_var () {
if [ -z "$2" ]; then
  echo "$(date -d today +'%Y-%m-%d %H:%M:%S') - [ERROR] - no input for \"$1\", try \"$0 -h\"."
  sleep 3
  exit 1
fi
}
chk_var -f ${FROM}
chk_var -t ${TO}
MD=${TO}
[[ -f $MD ]] && rm -f $MD
[[ -f $MD ]] || touch $MD
cat $FROM | while read LINE; do
  LINE="${LINE}{{.placeholder}}"
  echo $LINE >> $MD
done
sed -i s?"{{.placeholder}}"?"  "? $MD
exit 0
