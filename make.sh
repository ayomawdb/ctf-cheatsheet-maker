#!/bin/bash
TARGET_IP=$1
TARGET_PORT=$2
SOURCE_IP=$3
SOURCE_PORT=$4
if [[ ! $SOURCE_IP =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
  SOURCE_IP=`ifconfig | grep -A1 "$SOURCE_IP" | grep "inet" |  tr -s " " | cut -d " " -f3`
fi

for file in commands*.txt; do
  fileTitle=${file/commands_/}
  fileTitle=${fileTitle/.txt/}
  echo ""
  echo "------------------------------------------------------------------------"
  echo "            $fileTitle "
  echo "------------------------------------------------------------------------"
  while IFS="" read -r line || [ -n "$line" ]
  do
    line="${line//@TI/$TARGET_IP}"
    line="${line//@TP/$TARGET_PORT}"
    line="${line//@SI/$SOURCE_IP}"
    line="${line//@SP/$SOURCE_PORT}"
    echo $line
    echo ""
  done < $file
done
