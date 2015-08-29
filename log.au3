#include-once
#cs include for easier logging, to see what the script is doing e.g.: logit("changed var $map to : " & $map)
and sometimes the clear_edit_box() func needs to be called to clear the edit box

2013.12.30	+ window is resizable
2013.12.23	+ window is now closable with the "X"
			x windowname changed from scriptname.au3-log to scriptname
2011.06.11	+ created
#ce
#include <GUIConstantsEx.au3> ; var for on close event
#include <WindowsConstants.au3> ; var for resizable

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode

; GUI
$fensterx = 515 ; ui width
$fenstery = 300 ; ui heigth
$guiwintext = StringLeft(@ScriptName,StringLen(@ScriptName)-4)

$guiwin = GUICreate($guiwintext,$fensterx,$fenstery,600,700,$WS_OVERLAPPEDWINDOW) ;creates the resizable loggui
GUISetOnEvent($GUI_EVENT_CLOSE, "_log_win_close") ;  registering the close event
;editbox for log
$guiedit = GUICtrlCreateEdit("Starting up...",0,0,$fensterx,$fenstery) ;creates the textfield in the gui
GUISetState(@SW_SHOW) ; shows it
;WinSetOnTop($guiwin,"",1) ; sets the window on top, who would have thought that

; makes the window closable
Func _log_win_close()
	Exit
EndFunc

;timestamps the text, appends a new line and puts it in the editbox as log
Func _logit($text)
	GUICtrlSetData($guiedit, @HOUR & ":" & @MIN & ":" & @SEC & " " & $text & @CRLF, "append") ; creates logentry
EndFunc   ;==>_logit

; removes older lines from the edit box, so that there is always place for new ones
Func _clear_edit_box()
	$tmp = GUICtrlRead($guiedit)
	;If StringLen($tmp) > 29500 Then
	If StringLen($tmp) > 20000 Then
		GUICtrlSetData($guiedit,StringTrimLeft($tmp,5000))
	EndIf
EndFunc   ;==>_clear_edit_box
