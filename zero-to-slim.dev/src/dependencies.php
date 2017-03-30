<?php
// DIC configuration

$container = $app->getContainer();

// view renderer
$container['renderer'] = function ($c) {
    $settings = $c->get('settings')['renderer'];
    return new Slim\Views\PhpRenderer($settings['template_path']);
};

// monolog
$container['logger'] = function ($c) {
    $settings = $c->get('settings')['logger'];
    $logger = new Monolog\Logger($settings['name']);
    $logger->pushProcessor(new Monolog\Processor\UidProcessor());
    $logger->pushHandler(new Monolog\Handler\StreamHandler($settings['path'], Monolog\Logger::DEBUG));
    return $logger;
};
/*$container['dbConn'] = function($c){
  $db = new PDO('mysql:host=localhost;dbname=nutrition;charset=utf8mb4','root','Rcs12345');
  return $db;
};*/
$container['dbConn'] = function ($c) {
    $settings = $c->get('settings')['dbConn'];
    $connString = $settings['db'] . ':host=' . $settings['host'];//localhost to host
    $connString .=';dbname=' . $settings['dbname'] . ';charset=utf8mb4';

    $db = new PDO($connString, $settings['username'], $settings['password']);
    return $db;
};
$container['notFoundHandler'] = function($c){
    return function ($request, $response) use ($c){
      return $c['response']
        ->withStatus(404)
        ->withHeader('Content-Type','text/html')
        ->write('Page not found');
    };
};
