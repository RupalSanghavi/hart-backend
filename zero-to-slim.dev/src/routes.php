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
$app->post('/login',function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $username = $data['username'];
    $password = $data['password'];
    // session_destroy();
    // print_r($_SESSION);
    // print_r(count($_SESSION));
    $_SESSION["authenticated"] = true;
    $_SESSION['username'] = $username;
    // print_r($_SESSION);
    // print_r(count($_SESSION));
    //$auth['authenticated'] = true;
    return $response->write(json_encode($_SESSION));
});
$app->get('/checkauth',function($request,$response,$args){
   $auth = 0;
   if(count($_SESSION) == 0){}
   else if($_SESSION["authenticated"] == true){
      $auth = 1;
    }
   else {}
   return $response->write(json_encode($_SESSION));

});
$app->post('/logout',function($request,$response,$args){
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $username = $data['username'];
    $password = $data['password'];
    session_destroy();
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
      return $response->write(json_encode($success));
    }
    catch(PDOException $e){
      print "Error!: " . $e->getMessage() . "<br/>";
      $this->notFoundHandler;
    }
});
$app->post('/student/add',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $data = $request->getParsedBody();
    $firstName = $data["firstName"];
    $lastName = $data["lastName"];
    $email = $data["email"];
    $id = $data["id"];
    $section = $data["section"];
    // $sql = "INSERT INTO STUDENT
    //         (first_name,last_name,email,"

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
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
    $sprint = $q->fetchAll(PDO::FETCH_ASSOC);
    return $response->write(json_encode($sprint));

  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->get('/forms',function($request,$response,$args){

});
$app->get('/forms/team-charter/{team_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $team_id = $request->getAttribute('team_id');
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

  return $response->write(json_encode($obj));
});

$app->post('/forms/team-charter/{team_id}',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $TEAM_id = $request->getAttribute('team_id');
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
    return $response->write(json_encode($success));
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }
});
$app->get('/forms/t_mbd/{team_id}/{sprint_num}',function($request,$response,$args){
  try{
    $db = $this->dbConn;
    $team_id = $request->getAttribute('team_id');
    $sprint_num = $request->getAttribute('sprint_num');
    $sql = "SELECT *
            FROM MBDForm
            WHERE SPRINT_id = $sprint_num";
    $q = $db->query($sql);
    $mbd = $q->fetch(PDO::FETCH_ASSOC);
    $mbd_adj['more'] = $mbd['More'];
    $mbd_adj['better'] = $mbd['Better'];
    $mbd_adj['different'] = $mbd['Different'];
    return $response->write(json_encode($mbd_adj));
  }
  catch(PDOException $e){
    print "Error!: " . $e->getMessage() . "<br/>";
    $this->notFoundHandler;
  }

});
$app->post('/forms/t_mbd/{team_id}',function($request,$response,$args){

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
    return $response->write(json_encode($obj));
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
  $id = $_SESSION['username'];
  $sql = "SELECT first_name, last_name
          FROM STAFF
          WHERE id = $id";
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
  return $response->write(json_encode($return));

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
    return $response->write(json_encode($obj));

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
  return $response->write(json_encode($success));
});
$app->get('/calendar/{team_id}',function($request,$response,$args){
    $db = $this->dbConn;
    $id = $request->getAttribute('team_id');
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
    return $response->write(json_encode($obj));
  });
$app->post('/calendar/{team_id}',function($request,$response,$args){
  $db = $this->dbConn;
  $id = $request->getAttribute('team_id');
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
  return $response->write(json_encode($event_adj));
});
