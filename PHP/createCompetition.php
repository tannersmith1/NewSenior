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

class CreateCompetitionAPI
{
	private $db;
	private $conn;

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

	//creates the Team of the id that is posted
	function CreateCompetition()
	{
        if (isset($_POST["startdate"]) && isset($_POST["enddate"]) && isset($_POST["teamname"]) && isset($_POST["frequency"]) && isset($_POST["cycles"]) && isset($_POST["iselimination"]))
        {
            
            //sanitize inputs
            $startdate = mysql_real_escape_string( $_POST["startdate"] );
            $enddate = mysql_real_escape_string( $_POST["enddate"] );
            $teamname = mysql_real_escape_string( $_POST["teamname"] );
            $frequency = mysql_real_escape_string( $_POST["frequency"] );
            $cycles = mysql_real_escape_string( $_POST["cycles"] );
            $iselimination = mysql_real_escape_string( $_POST["iselimination"] );
            
            
                        
                                                                                                                                      
                
                //Convert isPrivate to a bool
            if (strcmp(strtolower($iselimination), "elimination") == 0)
            {
                $iselimination = 1;
            }
            else
            {
                $iselimination = 0;
            }
            //check if team already has a competition
            $result = mysql_query("select competitionid from competition where partyid = (select partyid from party where partyname = '$teamname')");
			
            //Since no teams were returned, add valid entry into database
            if( mysql_num_rows( $result ) == 0)
            {
                    //insert competition into database

                $result = mysql_query("CALL create_competition('$teamname', '$startdate', '$enddate', '$frequency', '$cycles', '$iselimination');");
                echo "TRUE";
            }
            else
            {
                echo "FALSE";
            }
        }
        else
        {
            echo "need all values set";
        }
    }
}

$api = new CreateCompetitionAPI;
$api->CreateCompetition();
unset($api);
?>
