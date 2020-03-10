#!/usr/bin/env php
<?php

define('BASE_DIR',__DIR__);//this script dir
define('WORKING_DIR',trim(file_get_contents(__DIR__.'/.root')));//Root data dir

$domain=$argv[1]??die('Pls specified domain'.PHP_EOL);

echo 'Domain: '.$domain.PHP_EOL;
$domainDir=WORKING_DIR.'/'.$domain;
$webDir=$domainDir.'/web';
$dbDir=$domainDir.'/db';
$phpIniPath=$domainDir.'/php.ini';
$dockerComposePath=$domainDir.'/docker-compose.yml';
echo "create $domainDir".PHP_EOL;
@mkdir($domainDir);
echo "create $webDir".PHP_EOL;
@mkdir($webDir);
echo "create $dbDir".PHP_EOL;
@mkdir($dbDir);

echo "create $phpIniPath".PHP_EOL;
copy(__DIR__.'/php.ini',$phpIniPath);

echo "create $dockerComposePath".PHP_EOL;
$dockerCompose=file_get_contents(__DIR__.'/docker-compose-template.yml');
$replacements=[
	'{web_path}'=>$webDir,
	'{db_path}'=>$dbDir,
	'{php_ini_path}'=>$phpIniPath,
	'{domain}'=>$domain,
];
$dockerCompose=str_replace(array_keys($replacements),array_values($replacements),$dockerCompose);
file_put_contents($dockerComposePath,$dockerCompose);

echo 'Created: '.$domain.PHP_EOL;
