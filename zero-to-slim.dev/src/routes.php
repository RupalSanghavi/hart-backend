<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST,PUT,GET,OPTIONS');
header('Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept');


$servername = "localhost";
$username = "root";

date_default_timezone_set('America/Chicago');


// from http://php.net/manual/en/function.hash-equals.php
function hash_equals($str1,$str2)
{
      if(strlen($str1) != strlen($str2)) {
        return false;
      } else {
        $res = $str1 ^ $str2;
        $ret = 0;
        for($i = strlen($res) - 1; $i >= 0; $i--) $ret |= ord($res[$i]);
        return !$ret;
      }
}

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
$app->post('/faculty/add', function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $admin = $data['admin'];
    $first_name = $data['firstName'];
    $last_name = $data['lastName'];
    $email = $data['email'];
    $sql = "INSERT INTO STAFF (admin, first_name, last_name, email)
            VALUES ('$admin', '$first_name', '$last_name', '$email')";
    $db->query($sql);
    $sql = $sql = "SELECT id
            FROM STAFF
            WHERE email = '$email'";
    $q = $db->query($sql);
    $obj = $q->fetch(PDO::FETCH_ASSOC);
    $id = $obj['id'];
    return $response->withJson($id);
});
$app->post('/focus', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $years = $data['year'];
    $in = implode(", ", $years);
    $semesters = $data['semester'];
    $in2 = "'".implode("', '", $semesters)."'";
    $sql = "SELECT COUNT(s.id) as value, hf.focus_name as name
            FROM STUDENT s
            INNER JOIN HLA_FOCUS hf
            INNER JOIN CLASS c
            WHERE s.CLASS_id = c.id
            AND hf.STUDENT_id = s.id
            AND year IN ($in)
            AND semester IN($in2)
            GROUP BY hf.focus_name";
    $q = $db->query($sql);
    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    return $response->withJson($check);

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->post('/teamroles', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $years = $data['year'];
    $in = implode(", ", $years);
    $semesters = $data['semester'];
    $in2 = "'".implode("', '", $semesters)."'";
    $sql = "SELECT COUNT(s.id) as value, tr.name
            FROM STUDENT s
            INNER JOIN STUDENT_ROLES sr
            INNER JOIN TEAM_ROLES tr
            INNER JOIN CLASS c
            WHERE s.CLASS_id = c.id
            AND sr.STUDENT_id = s.id
            AND tr.id = sr.TEAM_ROLES_id
            AND year IN ($in)
            AND semester IN($in2)
            GROUP BY tr.name";
    $q = $db->query($sql);
    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    return $response->withJson($check);

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->post('/majors', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $years = $data['year'];
    $in = implode(", ", $years);
    $semesters = $data['semester'];
    $in2 = "'".implode("', '", $semesters)."'";
    $sql = "SELECT COUNT(s.id) as value, s.major as name
            FROM STUDENT s
            INNER JOIN CLASS c
            WHERE s.CLASS_id = c.id
            AND year IN ($in)
            AND semester IN($in2)
            GROUP BY major";
    $q = $db->query($sql);
    $check = $q->fetchAll(PDO::FETCH_ASSOC);
    return $response->withJson($check);

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});

$app->get('/sections', function ($request, $response, $args) {
  try{
    $db = $this->dbConn;
    $year = date('Y');
    $month = date('m');
    if($month <= 5){
      $semester = "Spring";
    }
    else{
      $semester = "Fall";
  }
    $sql = "SELECT c.section
            FROM CLASS c
            WHERE c.year = '$year'
            AND c.semester = '$semester'";
    $q = $db->query($sql);
    $obj = $q->fetchAll(PDO::FETCH_ASSOC);
    $sections['sections'] = array();
    foreach($obj as $section){
      array_push($sections['sections'],$section['section']);
    }
    #$sections['sections'] = $obj;
    return $response->withJson($sections);
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
    return $response->withJson($obj);
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
    return $response->withJson($check);
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
    return $response->withJson($obj);
  }
  catch(PDOException $e){
    $this->notFoundHandler;
  }
});
$app->post('/student/add', function($request,$response,$args){
  $db = $this->dbConn;
  $data = $request->getParsedBody();
  $firstName = $data['firstName'];
  $lastName = $data['lastName'];
  $email = $data['email'];
  $section = $data['section'];
  $now = date('Y');
  $month = date('m');
  if($month <= 5){
    $semester = "Spring";
  }
  else{
    $semester = "Fall";
}
  $sql = "SELECT c.id
          FROM CLASS c
          WHERE c.year = '$now'
          AND c.semester = '$semester'";
  $q = $db->query($sql);
  $class_id_obj = $q->fetch(PDO::FETCH_ASSOC);
  $class_id = $class_id_obj['id'];
  $sql2 = "INSERT INTO STUDENT
         (first_name,last_name,email,CLASS_id)
         VALUES ('$firstName','$lastName','$email','$class_id')";
  $q = $db->query($sql2);

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
$app->put('/newstudent', function($request,$response,$args){
  $db = $this->dbConn;
  $data = $request->getParsedBody();
  $first_name = $data['first_name'];
  $last_name = $data['last_name'];
  $team_name = $data['team_name'];
  $image = $data['image'];
  $major = $data['major'];
  $info = $data['info'];
  $knowledge = $data['knowledge'];
  $skills_abilities = $data['skills_abilities'];
  $sql = "SELECT username
          FROM SESSIONS
          WHERE id = 1";
  $q = $db->query($sql);
  $array = $q->fetch(PDO::FETCH_ASSOC);
  $email = $array['username'];
  $sql = "UPDATE STUDENT
          SET first_name = '$first_name',
          last_name = '$last_name',
          image = '$image',
          info = '$info',
          major = '$major',
          knowledge = '$knowledge',
          skills_abilities = '$skills_abilities'
          WHERE email = '$email'";
  echo $sql;
  $db->query($sql);
});
$app->post('/registration',function($request,$response,$args)
{
  $db = $this->dbConn;
  $data = $request->getParsedBody();
  $password = $data['password'];
  $email = $data['email'];
  $cost = 10;
  $salt = strtr(base64_encode(mcrypt_create_iv(16,MCRYPT_DEV_URANDOM)),'+','.'); //generating a salt
  $salt = sprintf("$2a$%02d$", $cost) . $salt; //Prefix for PHP verification purposes. 2a refers to Blowfish algorithm used
  $hash = crypt($password,$salt);

  $arr = false;
  if($arr == false)//successful
  {
    $sql = "INSERT into STAFF (email,salt,hash) VALUES ('$email','$salt','$hash');";
    echo $sql;
    $db->query($sql);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


    $success = "true";
    $str = array("registered" => $success);
    //echo $success;
    return $response->withJson($str);
  }

});

$app->post('/login',function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $username = $data['username'];
    $password = $data['password'];

    $success = array();
    $sql = "SELECT s.id, s.hash, s.salt, s.TEAM_id
            FROM STUDENT s
            INNER JOIN TEAM t
            WHERE email = '$username'
            AND s.TEAM_id = t.id;";
    $q = $db->query($sql);
    $array = $q->fetch(PDO::FETCH_ASSOC);
    //check if student or admin
    if(count($array) <= 1){
      //not a student
      $sql = "SELECT hash, salt
              FROM STAFF
              WHERE email = '$username';";
      $q = $db->query($sql);
      $array = $q->fetch(PDO::FETCH_ASSOC);
      if(count($array) == 0){
        $success['admin'] = false;
        $msg = "No existing account. ";
        $success['authenticated'] = false;
        $success['msg'] = $msg;
        return $response->withJson($success);
      }
      else{
        $success['admin'] = true;
      }
    }
    else{
      $success['admin'] = false;
      $TEAM_id = $array['TEAM_id'];
    }
    //check if password is correct
    $hash = $array['hash'];
    $salt = $array['salt'];
    // $TEAM_id = $array['TEAM_id'];
    $token = strtr(base64_encode(mcrypt_create_iv(16,MCRYPT_DEV_URANDOM)),'+','.');
    if(hash_equals($hash,crypt($password,$salt))) // Valid
    {
      $success['authenticated'] = true;
      if($success['admin'] == false)
        {
          $sql = "INSERT INTO SESSIONS
          (id, authenticated, username, team_id)
          values (1, 1,'$username','$TEAM_id')";
          // $sql = "UPDATE SESSIONS
          //       SET authenticated = 1,
          //       username = '$username',
          //       team_id = '$TEAM_id'
          //       WHERE id = 1";
        }
      else{
        $sql = "INSERT INTO SESSIONS
        (id, authenticated, username)
        values (1, 1,'$username')";
        // $sql = "UPDATE SESSIONS
        //         SET authenticated = 1,
        //         username = '$username'
        //         WHERE id = 1";
      }
      $db->query($sql);
      #$_SESSION["authenticated"] = true;
      // $_SESSION['username'] = $username;

      return $response->withJson($success);
    }
    else //incorrect password
    {
      // $_SESSION["authenticated"] = false;
      $success['authenticated'] = false;

      return $response->withJson($success);
    }

});
$app->get('/checkauth',function($request,$response,$args){
   $auth = 0;
   $db = $this->dbConn;

   $sql = "SELECT COUNT(*) as count
           FROM SESSIONS";
   $q = $db->query($sql);
   $array = $q->fetch(PDO::FETCH_ASSOC);
   $count = $array['count'];
   if($count == 0){
     $success['authenticated'] = false;
   }
   else {
      $auth = 1;
      $success['authenticated'] = true;
    }

   return $response->withJson($success);

});
$app->post('/logout',function($request,$response,$args){
    $db = $this->dbConn;
    // $data = $request->getParsedBody();
    // $username = $data['username'];
    // $password = $data['password'];
    $sql = "DELETE
            FROM SESSIONS
            WHERE id = 1";

  $db->query($sql);
});
$app->post('/faculty/delete',function($request,$response,$args){
  try{
      $db = $this->dbConn;
      $data = $request->getParsedBody();
      $id = $data['id'];
      $del_events = "DELETE
                      FROM EVENTS
                      WHERE STAFF_id = '$id'";
      $sql = "DELETE
              FROM STAFF
              WHERE id = '$id'";
      $sql2 = "DELETE
              FROM ANNOUNCEMENTS
              WHERE ANNOUNCEMENTS.STAFF_id = '$id'";
      $q = $db->query($del_events);
      $q = $db->query($sql) ;
      $q = $db->query($sql2);
      $success['status'] = "success";
      return $response->withJson($success);
    }
    catch(PDOException $e){
      print "Error!: " . $e->getMessage() . "<br/>";
      $this->notFoundHandler;
    }
});
// $app->post('/student/add',function($request,$response,$args){
//   try{
//     $db = $this->dbConn;
//     $data = $request->getParsedBody();
//     $firstName = $data["firstName"];
//     $lastName = $data["lastName"];
//     $email = $data["email"];
//     $id = $data["id"];
//     $section = $data["section"];
//     $sql = "INSERT INTO STUDENT
//             (first_name,last_name,email,"
//
//   }
//   catch(PDOException $e){
//     print "Error!: " . $e->getMessage() . "<br/>";
//     $this->notFoundHandler;
//   }
// });

$app->get('/forms',function($request,$response,$args){
  $db = $this->dbConn;
  $sql = "SELECT username
          FROM SESSIONS
          WHERE id = 1";
  $q = $db->query($sql);
  $array = $q->fetch(PDO::FETCH_ASSOC);
  $email = $array['username'];
  $sql = "SELECT t.id
          FROM STUDENT s
          INNER JOIN TEAM t
          WHERE s.email = '$email'
          AND t.id = s.TEAM_id";
  $q = $db->query($sql);
  $team_id_obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $team_id_obj['id'];
  $sql = "SELECT COUNT(*)
          FROM TEAM t
          INNER JOIN TEAM_CHARTER tc
          WHERE t.id = '$team_id'
          AND tc.TEAM_id = '$team_id'";
  $q = $db->query($sql);
  $count_obj = $q->fetch(PDO::FETCH_ASSOC);
  $count = $count_obj['COUNT(*)'];
  $to_return = array();
  if($count > 0){
    $to_return['team_charter'] = true;
  }
  else{
    $to_return['team_charter'] = false;
  }
  $now = date('Y-m-d');
  $sql = "SELECT COUNT(*)
          FROM SPRINT s
          WHERE s.TEAM_id = '$team_id'
          AND '$now' between s.start_date and s.end_date";
  $q = $db->query($sql);
  $countMBD_obj = $q->fetch(PDO::FETCH_ASSOC);
  $countMBD = $countMBD_obj['COUNT(*)'];
  if($countMBD > 0){
    $to_return['mbd'] = true;
  }
  else{
    $to_return['mbd'] = false;
  }
  return $response->withJson($to_return);
});
$app->get('/forms/team-charter',function($request,$response,$args){
  $db = $this->dbConn;
  $sql = "SELECT team_id
          FROM SESSIONS
          WHERE id = 1;";
  $q = $db->query($sql);
  $obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $obj['team_id'];
  $sql = "SELECT t.name, tc.*
          FROM TEAM t
          INNER JOIN TEAM_CHARTER tc
          ON t.id = $team_id
          WHERE tc.TEAM_id = $team_id";
  $q = $db->query($sql);
  $team = $q->fetch(PDO::FETCH_ASSOC);
  $sql = "SELECT *
          FROM STUDENT s
	        WHERE s.TEAM_id = '$team_id'";
  $q = $db->query($sql);
  $students = $q->fetchAll(PDO::FETCH_ASSOC);
  $i = 0;
  $profiles = [];
  foreach($students as $student){
    $id = $student['id'];
    $sql = "SELECT *
            FROM TOOLS t
            WHERE t.STUDENT_id = '$id'";
    $q = $db->query($sql);
    $tools_rows = $q->fetchAll(PDO::FETCH_ASSOC);
    // echo json_encode($tools_rows);
    $comm_tools = array();
    foreach($tools_rows as $row){
      $comm_tool = $row['comm_tool'];
      array_push($comm_tools,$comm_tool);
    }
    $profile = array();
    $profile['name'] = $student['first_name']." ".$student['last_name'];
    $profile['knowledge'] = $student['knowledge'];
    $profile['skills_abilities'] = $student['skills_abilities'];
    $profile['major'] = $student['major'];
    $profile['about'] = $student['info'];
    $profile['comm_tools'] = $comm_tools;
    //comm_tools?
    array_push($profiles,$profile);
  }
  $obj['team_name'] = $team['name'];
  $obj['profiles'] = $profiles;
  $obj["ideate"] = $team['ideating'];

  $obj["decision_making"] = $team['decision_making'];
  $obj["disputes"] = $team['disputes'];
  $obj["conflicts"] = $team['conflicts'];
  $obj['fun'] = $team['fun'];
  $obj['purpose'] = $team['team_purpose'];
  $obj['stakeholders'] = $team['stakeholders'];
  $obj['mission'] = $team['mission'];

  return $response->withJson($obj);
});
//
$app->post('/forms/team-charter',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $sql = "SELECT team_id
            FROM SESSIONS
            WHERE id = 1;";
    $q = $db->query($sql);
    $obj = $q->fetch(PDO::FETCH_ASSOC);
    $TEAM_id = $obj['team_id'];
    $charter = $request->getParsedBody();
    $ideate = $charter['ideate'];
    $decision_making = $charter['decision_making'];
    $disputes = $charter['disputes'];
    $conflicts = $charter['conflicts'];
    $fun = $charter['fun'];
    $purpose = $charter['purpose'];
    $stakeholders = $charter['stakeholders'];
    $mission = $charter['mission'];
    $sql = "UPDATE TEAM_CHARTER
            SET ideating = '$ideate',
            decision_making = '$decision_making',
            disputes = '$disputes',
            fun = '$fun',
            team_purpose = '$purpose',
            stakeholders = '$stakeholders',
            mission = '$mission'
            WHERE TEAM_id = $TEAM_id";
    $q = $db->query($sql);
    $success['messages'] = 'success!!!';
    return $response->withJson($success);
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->get('/forms/t_mbd/{sprint_num}',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $sql = "SELECT team_id
            FROM SESSIONS
            WHERE id = 1;";
    $q = $db->query($sql);
    $obj = $q->fetch(PDO::FETCH_ASSOC);
    $team_id = $obj['team_id'];
    $sprint_num = $request->getAttribute('sprint_num');
    $sql = "SELECT *
            FROM MBDForm
            WHERE SPRINT_id = $sprint_num";
    $q = $db->query($sql);
    $mbd = $q->fetch(PDO::FETCH_ASSOC);
    $mbd_adj['more'] = $mbd['More'];
    $mbd_adj['better'] = $mbd['Better'];
    $mbd_adj['different'] = $mbd['Different'];
    return $response->withJson($mbd_adj);
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }

});
$app->get('/forms/i_mbd',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $sql = "SELECT s.id
            FROM SESSIONS ss
            INNER JOIN STUDENT s
            WHERE ss.username = s.email
            AND ss.id = 1";
    echo $sql;
    $q = $db->query($sql);
    $array = $q->fetch(PDO::FETCH_ASSOC);
    $id = $array['id'];

    $sql = "SELECT *
            FROM MBDForm
            WHERE STUDENT_id = '$id'";
    $q = $db->query($sql);
    $mbd = $q->fetch(PDO::FETCH_ASSOC);
    $mbd_adj['more'] = $mbd['More'];
    $mbd_adj['better'] = $mbd['Better'];
    $mbd_adj['different'] = $mbd['Different'];
    return $response->withJson($mbd_adj);
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->post('/forms/t_mbd',function($request,$response,$args){

  try{
      $db = $this->dbConn;
      $bod = $request->getParsedBody();
      $sprint_num = $bod['sprint_num'];
      $more = $bod['more'];
      $better = $bod['better'];
      $different = $bod['different'];
      $sql = "UPDATE MBDForm
              SET More = '$more',
              Better = '$better',
              Different = '$different'
              WHERE SPRINT_id = $sprint_num";
      $q = $db->query($sql);
    }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->get('/announcements/{quantity}',function($request,$response,$args){

  $quantity = $request->getAttribute('quantity');
  try{
    $db = $this->dbConn;
    $sql = "SELECT *
            FROM ANNOUNCEMENTS";
    $q = $db->query($sql);
    $announcements = $q->fetchAll(PDO::FETCH_ASSOC);
    $annArr = [];
    foreach($announcements as $announcement){

      $obj = array();
      $obj['id'] = $announcement['id'];
      $obj['title'] = $announcement['title'];
      $obj['text'] = $announcement['body'];
      $obj['sender'] =  $announcement['creator'];
      $obj['priority'] = $announcement['priority'];
      $obj['timestamp'] = $announcement['create_datetime'];
      array_push($annArr,$obj);
    }
    $obj = array();
    $obj['announcements'] = $annArr;
    return $response->withJson($obj);
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->post('/announcements/create',function($request,$response,$args){
  $db = $this->dbConn;
  $announcement = $request->getParsedBody();
  $title = $announcement['title'];
  $text = $announcement['text'];
  $priority = $announcement['priority'];
  $sql = "SELECT username
          FROM SESSIONS
          WHERE id = 1";
  $q = $db->query($sql);
  $array = $q->fetch(PDO::FETCH_ASSOC);
  $id = $array['username'];
  $sql = "SELECT first_name, last_name
          FROM STAFF
          WHERE email = '$id'";
  $q = $db->query($sql);
  $creator_sep = $q->fetch(PDO::FETCH_ASSOC);
  $now = date('Y-m-d H:i:s');
  $creator = $creator_sep['first_name']." ".$creator_sep['last_name'];

  // $sql2 = "INSERT INTO ANNOUNCEMENTS
  //         (id,creator,create_datetime,title,body,priority,STAFF_id)
  //         VALUES(NULL,$creator,$now,$title,
  //           $text,$priority,$id)";
  $sql2 = "INSERT INTO ANNOUNCEMENTS
          (id,creator,create_datetime,title,body,priority,STAFF_id)
          VALUES(NULL,'$creator','$now','$title',
            '$text',$priority,$id)";
  $q = $db->query($sql2);
  $sql = "SELECT *
          FROM ANNOUNCEMENTS
          ORDER BY id DESC
          LIMIT 1";
  $q = $db->query($sql);
  $announcement = $q->fetch(PDO::FETCH_ASSOC);
  $return = array();
  $return['id'] = $announcement['id'];
  $return['creator'] = $announcement['creator'];
  $return['timestamp'] = $announcement['create_datetime'];
  $return['title'] = $announcement['title'];
  $return['text'] = $announcement['body'];
  $return['priority'] = $announcement['priority'];
  return $response->withJson($return);

});
$app->get('/faculty',function($request,$response,$args){
    $db = $this->dbConn;
    $sql = "SELECT *
            FROM STAFF
            WHERE admin = 0";
    $q = $db->query($sql);
    $obj = array();
    $faculty = $q->fetchAll(PDO::FETCH_ASSOC);
    $faculty_adj = array();
    foreach($faculty as $person){
      $obj = array();
      $obj['firstName'] = $person['first_name'];
      $obj['lastName'] = $person['last_name'];
      $obj['id'] = $person['id'];
      array_push($faculty_adj,$obj);
    }
    $obj['faculty'] = $faculty_adj;
    $sql = "SELECT *
            FROM STAFF
            WHERE admin = 1";
    $q = $db->query($sql);
    $admin = $q->fetchAll(PDO::FETCH_ASSOC);
    $admin_adj = array();
    foreach($admin as $person){
      $obj2 = array();
      $obj2['firstName'] = $person['first_name'];
      $obj2['lastName'] = $person['last_name'];
      $obj2['id'] = $person['id'];
      array_push($admin_adj,$obj2);
    }
    $obj['admin'] = $admin_adj;
    // $obj = array();
    // $obj['faculty'],$faculty_arr);
    // array_push($obj,$admin_arr);
    // // $obj[0]= $faculty_arr;
    // // $obj[1]= $admin_arr;
    return $response->withJson($obj);

});
$app->post('/students/delete',function($request,$response,$args){
  $db = $this->dbConn;
  $arr = $request->getParsedBody();
  $id = $arr['id'];
  $sql3 = "DELETE FROM STUDENT_ROLES
           WHERE STUDENT_id = '$id'";
  $sql2 = "DELETE FROM HLA_FOCUS
           WHERE STUDENT_id = '$id'";
  $sql = "DELETE FROM STUDENT
          WHERE id = '$id'";
  $q = $db->query($sql3);
  $q = $db->query($sql2);
  $q = $db->query($sql);
  $success['status'] = "success";
  return $response->withJson($success);
});
$app->get('/calendar',function($request,$response,$args){
    $db = $this->dbConn;
    $sql = "SELECT team_id
            FROM SESSIONS
            WHERE id = 1;";
    $q = $db->query($sql);
    $obj = $q->fetch(PDO::FETCH_ASSOC);
    $id = $obj['team_id'];
    $sql = "SELECT *
            FROM EVENTS
            WHERE TEAM_id = '$id'";
    $q = $db->query($sql);
    $events = $q->fetchAll(PDO::FETCH_ASSOC);
    $events_adj = array();
    foreach($events as $event){
      $event_adj = array();
      $event_adj['title'] = $event['title'];
      $event_adj['startdate'] = $event['start_date'];
      $event_adj['id'] = $event['id'];
      array_push($events_adj, $event_adj);
    }

    $obj['Events'] = $events_adj;
    return $response->withJson($obj);
  });
$app->post('/calendar/{team_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $sql = "SELECT team_id
          FROM SESSIONS
          WHERE id = 1;";
  $q = $db->query($sql);
  $obj = $q->fetch(PDO::FETCH_ASSOC);
  $id = $obj['team_id'];
  $event = $request->getParsedBody();
  $title = $event['title'];
  $startdate = $event['startdate'];
  $enddate = $event['enddate'];
  $location = $event['location'];
  $description = $event['description'];
  $creator = $event['creator'];
  $created_date = $event['created_date'];
  $sql = "INSERT INTO EVENTS
          (title,start_date,end_date,location,description,creator,create_date
          ,TEAM_id)
          VALUES('$title','$startdate','$enddate','$location','$description'
          ,'$creator','$created_date','$id')";
  $q = $db->query($sql);
  $sql = "SELECT *
          FROM EVENTS
          ORDER BY id DESC
          LIMIT 1";
  $q = $db->query($sql);
  $event = $q->fetch(PDO::FETCH_ASSOC);
  $event_adj['id'] = $event['id'];
  $event_adj['title'] = $event['title'];
  $event_adj['startdate'] = $event['start_date'];
  $event_adj['enddate'] = $event['end_date'];
  $event_adj['location'] = $event['location'];
  $event_adj['description'] = $event['description'];
  $event_adj['creator'] = $event['creator'];
  $event_adj['created_date'] = $event['create_date'];
  return $response->withJson($event_adj);
});
$app->get('/calendar/{month}',function($request,$response,$args){
  $db = $this->dbConn;
  $month = $request->getAttribute('month');
  $sql = "SELECT team_id
          FROM SESSIONS
          WHERE id = 1;";
  $q = $db->query($sql);
  $obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $obj['team_id'];
  $sql = "SELECT *
          FROM EVENTS
          WHERE TEAM_id = '$team_id'
          AND MONTH(start_date) = '$month'";
  $q = $db->query($sql);
  $events = $q->fetchAll(PDO::FETCH_ASSOC);
  $events_adj = array();
  foreach($events as $event){
    $event_adj = array();
    $event_adj['event_id'] = $event['id'];
    $event_adj['event_title'] = $event['title'];
    $event_adj['event_start_date'] = $event['start_date'];
    $event_adj['event_end_date'] = $event['end_date'];
    $event_adj['event_location'] = $event['location'];
    $event_adj['event_description'] = $event['description'];
    $event_adj['event_create_date'] = $event['create_date'];
    $event_adj['event_creator'] = $event['creator'];
    array_push($events_adj,$event_adj);
  }
  return $response->withJson($events_adj);
});
$app->get('/calendar/{month}/{team_name}/{event_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $month = $request->getAttribute('month');
  $team_name = $request->getAttribute('team_name');
  $event_id = $request->getAttribute('event_id');
  $sql = "SELECT *
          FROM EVENTS
          WHERE id = '$event_id'";
  $q = $db->query($sql);
  $event = $q->fetch(PDO::FETCH_ASSOC);
  $event_adj['event_id'] = $event['id'];
  $event_adj['event_location'] = $event['location'];
  $event_adj['event_description'] = $event['description'];
  $event_adj['event_createdate'] = $event['create_date'];
  $event_adj['event_creator'] = $event['creator'];
  return $response->withJson($event_adj);
});
$app->get('/resources',function($request,$response,$args){
  $db = $this->dbConn;
  $sql = "SELECT DISTINCT(category)
          FROM RESOURCES";
  $q = $db->query($sql);
  $categories = $q->fetchAll(PDO::FETCH_ASSOC);
  $obj_toreturn = array();
  foreach($categories as $category_obj){
    $category = $category_obj['category'];
    $sql = "SELECT *
            FROM RESOURCES
            WHERE category = '$category'";
    $q = $db->query($sql);
    $resources = $q->fetchAll(PDO::FETCH_ASSOC);
    $obj_toreturn[$category] = $resources;
  }
  return $response->withJson($obj_toreturn);
});
$app->post('/resources',function($request,$response,$args){
  $db = $this->dbConn;
  $resource = $request->getParsedBody();
  $name = $resource['name'];
  $link = $resource['link'];
  $category = $resource['category'];
  $sql = "INSERT INTO RESOURCES
          (name,link,category)
          VALUES ('$name','$link','$category')";
  $q = $db->query($sql);
  $sql = "SELECT *
          FROM RESOURCES
          ORDER BY id DESC
          LIMIT 1";
  $q = $db->query($sql);
  $resource_last_created = $q->fetch(PDO::FETCH_ASSOC);
  return $response->withJson($resource_last_created);
});
$app->put('/resources',function($request,$response,$args){
  $db = $this->dbConn;
  // $arr = (array) $request->getAttribute("token");
  $resource = $request->getParsedBody();

  $id = $resource['id'];
  $name = $resource['name'];
  $link = $resource['link'];
  $category = $resource['category'];
  $sql = "UPDATE RESOURCES
          SET name = '$name',
          link = '$link',
          category = '$category'
          WHERE id = '$id'";
  $q = $db->query($sql);
  $status['status'] = "success";
  return $response->withJson($status);
});
$app->post('/resources/delete',function($request,$response,$args){
  $db = $this->dbConn;
  $resource = $request->getParsedBody();
  $link = $resource['link'];
  $sql = "DELETE FROM RESOURCES
          WHERE link = '$link'";
  $q = $db->query($sql);
  $status['status'] = "success";
  return $response->withJson($status);
});
$app->get('/student/{student_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $id = $request->getAttribute('student_id');
  $sql = "SELECT s.*, c.section, t.name
          FROM STUDENT s
          INNER JOIN CLASS c
          INNER JOIN TEAM t
          WHERE s.id = '$id'
          AND s.CLASS_id = c.id
          AND s.TEAM_id = t.id";
  $q = $db->query($sql);
  $student = $q->fetch(PDO::FETCH_ASSOC);
  $student_adj = array();
  $student_adj['first_name'] = $student['first_name'];
  $student_adj['section'] = $student['section'];
  $student_adj['last_name'] = $student['last_name'];
  $student_adj['team_name'] = $student['name'];
  $student_adj['image'] = $student['image'];
  $student_adj['major'] = $student['major'];
  $student_adj['info'] = $student['info'];
  $student_adj['knowledge'] = $student['knowledge'];
  $student_adj['skills_abilities'] = $student['skills_abilities'];
  $sql = "SELECT tr.name
          FROM STUDENT s
          INNER JOIN STUDENT_ROLES sr
          INNER JOIN TEAM_ROLES tr
          WHERE s.id = '$id'
          AND sr.STUDENT_id = s.id
          AND tr.id = sr.TEAM_ROLES_id";
  $q = $db->query($sql);
  $roles_obj = $q->fetchAll(PDO::FETCH_ASSOC);
  $roles_adj = array();
  foreach($roles_obj as $role_obj){
    $role = $role_obj['name'];
    array_push($roles_adj, $role);
  }
  $student_adj['team_roles'] = $roles_adj;
  $sql = "SELECT focus_name
          FROM STUDENT s
          INNER JOIN HLA_FOCUS hf
          WHERE s.id = '$id'
          AND hf.STUDENT_id = '$id'";
  $q = $db->query($sql);
  $focuses_obj = $q->fetchAll(PDO::FETCH_ASSOC);
  $focuses_adj = array();
  foreach($focuses_obj as $focus_obj){
    $focus = $focus_obj['focus_name'];
    array_push($focuses_adj, $focus);
  }
  $student_adj['hla_focus'] = $focuses_adj;
  return $response->withJson($student_adj);
});
$app->put('/profilepic',function($request,$response,$args){
  $db = $this->dbConn;
  // $arr = (array) $request->getAttribute("token");
  $image_obj = $request->getParsedBody();
  $image = $image_obj['image'];
  $sql = "SELECT username
          FROM SESSIONS
          WHERE id = 1";
  $q = $db->query($sql);
  $array = $q->fetch(PDO::FETCH_ASSOC);
  $email = $array['username'];
  $sql = "UPDATE STUDENT
          SET image = '$image'
          WHERE email = '$email'";
  echo $sql;
  $q = $db->query($sql);

  return $response->withJson($image_obj);

});
$app->get('/teamsprints',function($request,$response,$args){
  $db = $this->dbConn;

  $sql = "SELECT team_id
          FROM SESSIONS
          WHERE id = 1;";
  $q = $db->query($sql);
  $obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $obj['team_id'];
  $sql = "SELECT *
          FROM SPRINT
          WHERE TEAM_id = '$team_id'
          ORDER BY start_date DESC";
  $q = $db->query($sql);
  $sprints = $q->fetchAll(PDO::FETCH_ASSOC);
  //$TEAM_id = $sprints['TEAM_id'];
  $sprints_adj = array();
  $sql = "SELECT name
          FROM TEAM
          WHERE id = '$team_id'";
  $q = $db->query($sql);
  $team_name = $q->fetch(PDO::FETCH_ASSOC);
  foreach($sprints as $sprint){
    $sprint_adj = array();
    $sprint_adj['id'] = $sprint['id'];
    $sprint_adj['info'] = $sprint['info'];
    $sprint_adj['date'] = $sprint['start_date'];
    $sprint_adj['team_name'] = "bob";
    $sprint_adj['scrum_master'] = $sprint['scrum_master'];
    $sprint_adj['scribe'] = $sprint['scribe'];
    $sprint_adj['team_name'] = $team_name['name'];
    array_push($sprints_adj,$sprint_adj);
  }
  $obj['sprints'] = $sprints_adj;
  return $response->withJson($obj);
});
$app->get('/sprints/{quantity}',function($request,$response,$args){
  $db = $this->dbConn;
  $quantity = $request->getAttribute('quantity');
  $sql = "SELECT username
          FROM SESSIONS
          WHERE id = 1";
  $q = $db->query($sql);
  $array = $q->fetch(PDO::FETCH_ASSOC);
  $email = $array['username'];
  $sql = "SELECT t.id
          FROM STUDENT s
          INNER JOIN TEAM t
          WHERE s.email = '$email'
          AND t.id = s.TEAM_id";
  $q = $db->query($sql);
  $team_id_obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $team_id_obj['id'];
  // $team_name = $team_id_obj['name'];
  $sql = "SELECT *
          FROM SPRINT
          WHERE TEAM_id = '$team_id'
          ORDER BY start_date DESC
          LIMIT $quantity";
  $q = $db->query($sql);
  $sprints = $q->fetchAll(PDO::FETCH_ASSOC);
  // $start_date = $sprints[0]['start_date'];
  // $end_date = $sprints[0]['end_date'];
  $now = date('Y-m-d');
  //$TEAM_id = $sprints['TEAM_id'];
  $sprints_adj = array();
  $sql = "SELECT name
          FROM TEAM
          WHERE id = '$team_id'";
  $q = $db->query($sql);
  $team_name = $q->fetch(PDO::FETCH_ASSOC);
  foreach($sprints as $sprint){
    $sprint_adj = array();
    $sprint_adj['id'] = $sprint['id'];
    $sprint_adj['info'] = $sprint['info'];
    $sprint_adj['start_date'] = $sprint['start_date'];
    $sprint_adj['end_date'] = $sprint['end_date'];
    $sprint_adj['scrum_master'] = $sprint['scrum_master'];
    $sprint_adj['scribe'] = $sprint['scribe'];
    $sprint_adj['team_name'] = $team_name['name'];
    $start_date = $sprint_adj['start_date'];
    $end_date = $sprint_adj['end_date'];
    if(strtotime($now) > strtotime($start_date)){
      $sprint_adj['sprint_started'] = true;
    }
    else{
      $sprint_adj['sprint_started'] = false;
    }
    $duration = abs(strtotime($end_date) - strtotime($start_date));
    $progress = abs(strtotime($now) - strtotime($start_date));
    $percentage = ($progress/$duration)*100;
    $sprint_adj['progress_bar'] = $percentage;

    array_push($sprints_adj,$sprint_adj);
  }
  $obj['sprints'] = $sprints_adj;
  return $response->withJson($obj);

});
$app->get('/sprint/{sprint_id}',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $sprint_id = $request->getAttribute('sprint_id');
    $data = $request->getParsedBody();
    $sql = "SELECT *
            FROM SPRINT
            WHERE id = '$sprint_id'";
    $q = $db->query($sql);
    $sprints = $q->fetchAll(PDO::FETCH_ASSOC);

    $now = date('Y-m-d');
    //$TEAM_id = $sprints['TEAM_id'];
    $sprints_adj = array();
    // $sql = "SELECT name
    //         FROM TEAM
    //         WHERE id = '$team_id'";
    // $q = $db->query($sql);
    // $team_name = $q->fetch(PDO::FETCH_ASSOC);
    foreach($sprints as $sprint){
      $sprint_adj = array();
      $sprint_adj['id'] = $sprint['id'];
      $sprint_adj['info'] = $sprint['info'];
      $sprint_adj['start_date'] = $sprint['start_date'];
      $sprint_adj['end_date'] = $sprint['end_date'];
      $sprint_adj['scrum_master'] = $sprint['scrum_master'];
      $sprint_adj['scribe'] = $sprint['scribe'];
      $start_date = $sprint_adj['start_date'];
      $end_date = $sprint_adj['end_date'];
      if(strtotime($now) > strtotime($start_date)){
        $sprint_adj['sprint_started'] = true;
      }
      else{
        $sprint_adj['sprint_started'] = false;
      }
      $duration = abs(strtotime($end_date) - strtotime($start_date));
      $progress = abs(strtotime($now) - strtotime($start_date));
      $percentage = ($progress/$duration)*100;
      $sprint_adj['progress_bar'] = $percentage;

      array_push($sprints_adj,$sprint_adj);
    }
    $obj['sprints'] = $sprints_adj;

    return $response->withJson($sprints_adj[0]);

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->put('/sprint',function($request,$response,$args){
  $db = $this->dbConn;
  $arr = $request->getParsedBody();
  $info = $arr['info'];
  $id = $arr['id'];
  $end_date = $arr['date'];
  $sql = "UPDATE SPRINT
          SET info = '$info',
          end_date = '$end_date'
          WHERE id = '$id'";
  $q = $db->query($sql);
});
$app->post('/sprint',function($request,$response,$args){
  $db = $this->dbConn;
  $sprint = $request->getParsedBody();
  $info = $sprint['info'];
  $sprint_master = $sprint['sprint_master'];
  $scribe = $sprint['scribe'];
  $start_date = $sprint['start_date'];
  $end_date = $sprint['end_date'];
  $team_name = $sprint['team_name'];
  $sql = "SELECT id
          FROM TEAM
          WHERE name = '$team_name'";
  $q = $db->query($sql);
  $team_id_obj = $q->fetch(PDO::FETCH_ASSOC);
  $team_id = $team_id_obj['id'];
  $sql = "INSERT INTO SPRINT
          (info, scrum_master, scribe, start_date, end_date,TEAM_id)
          VALUES ('$info','$sprint_master','$scribe','$start_date',
          '$end_date','$team_id')";
  $q = $db->query($sql);
  $status['status'] = 'success';
  return $response->withJson($status);

});
$app->get('/stats/{team_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $team_id = $request->getAttribute('team_id');
  $sql = "SELECT COUNT(id) as value, major as name
          FROM STUDENT
          WHERE TEAM_id = $team_id
          GROUP BY major";
  $q = $db->query($sql);
  $check = $q->fetchAll(PDO::FETCH_ASSOC);
  $obj_return['majors'] = $check;
  $sql = "SELECT COUNT(s.id) as value, hf.focus_name as name
          FROM STUDENT s
          INNER JOIN HLA_FOCUS hf
          WHERE s.TEAM_id = $team_id
          AND hf.STUDENT_id = s.id
          GROUP BY hf.focus_name";
  $q = $db->query($sql);
  $check = $q->fetchAll(PDO::FETCH_ASSOC);
  $obj_return['focuses'] = $check;
  return $response->withJson($obj_return);
});
