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
    
$link = mysqli_connect("localhost","root","root");
mysqli_select_db($link, "senior");

class SubmitWeightAPI
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
    
	//submits the scoresheet if the user doesn't already have one submitted for the cycle
	function SubmitWeight()
	{
        if (isset($_POST["username"]) && isset($_POST["teamname"]) && isset($_POST["datesubmitted"]))
        {
                //sanitize inputs
                $username = mysql_real_escape_string( $_POST["username"] );
                $teamname = mysql_real_escape_string( $_POST["teamname"] );
                $photoData = $_FILES['file'];
                $datesubmitted = $_POST["datesubmitted"]);
            
                //TODO: Check if the user already has a scoresheet submitted for the cycle
                upload($photoData, $username, $teamname, datesubmitted);
            
                /*check if team already exists
                $result = mysql_query("select party.partyid from party where partyname = '$teamname'");
			
                //Since no teams were returned, add valid entry into database
                if( mysql_num_rows( $result ) == 0)
                {
                    //insert user into database
                    $result = mysql_query("CALL new_party('$teamname', '$username', '$password', '$isPrivate');");
                    echo "TRUE";
                }
                else
                {
                    echo "FALSE";
                }
                 */
            }
            else
            {
                echo "need username, password";
            }
    }
    
    function upload($photoData, $username, $teamname, $datesubmitted)
    {
        //check if a user ID is passed
        
        //check if there was no error during the file upload
        if ($photoData['error']==0) {
            
            $result = mysql_query("CALL submit_weight('$teamname', '$username', '$datesubmitted');");
            if (!$result['error']) {
                
                //inserted in the database, go on with file storage
                //database link
                global $link;
                
                //get the last automatically generated ID
                $IdPhoto = mysqli_insert_id($link);
                
                //move the temporarily stored file to a convenient location
                if (move_uploaded_file($photoData['tmp_name'], "upload/".$IdPhoto.".jpg")) {
                    //file moved, all good, generate thumbnail
                    thumb("upload/".$IdPhoto.".jpg", 180);
                    print json_encode(array('successful'=>1));
                } else {
                    errorJson('Upload on server problem');
                };
                
            } else {
                errorJson('Upload database problem.'.$result['error']);
            }
        } else {
            errorJson('Upload malfunction');
        }
    }
}

$api = new SubmitWeightAPI;
$api->SubmitWeight();
unset($api);
?>