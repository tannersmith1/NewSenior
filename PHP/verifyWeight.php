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

class VerifyWeightAPI
{
	private $conn;
    private $db;
    private $_resultSet;
    
	// Constructor - open DB connection
	function __construct() 
	{		
		
	}

	// Destructor - close DB connection
	function __destruct() 
	{
		
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
                $this->clearResults();
            }
        }
    }
    
	//submits the scoresheet if the user doesn't already have one submitted for the cycle
	function VerifyWeight()
	{
        if (isset($_POST["scoresheetid"]) && isset($_POST["weight"]) )
        {
            $db = new mysqli('localhost', 'root', 'root', 'senior');
            if($db->connect_errno > 0)
            {
                die('Unable to connect to database [' . $db->connect_error . ']');
            }
            
            //sanitize inputs
            $scoresheetID = mysql_real_escape_string( $_POST["scoresheetid"] );
            $weight = mysql_real_escape_string( $_POST["weight"] );

            //TODO: Check if the user already has a scoresheet submitted for the cycle
            //$result = mysql_query("CALL check_for_existing_scoresheets('$teamname', '$username', '$cycleStart', '$cycleEnd');");
			if(!$result = $db->query("UPDATE scoresheet SET isverified = 1, score = '$weight' where scoresheetid = '$scoresheetID';"))
            {
                die('There was an error running the query [' . $db->error . ']');
            }
            if($db->affected_rows == 1)
            {
                echo "TRUE";
            }
            else
            {
                echo "FALSE";
            }
            
        }
        else
        {
            echo "need scoresheetid, weight";
        }
    }
    
    

}

$api = new VerifyWeightAPI;
$api->VerifyWeight();
unset($api);
?>
