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

$app->get('/sections', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;
    $sql = 'SELECT section
            FROM CLASS;';
    $q = $db->query($sql);
    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    return $response->write(json_encode($check));
  }
  catch(PDOException $e){
    $this->notFoundHandler;
  }
});
$app->get('/sections/{section}', function ($request, $response, $args) {
  try{
    $section = $request->getAttribute('section');
    $db = $this->dbConn;
    $sql = "SELECT s.*
            FROM STUDENT s
            INNER JOIN CLASS c
            ON s.CLASS_id = c.id
            AND c.section = '$section';";
    $q = $db->query($sql);
    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    $obj['students'] = $check;
    return $response->write(json_encode($obj));
  }
  catch(PDOException $e){
    $this->notFoundHandler;
  }
});
$app->post('/team', function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $teamName = $data['name'];
    $members = $data['members'];
    //$team_id = uniqid();
    $sql = "INSERT INTO TEAM
            (id, name,logo,blog,charterCompleted,TEAM_CHARTER_id)
            VALUES (NULL,'$teamName',NULL,NULL,0,NULL)";
    $db->query($sql);
    $sql = "SELECT id
            FROM TEAM
            WHERE name = '$teamName'";
    $q = $db->query($sql);
    $obj = $q->fetch(PDO::FETCH_ASSOC);
    $team_id = $obj['id'];
    foreach($members as $member){
      $sql = "UPDATE STUDENT
              SET TEAM_id ='$team_id'
              WHERE id = '$member'";
      $db->query($sql);
    }
    echo "SUCCESS";

});
$app->get('/team/{team_id}', function($request,$response,$args){
  $team_id = $request->getAttribute('team_id');
  $db = $this->dbConn;
  try{
    $db = $this->dbConn;
    $sql = "SELECT *
            FROM TEAM
            WHERE id = '$team_id'";
    $q = $db->query($sql);
    $check = $q->fetch(PDO::FETCH_ASSOC);
    $CLASS_id = $check['CLASS_id'];
    $sql = "SELECT id, first_name, last_name
            FROM STUDENT
            WHERE TEAM_id = '$team_id'";
    $q = $db->query($sql);
    $members = $q->fetchAll(PDO::FETCH_ASSOC);
    $sql = "SELECT section
            FROM CLASS
            WHERE id = '$CLASS_id'";
    $q = $db->query($sql);
    $section = $q->fetch(PDO::FETCH_ASSOC);
    $check['members'] = $members;
    $check['section'] = $section['section'];
    return $response->write(json_encode($check));
  }
  catch(PDOException $e){
    $this->notFoundHandler;
  }

});
$app->get('/teams',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $sql = "SELECT *
            FROM TEAM";
    $q = $db->query($sql);
    $teams = $q->fetchAll(PDO::FETCH_ASSOC);
    $obj['teams'] = $teams;
    $i = 0;
    foreach($teams as $team){
      $team_id = $team['id'];
      $sql = "SELECT id, first_name, last_name,image
              FROM STUDENT
              WHERE TEAM_id = '$team_id'";
      $q = $db->query($sql);
      $members = $q->fetchAll(PDO::FETCH_ASSOC);
      $obj['teams'][$i]['members'] = $members;
      $i += 1;
    }
    return $response->write(json_encode($obj));
  }
  catch(PDOException $e){
    $this->notFoundHandler;
  }
});
$app->post('/newstudent', function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $student_id = $data['student_id'];
    echo $student_id;
    $team_id = $data['team_id'];
    echo $team_id;
    $sql = "UPDATE STUDENT
            SET TEAM_id = '$team_id'
            WHERE id = '$student_id'";
    $db->query($sql);
});
