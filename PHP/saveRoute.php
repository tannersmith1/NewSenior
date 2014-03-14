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

class SaveRouteAPI
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
    
	//Saves a route submitted by the user
	function SaveRoute() //////////////////////STUPIDLY INCOMPLETE
	{
        if (1)
        {
            $db = new mysqli('localhost', 'root', 'root', 'senior');
            if($db->connect_errno > 0)
            {
                die('Unable to connect to database [' . $db->connect_error . ']');
            }
            
            //sanitize inputs
            $route = $_POST["route"];
			$username = $_POST["username"];
            $data = json_decode($route, true);
			$datesubmitted = $data["datesubmitted"];
			$meterstravelled = $data["meterstravelled"];
			

            //Save the Route
			if(!$result = $db->query("insert into route (playerid,datesubmitted,meterstravelled) select playerid, '$datesubmitted','$meterstravelled' from player where player.username = '$username';"))
            {
                die('Save Route Error" [' . $db->error . ']');
            }
            if($db->affected_rows == 1)
            {
				$routeid = $db->insert_id;
                //If the route was saved, save all the coordinates
				for( $i = 0; $i < count($data["latitudes"]); $i++)
				{
					$lat = $data["latitudes"][$i];
					$long = $data["longitudes"][$i];
					if(!$result = $db->query("insert into coordinates (routeid, latitude, longitude) values ('$routeid', '$lat', '$long')"))
					{
						die('Save coordinate Error" [' . $db->error . ']');
					}
				}
				echo "TRUE";
            }
            else
            {
                echo "FALSE";
            }
            
        }
        //else
        //{
          //  echo "need route";
        //}
    }
    
    

}

$api = new SaveRouteAPI;
$api->SaveRoute();
unset($api);
?>
