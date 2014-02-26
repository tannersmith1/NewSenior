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

class SubmitWeightAPI
{
	private $conn;
    private $db;
    private $_resultSet;
    
	// Constructor - open DB connection
	function __construct() 
	{		
		$conn = mysql_connect('localhost', 'root', 'root');
		if(!mysql_select_db("senior"))
		{
			echo "error1122";
			exit;
		}
	}

	// Destructor - close DB connection
	function __destruct() 
	{
		$this->db->close();
	}
    
    protected function free(){
        $this->_resultSet->free();
        $this->_resultSet=null;
    }
    
    protected function checkMoreResults(){
        if($this->db->more_results())
        {
            return true;
        } else {
            return false;
        }
    }
    
    protected function clearResults()
    {
        if($this->checkMoreResults())
        {
            if($this->db->next_result())
            {
                if($this->_resultSet=$this->db->store_result())
                {
                    $this->free();
                }
                $this->clearResults(); // <----------- recursive call is your friend
            }
        }
    }
    
	//submits the scoresheet if the user doesn't already have one submitted for the cycle
	function SubmitWeight()
	{
        if (isset($_POST["username"]) && isset($_POST["teamname"]) && isset($_POST["datesubmitted"]) && isset($_POST["cyclestart"]) && isset($_POST["cycleend"]))
        {
            $db = new mysqli('localhost', 'root', 'root', 'senior');
            if($db->connect_errno > 0)
            {
                die('Unable to connect to database [' . $db->connect_error . ']');
            }
            
            //sanitize inputs
            $username = mysql_real_escape_string( $_POST["username"] );
            $teamname = mysql_real_escape_string( $_POST["teamname"] );
            $photoData = $_FILES['file'];
            $datesubmitted = $_POST["datesubmitted"];
            $cycleStart = $_POST["cyclestart"];
            $cycleEnd = $_POST["cycleend"];

            //TODO: Check if the user already has a scoresheet submitted for the cycle
            //$result = mysql_query("CALL check_for_existing_scoresheets('$teamname', '$username', '$cycleStart', '$cycleEnd');");
			if(!$result = $db->query("CALL check_for_existing_scoresheets('$teamname', '$username', '$cycleStart', '$cycleEnd');", MYSQLI_STORE_RESULT))
            {
                die('There was an error running the query [' . $db->error . ']');
            }
            //Since no scoresheets were returned, add valid entry into database
            if( $result->num_rows == 0)
            {
                
                while($db->more_results())
                {
                    $db->next_result();
                    if($result = $db->store_result())
                    {
                       $result->free();
                    }
                }
                //check if there was no error during the file upload
                if ($photoData['error']==0)
                {
                    //inserted in the database, go on with file storage
                    //database link
                    
                    //$result = mysqli_query("CALL submit_weight('$teamname', '$username', '$datesubmitted');");
                    
                    if (!$result = $db->query("insert into scoresheet(competitionid, playerid, datesubmitted, isverified, scoretype) select competition.competitionid, player.playerid, '$datesubmitted', 0, 'Weight' from player inner join player_party on player.playerID = player_party.playerID inner join party on party.partyid = player_party.partyID inner join competition on competition.partyid = party.partyid where  party.partyName = '$teamname' AND player.username = '$username' ;"))
                    {
                        die('failed at submit weight: [' . $db->error . '] [' . $teamname . '][' . $username . '][' . $datesubmitted . ']');
                    }
                    
                        
                    //get the last automatically generated ID
                    $IdPhoto = $db->insert_id;
                        
                    //move the temporarily stored file to a convenient location
                    if (move_uploaded_file($photoData['tmp_name'], "upload/".$IdPhoto.".jpg"))
                    {
                        //file moved, all good, generate thumbnail
                        //thumb("upload/".$IdPhoto.".jpg", 180);
                        //echo json_encode(array('successful'=>1));
                        echo "TRUE";
                    }
                    else
                    {
                        //errorJson('Upload on server problem');
                        echo "Upload on server proble";
                    };
                        
                    
                    
                } 
                else 
                {
                    echo "upload malfuntion";
                }
            
            }
            else
            {
                echo "A scoresheet for this cycle already exists";
            }
            
        }
        else
        {
            echo "need username, password1";
        }
    }
    
    

}

$api = new SubmitWeightAPI;
$api->SubmitWeight();
unset($api);
?>
