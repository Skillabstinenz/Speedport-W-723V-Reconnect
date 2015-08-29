# Speedport W 723V Reconnect Typ A
Autoit Script: https://www.autoitscript.com/site/autoit/

All logging functions are only needed for debugging, like:

 #include <log.au3>
_logit(.....)


Same goes for the creation of files on R:\, like:

$oReceived = $oHTTP.ResponseText
$file = FileOpen("R:\1login.html",2)
FileWrite($file,$oReceived)
FileClose($file)
