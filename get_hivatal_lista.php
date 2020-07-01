
<?php 
/*
exec() - Execute an external program
shell_exec () - Execute command via shell and return the complete output as a string
system() - Execute an external program and display the output
passthru() - Execute an external program and display raw output
*/

function execInBackground($cmd) {
    if (substr(php_uname(), 0, 7) == "Windows"){
        pclose(popen("start /B ". $cmd, "r")); 
    }
    else {
        exec($cmd . " > /dev/null &");  
    }
}


if (!file_exists("hivatal_lista_".date("Ymd").".csv")) {
	if (!file_exists(date("Ymd").".tmp")) {
		execInBackground('perl get_hivatal_lista.pl');
		//exec('perl get_hivatal_lista.pl');
		print("A frissítés megkezdődött. Ez általában 1-2 percig tart, ennek elteltével a keresést ismételd meg.");
	} else {
		print("A frissítés folymatban van. 1-2 perc türelmet kérek, melynek elteltével a keresést ismételd meg.");
	}
	return;
}

 
//$path='.';
//$files = array_diff(scandir($path), array('.', '..'));
//foreach($file as $files) { if(is_file("$file")) { } } 

$query = htmlspecialchars($_GET["query"]);
$files = glob("hivatal_lista_*.csv");
$file=$files[count($files)-1];

$lines=array();
$fp = fopen($file, "r+");
array_push($lines,fgets($fp));
while ($line = stream_get_line($fp, 1024 * 1024, "\n")) {
  if(preg_match("/".$query."/i", $line)) {
    array_push($lines,$line);
  }
}
fclose($fp);

$i=0;
print ("<table class=myTable><caption>Adatforrás: $file</caption>");
foreach ($lines as $line) {
	print ("<tr id=$i>");
	if($i==0) {
		print("<th>&numero;</th>");
	} else {
		print ("<td>$i</td>");
	}
	$pieces = explode(";", $line);
	foreach ($pieces as $pie) {
		if($i==0) {
			print("<th>$pie</th>");
		} else {
			print("<td>".str_replace('"','',$pie)."</td>");
		}
	}
	print ("</tr>");
	$i++;
}
print ("</table>");

?>

