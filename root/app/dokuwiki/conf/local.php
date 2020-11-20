<?php
/**
 * This is an example of how a local.php could look like.
 * Simply copy the options you want to change from dokuwiki.php
 * to this file and change them.
 *
 * When using the installer, a correct local.php file be generated for
 * you automatically.
 */


//$conf['title']       = 'My Wiki';        //what to show in the title

//$conf['useacl']      = 1;                //Use Access Control Lists to restrict access?
//$conf['superuser']   = 'joe';

$conf['title']       = 'Zettelkasten';        //what to show in the title2
$conf['plugin']['gitbacked']['repoPath'] = './data/gitrepo/';
$conf['plugin']['gitbacked']['repoWorkDir'] = './data/gitrepo/';
$conf['plugin']['gitbacked']['addParams'] = '-c user.email=james.do@somewhere.com -c user.name=James';
$conf['plugin']['gitbacked']['pushAfterCommit'] = 0;
$conf['plugin']['gitbacked']['periodicPull'] = 10;
$conf['datadir'] = './data/gitrepo/pages';
$conf['mediadir'] = './data/gitrepo/media';

