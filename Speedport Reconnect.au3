#cs Automatic Reconnect with the Speedport W 723V Typ A

2015 x fixed connection erros, https doesn't work anymore, expired certificate
2014.01.01 + created
#ce
#include <log.au3> ; "needed" for convenient logging output

; ---- Login
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "http://speedport.ip/index/login.cgi", False)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send("Username=admin&Password=BASE64PASSWORD") ; pw base64 encodeD!
;$oHTTP.Send("Username=admin&Password=" & $CmdLine[1]) ; pw as parameter, base64 encoded!
_logit("login send: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("login: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
_logit("header: " & $oHeaderResponses)
$oReceived = $oHTTP.ResponseText
$file = FileOpen("R:\1login.html",2)
FileWrite($file,$oReceived)
FileClose($file)

; get session
$cookie = StringRegExp($oHeaderResponses,"Set-Cookie: (SessionID_R3=\w{11}); path",3) ; SessionID_R3=eauTnzR0EeY for cookies
$cookie = $cookie[0]
_logit("cookie: " & $cookie)
$session = StringReplace($cookie,"=",",") ; SessionID_R3,eauTnzR0EeY für urls

; --- inet terminate
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "http://speedport.ip/auth/disDSL.cgi?RequestFile=/auth/hcti_startseite.php&cookie=" & $session, False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("disc send: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("disc: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
_logit("header: " & $oHeaderResponses)
$oReceived = $oHTTP.ResponseText
$file = FileOpen("R:\2disc.html",2)
FileWrite($file,$oReceived)
FileClose($file)

Sleep(2500)
; --- inet reconnect
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "http://speedport.ip/auth/cntDSL.cgi?RequestFile=/auth/hcti_startseite.php&cookie=" & $session, False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("recon send: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("recon: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
_logit("header: " & $oHeaderResponses)
$oReceived = $oHTTP.ResponseText
$file = FileOpen("R:\3recon.html",2)
FileWrite($file,$oReceived)
FileClose($file)

; --- Logout (only one can be logged in at any one time)
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "http://speedport.ip/auth/logout.cgi?RequestFile=/pub/top_beenden.php&cookie=" & $session, False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("logout send: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("logout: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
_logit("header: " & $oHeaderResponses)
$oReceived = $oHTTP.ResponseText
$file = FileOpen("R:\4logout.html",2)
FileWrite($file,$oReceived)
FileClose($file)

Sleep(12345) ; leave time to see output, terminates afterwards
