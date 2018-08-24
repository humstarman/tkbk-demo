#!/bin/bash
show_help () {
cat << USAGE
usage: $0 [ -p PRICE ] [ -f FROM ]

    -p : Specify the price to compare.  
    -f : Specify the file to get prices from.

USAGE
exit 0
}
# Get Opts
while getopts "hp:f:" opt; do # 选项后面的冒号表示该选项需要参数
    case "$opt" in
    h)  show_help
        ;;
    p)  PRICE=$OPTARG
        ;;
    f)  FROM=$OPTARG
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
chk_var -p ${PRICE}
TMP=/tmp/price.tmp
yes | cp ${FROM} ${TMP}
sed -i '1d' ${TMP}
cat ${TMP} | while read LINE; do
  STR=$(echo $LINE | tr " " "?")
  P=$(echo $STR | awk -F '?' '{print $2}')
  P=${P%%.*}
  if [[ $P -lt $PRICE ]]; then
    THIS_DIR=$(cd "$(dirname "$0")";pwd)
    cd $THIS_DIR/.. && make all
    exit 0
  fi
done
