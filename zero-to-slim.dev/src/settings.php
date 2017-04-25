<?php
return [
    'settings' => [
        'displayErrorDetails' => true, // set to false in production
        'dbConn'=>[
          'username'=>'root',
          'password'=>'hart',
          'host'=>'localhost',
          'dbname'=>'mydb',
          'db'=>'mysql',
          'displayErrorDetails' => true,
        ],
        // Renderer settings
        'renderer' => [
            'template_path' => __DIR__ . '/../templates/',
        ],
        'session.handler' => null,
        // Monolog settings
        'logger' => [
            'name' => 'slim-app',
            'path' => __DIR__ . '/../logs/app.log',
        ],
    ],
];
