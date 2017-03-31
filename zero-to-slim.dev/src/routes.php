<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST,GET,OPTIONS');
header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');

// header("Access-Control-Allow-Headers: Content-Type");
// header('Access-Control-Allow-Origin: *');
//
// header('Access-Control-Allow-Methods: GET, POST');
//
// header("Access-Control-Allow-Headers: X-Requested-With");
// Routes
$servername = "localhost";
$username = "root";

date_default_timezone_set('America/Chicago');
$app->post('/forgot', function($request,$response,$args){
// 	require '../vendor/autoload.php';
// 	$forgot = file_get_contents('forgot.html', true);
// // If you are not using Composer
// // require("path/to/sendgrid-php/sendgrid-php.php");
// 	$db = $this->dbConn;
//  	 $data = $request->getParsedBody();
//  	 $id = $data['id'];
// 	$sql = "SELECT email
// 		FROM STUDENT
// 		WHERE STUDENT.id = '$id';";
// 	 $result = $db->query($sql);
//   	$arr = $result->fetch(PDO::FETCH_ASSOC);
//  	 $email = $arr['email'];
// 	$from = new SendGrid\Email("Example User", 'rupalsanghavi@gmail.com');
// 	$subject = "Sending with SendGrid is Fun";
// 	$to = new SendGrid\Email("Example User", $email);
// 	$content = new SendGrid\Content("text/html", $forgot);
// 	$mail = new SendGrid\Mail($from, $subject, $to, $content);
// 	//$apiKey = getenv('SENDGRID_API_KEY');
// 	$apiKey = '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';
// 	$sg = new \SendGrid($apiKey);
// 	$response = $sg->client->mail()->send()->post($mail);
// 	echo $
// 	echo $response->statusCode();
// 	echo $response->headers();
// 	echo $response->body();
});
$app->get('/majors', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;

    $sql = 'SELECT name
            FROM TEAM;';
    $q = $db->query($sql);

    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    foreach($check as $row){
      $arr[] = $row;
    }
    $returnArr = array();
    $assocArr = array();
    foreach($arr as $row){
      $arr[] = $row;
    }
    foreach($arr as $row){
      $returnArr['name'] = $row['name'];
      $returnArr['ME'] = 5;
      $returnArr['CSE'] = 6;

      $AssocArr[] = $returnArr;
    }
    return $response->write(json_encode($AssocArr));
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->get('/teams', function ($request, $response, $args) {
  // try{
  //   $db = $this->dbConn;
  //   $sql = 'SELECT *
  //           FROM TEAM';
  //   $q = $db->query($sql);
  //   $check = $q->fetchAll(PDO::FETCH_ASSOC);
  //   foreach($check as $row){
  //     $arr[] = $row;
  //   }
  //   $returnArr = array();
  //   foreach($arr as $row){
  //     $returnArr['']
  //   }
  //   return $response->write(json_encode($check));
  // }
  // catch(PDOException $e){
  //   $this->notFoundHandler;
  // }
});
