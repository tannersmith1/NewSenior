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

class GetPartyAPI
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
	function GetParty()
	{
        
        if (isset($_POST["teamname"]) )
        {
            
            $db = mysqli_connect('localhost', 'root', 'root', 'senior');
            
            if(mysqli_connect_errno()){
                die('Unable to connect to database [' . $db->connect_error . ']');
            }
            
            
            $db2 = mysqli_connect('localhost', 'root', 'root', 'senior');
            
            if(mysqli_connect_errno()){
                die('Unable to connect to database [' . $db2->connect_error . ']');
            }
            
			//mysql_real_escape_string() used to sainitize input strings
			$teamname = mysql_real_escape_string($_POST["teamname"]);
			
			
			//checks to see if player exists
			
			if( !$result = mysqli_query($db,"select partyid from party where partyname='$teamname'"))
			{
				echo "FALSE";
			}
			else
			{				

                //Party Members
                $result = mysqli_query($db,"call party_members('$teamname');");
                $partyMembers = array();
                $count = 0;
                if (mysqli_num_rows($result) == 0)
                {
                    echo "Party Members: No rows found";
                    exit;
                }
                
                while ($row = mysqli_fetch_assoc($result))
                {
                    $partyMembers[$count] = $row["username"];
                    $partyLeader = $row["leader"];
                    $count = $count + 1;
                }

                
                if(1)
                {
                    $result2 = mysqli_query($db2,"call get_competition('$teamname');");
                    
                    
                    while ($row = mysqli_fetch_assoc($result2))
                    {
                        $startdate = $row["startdate"];
                        $enddate = $row["enddate"];
                        $frequency = $row["frequency"];
                        $cycles = $row["cycles"];
                        $iselimination = $row["iselimination"];
                    }
                    
                    //Get competition data and add it to partyData
                    
                    
                    
                    
                    $competition = array('startdate' => $startdate, 'enddate' => $enddate, 'frequency' => $frequency, 'cycles' => $cycles, 'iselimination' => $iselimination);
                    
                    $partyData = array('competition' => $competition, 'name' => $teamname, 'leader' => $partyLeader, 'members' => $partyMembers);
                    
                    echo json_encode($partyData);
                    
                }
                
                
            }
             
			 
            
		}
		else
		{
			echo "Needs teamname";
		}
        
        
	}
}

$api = new GetPartyAPI;
$api->GetParty();
unset($api);
?>
