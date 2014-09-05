#!/bin/bash
# how to run development.sh "%COMMENT%" %REVISION% %USER_NAME%
#echo $@\n
COMMENT=$1
DATE=$(date)
LOGFILE="$HOME/.beanstalk.log"
ALIAS="@self"

while getopts "123la" opt; do
  case $opt in
    l)
      echo "target $OPTARG"
      LOGFILE=$OPTARG
      echo "log: $LOGFILE"
      ;;
    a)
     echo "Running commands against drush alias $OPTARG"
     ALIAS=$OPTARG;
     ;;
  esac
done

#TODO: Make commands collect in an array and then run them all in a batch
if [[ $COMMENT =~ "-dbdump-" ]]; then
  drush  $ALIAS sql-dump > /tmp/"$DATE"-bs-dump.sql
fi

if [[ $COMMENT =~ "-updb-" ]]; then
  drush $ALIAS -y updb
fi

if [[ $COMMENT =~ "-fra-" ]]; then
  drush $ALIAS -y fra
fi

if [[ $COMMENT =~ "-bigups-" ]]; then
  drush $ALIAS -y updb
  drush $ALIAS -y fra
  drush $ALIAS cc all
fi

if [[ $COMMENT =~ "-cc_all-" ]]; then
  drush $ALIAS cc all
fi

if [[ $COMMENT =~ "-cc_cssjs-" ]]; then
  drush $ALIAS cc ccs-js
fi

if [[ $COMMENT =~ "-cc_blocks-" ]]; then
  drush $ALIAS cc block
fi

if [[ $COMMENT =~ "-cron-" ]]; then
  drush $ALIAS cron
fi

# making local log

echo "deployed $2 on $DATE, by $3" >> $LOGFILE 
