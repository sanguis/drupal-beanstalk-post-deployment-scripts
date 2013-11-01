drupal-beanstalk-deplymentscripts
=================================

to be used with Beanstak in the script section.

add the bellow to the deployments scripts section to run
~~~bash
curl https://raw.github.com/sanguis/drupal-beanstalk-post-deployment-scripts/master/development.sh -O /tmp/%USER_NAME%-%REVISION%.sh
bash /tmp/%USER_NAME%-%REVISION%.sh %COMMENT% %REVISION% %USER_NAME%
~~~

