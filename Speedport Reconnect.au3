#cs Automatic Reconnect with the Speedport W 723V Typ A

2015.09.14	x fixed expired ssl certificate
2015.06?	x fixed conection erros, https doesn't work anymore
2014.01.01 + created
#ce
#include <log.au3> ; "needed" for convenient logging output

; ---- Login
$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
; ignore all SSL errors WinHttpRequestOption_SslErrorIgnoreFlags
$oHTTP.Option(4) = 0x2000
; Unknown certification authority (CA) or untrusted root   0x0100
; Wrong usage                                              0x0200
; Invalid common name (CN)                                 0x1000
; Invalid date or certificate expired                      0x2000
;Post request
$oHTTP.Open("POST", "https://speedport.ip/index/login.cgi", False)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send("Username=admin&Password=BASE64PASSWORD")
;$oHTTP.Send("Username=admin&Password=" & $CmdLine[1]) ; pw als parameter übergeben, base64 encodet!
_logit("login s: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("login: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
If $oStatusCode <> 200 Then
	;ClipPut($httpheader)
	_logit("header: " & $oHeaderResponses)
EndIf
$oReceived = $oHTTP.ResponseText & @CRLF & @CRLF & $oHeaderResponses
$file = FileOpen("R:\1login.html",2)
FileWrite($file,$oReceived)
FileClose($file)

; get session
$cookie = StringRegExp($oHeaderResponses,"Set-Cookie: (SessionID_R3=\w{11}); path",3) ; SessionID_R3=eauTnzR0EeY for cookies
$cookie = $cookie[0]
_logit("cookie: " & $cookie)
$session = StringReplace($cookie,"=",",") ; SessionID_R3,eauTnzR0EeY für urls

;Sleep(2500)
; --- inet trennen
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "https://speedport.ip/auth/disDSL.cgi?RequestFile=/auth/hcti_startseite.php&cookie=" & $session, False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("disc s: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("disc: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
If $oStatusCode <> 200 Then
	;ClipPut($httpheader)
	_logit("header: " & $oHeaderResponses)
EndIf
$oReceived = $oHTTP.ResponseText & @CRLF & @CRLF & $oHeaderResponses
$file = FileOpen("R:\2disc.html",2)
FileWrite($file,$oReceived)
FileClose($file)

Sleep(2500)
; --- inet reconnect
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "https://speedport.ip/auth/cntDSL.cgi?RequestFile=/auth/hcti_startseite.php&cookie=" & $session, False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("recon s: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("recon: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
If $oStatusCode <> 200 Then
	;ClipPut($httpheader)
	_logit("header: " & $oHeaderResponses)
EndIf
$oReceived = $oHTTP.ResponseText & @CRLF & @CRLF & $oHeaderResponses
$file = FileOpen("R:\3recon.html",2)
FileWrite($file,$oReceived)
FileClose($file)

;Sleep(2500)
; --- Logout (only one can be logged in at any one time)
;$oHTTP = 0
;$oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
;Post request
$oHTTP.Open("POST", "https://speedport.ip/auth/logout.cgi?RequestFile=/pub/top_beenden.php&cookie=" & $session, False)
;$oHTTP.Open("POST", "https://speedport.ip/", False)
; cookie
$oHTTP.SetRequestHeader("Cookie", $cookie)
;Add Content-Type
$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
;Send POST request
$oHTTP.Send()
_logit("logout s: " & @error)
;Get received data
$oStatusCode = $oHTTP.Status
_logit("logout: " & $oStatusCode)
$oHeaderResponses = $oHTTP.GetAllResponseHeaders()
If $oStatusCode <> 200 Then
	;ClipPut($httpheader)
	_logit("header: " & $oHeaderResponses)
EndIf
$oReceived = $oHTTP.ResponseText & @CRLF & @CRLF & $oHeaderResponses
$file = FileOpen("R:\4logout.html",2)
FileWrite($file,$oReceived)
FileClose($file)

Sleep(12345)
