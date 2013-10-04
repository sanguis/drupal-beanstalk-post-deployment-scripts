#!/bin/sh

COMMENT = $1

if [ $COMMENT =~ "-updb-" ]; then
  echo "Clearing cache"
  drush -y updb
fi

if [ $COMMENT =~ "-fra-" ]; then
  drush -y fra
fi

if [ $COMMENT =~ "-bigups-" ]; then
  drush -y updb
  drush -y fra
  drush cc all
fi

if [ $COMMENT =~ "-cc-" ]; then
  drush cc all
fi

# making local log
DATE=date
echo "deployed %REVISION% on $DATE, by %USER_NAME%" >>  ~/.beanstalk.log
