#!/usr/bin/env php
<?php
define('WORKING_DIR',__DIR__);//Root data dir
define('BASE_DIR',__DIR__);//this script dir
$domain=$argv[1]??die('Pls specified domain');

echo 'Domain: '.$domain.PHP_EOL;
$domainDir=WORKING_DIR.'/'.$domain;
$webDir=$domainDir.'/web';
$dbDir=$domainDir.'/db';
$phpIniPath=$domainDir.'/php.ini';
copy(__DIR__.'/php.ini',$phpIniPath);
@mkdir($domain);
@mkdir($webDir);
@mkdir($dbDir);

$dockerCompose=file_get_contents(__DIR__.'/docker-compose-template.yml');
$replacements=[
	'{web_path}'=>$webDir,
	'{db_path}'=>$dbDir,
	'{php_ini_path}'=>$phpIniPath,
	'{domain}'=>$domain,
];
$dockerCompose=str_replace(array_keys($replacements),array_values($replacements),$dockerCompose);
file_put_contents($domainDir.'/docker-compose.yml',$dockerCompose);

echo 'Created: '.$domainDir.PHP_EOL;
