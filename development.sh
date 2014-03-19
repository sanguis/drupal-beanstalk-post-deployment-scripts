#!/bin/bash
# how to run development.sh "%COMMENT%" %REVISION% %USER_NAME%

COMMENT=$1
DATE=$(date)
LOGFILE="$HOME/.beanstalk.log"

while getopts "l:" opt; do
  case $opt in
    l)
      echo "starts as: $LOGFILE"
      echo "log file is: $OPTARG" 
      LOGFILE=$OPTARG
      echo "logfile should be: $LOGFILE"
      ;;
  esac
done

if [[ $COMMENT =~ "-dbdump-" ]]; then
  echo "Clearing cache"
  drush sql-dump > /tmp/"$DATE"-bs-dump.sql
fi

if [[ $COMMENT =~ "-updb-" ]]; then
  echo "Clearing cache"
  drush -y updb
fi

if [[ $COMMENT =~ "-fra-" ]]; then
  drush -y fra
fi

if [[ $COMMENT =~ "-bigups-" ]]; then
  drush -y updb
  drush -y fra
  drush cc all
fi

if [[ $COMMENT =~ "-cc_all-" ]]; then
  drush cc all
fi

if [[ $COMMENT =~ "-cc_cssjs-" ]]; then
  drush cc ccs-js
fi

if [[ $COMMENT =~ "-cc_blocks-" ]]; then
  drush cc block
fi


# making local log

echo "deployed $2 on $DATE, by $3" >> $LOGFILE 
