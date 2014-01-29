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
        echo "constructoer";
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

	//Return all the members given a party name
	function GetParty()
	{
        
        if (isset($_POST["teamname"]) )
        {
            
            
			//mysql_real_escape_string() used to sainitize input strings
			$teamname = mysql_real_escape_string($_POST["teamname"]);
			
			
			//checks to see if player exists
			$result = mysql_query("select partyid from party where partyname='$teamname'");
			if( mysql_num_rows( $result ) == 0)
			{
				echo "FALSE";
			}
			else
			{				
				
                
                
                //Party Members
                $result = mysql_query("call party_members('$teamname')");
                $partyMembers = array();
                $count = 0;
                
                while ($row = mysql_fetch_assoc($result))
                {
                    $partyMembers[$count] = $row["username"];
                    $count = $count + 1;
                }
                
                $result = mysql_query("select leader from party where partyname='$teamname'");
                
                while($row = mysql_fetch_assoc($result))
                {
                    $partyLeader = $row["leader"];
                }
                $partyData = array('name' => $teamname, 'leader' => $partyLeader, 'members' => $partyMembers);
                
                echo json_encode($partyLeader);
             
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
