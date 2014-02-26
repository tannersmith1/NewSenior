<?php
// Helper method to get a string description for an HTTP status code
// From http://www.gen-x-design.com/archives/create-a-rest-api-with-php/ 
function getStatusCodeMessage($status)
{
    // these could be stored in a .ini file and loaded
    // via parse_ini_file()... however, this will suffice
    // for an example
    $codes = Array(
        100 => 'Continue',
        101 => 'Switching Protocols',
        200 => 'OK',
        201 => 'Created',
        202 => 'Accepted',
        203 => 'Non-Authoritative Information',
        204 => 'No Content',
        205 => 'Reset Content',
        206 => 'Partial Content',
        300 => 'Multiple Choices',
        301 => 'Moved Permanently',
        302 => 'Found',
        303 => 'See Other',
        304 => 'Not Modified',
        305 => 'Use Proxy',
        306 => '(Unused)',
        307 => 'Temporary Redirect',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        402 => 'Payment Required',
        403 => 'Forbidden',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        406 => 'Not Acceptable',
        407 => 'Proxy Authentication Required',
        408 => 'Request Timeout',
        409 => 'Conflict',
        410 => 'Gone',
        411 => 'Length Required',
        412 => 'Precondition Failed',
        413 => 'Request Entity Too Large',
        414 => 'Request-URI Too Long',
        415 => 'Unsupported Media Type',
        416 => 'Requested Range Not Satisfiable',
        417 => 'Expectation Failed',
        500 => 'Internal Server Error',
        501 => 'Not Implemented',
        502 => 'Bad Gateway',
        503 => 'Service Unavailable',
        504 => 'Gateway Timeout',
        505 => 'HTTP Version Not Supported'
    );
 
    return (isset($codes[$status])) ? $codes[$status] : '';
}
 
// Helper method to send a HTTP response code/message
function sendResponse($status = 200, $body = '', $content_type = 'text/html')
{
    $status_header = 'HTTP/1.1 ' . $status . ' ' . getStatusCodeMessage($status);
    header($status_header);
    header('Content-type: ' . $content_type);
    echo $body;
}

class GetScoreSheetsAPI
{
	private $db;
	private $conn;

	// Constructor - open DB connection
	function __construct() 
	{
		
	}

	// Destructor - close DB connection
	function __destruct() 
	{
		$this->db->close();
	}

	//Return all the members given a party name
	function GetScoreSheets()
	{
        
        if (isset($_POST["teamname"]) )
        {
            
            $db = mysqli_connect('localhost', 'root', 'root', 'senior');
            
            if(mysqli_connect_errno())
            {
                //die('Unable to connect to database [' . $db->connect_error . ']');
                echo "FALSE";
                exit();
            }

			$teamname = mysql_real_escape_string($_POST["teamname"]);
						
			if( $result = mysqli_query($db,"select DISTINCT player.username, (select scoresheet.score from scoresheet where scoresheet.playerid = player.playerid order by scoresheet.datesubmitted limit 1) as startweight, (select scoresheet.score from scoresheet where scoresheet.playerid = player.playerid order by scoresheet.datesubmitted desc limit 1) as endweight from player inner join player_party on player.playerID = player_party.playerID inner join party on party.partyid = player_party.partyID inner join competition on competition.partyid = party.partyid join scoresheet on (scoresheet.competitionid = competition.competitionid AND scoresheet.playerid = player.playerid) where party.partyname = '$teamname' order by scoresheet.datesubmitted;"))
            {
                
                //ScoreSheets
                $scores = array();
                $username = null;
                $startweight = null;
                $endweight = null;
                $count = 0;
                if (mysqli_num_rows($result) == 0)
                {
                    echo "ScoreSheets: No rows found";
                    exit;
                }
                
                while ($row = mysqli_fetch_assoc($result))
                {
                    $username = $row["username"];
                    $startweight = $row["startweight"];
                    $endweight = $row["endweight"];
                    $scores[$count] = array('username' =>$username, 'startweight' => $startweight, 'endweight' => $endweight);
                    $count = $count + 1;
                }
                    
                echo json_encode($scores);
    
            }
            else
            {
                echo "FALSE";
            }
      
		}
		else
		{
			echo "Needs teamname";
		}
  
	}
}

$api = new GetScoreSheetsAPI;
$api->GetScoreSheets();
unset($api);
?>
