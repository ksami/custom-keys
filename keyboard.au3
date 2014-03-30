#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>
#include <Misc.au3>
#include <keyboardVars.au3>

HotKeySet("!q", "_Exit")

;;;;;
;Globals
;;;;;
$file_settingsini = "settings.ini"
$file_keylayout = ""		;blank is default QWERTY
$font_size = 8.5
$font_weight = 100			;in %
$font_attribute = 0			;italic:2 underlined:4 strike:8, add vals together eg. 2+4
$font_font = ""				;OS default font
$color_keypressed = 0x03c03c
$color_keyboard = 0xeeeeee
$color_keytext = 0x000000
$color_transparency = 100	;in %
$size_width = 100			;in %
$size_height = 100			;in %

$hDLL = DllOpen("user32.dll")
$capslock_on = False

;;;;;
;Program start
;;;;;

initSettings()
initKeyLabels()

;;Init GUI
Local $hGUI = GUICreate("Keyboard", 581, 201, -1, 600, $WS_POPUP, $WS_EX_TOPMOST)
GUICtrlCreateLabel("Click to drag this GUI" & @CRLF & "Press ESC to exit", 10, 10)
GUISetBkColor($color_keyboard, $hGUI)
GUICtrlSetDefColor($color_keytext, $hGUI)
GUISetFont($font_size, ($font_weight/100)*400, $font_attribute, $font_font, $hGUI)

createKeys()

GUISetState(@SW_SHOW, $hGUI)
WinMove($hGUI, "", Default, Default, ($size_width/100)*581, ($size_height/100)*201)
WinSetTrans($hGUI, "", ($color_transparency/100)*255)

;;Run GUI and wait for close or clickdrag
While 1
  keypress()
  Switch GUIGetMsg()
	  Case $GUI_EVENT_CLOSE
		  ExitLoop
	  Case $GUI_EVENT_PRIMARYDOWN
		 _SendMessage($hGUI, $WM_SYSCOMMAND, 0xF012, 0)
  EndSwitch
WEnd
_Exit()

;;;;;
;Program End
;;;;;

Func keypress()
    checkKey("08", $bs, $bswas)
	checkKey("09", $tab, $tabwas)
    checkKey("0D", $enter, $enterwas)
    checkKey("14", $CapsLock, $CapsLockwas)
    checkKey("20", $space, $spacewas)
	checkKey("30", $0, $0was)
	checkKey("31", $1, $1was)
	checkKey("32", $2, $2was)
	checkKey("33", $3, $3was)
	checkKey("34", $4, $4was)
	checkKey("35", $5, $5was)
	checkKey("36", $6, $6was)
	checkKey("37", $7, $7was)
	checkKey("38", $8, $8was)
	checkKey("39", $9, $9was)
	checkKey("41", $a, $awas)
	checkKey("42", $b, $bwas)
	checkKey("43", $c, $cwas)
	checkKey("44", $d, $dwas)
	checkKey("45", $e, $ewas)
	checkKey("46", $f, $fwas)
	checkKey("47", $g, $gwas)
	checkKey("48", $h, $hwas)
	checkKey("49", $i, $iwas)
	checkKey("4A", $j, $jwas)
	checkKey("4B", $k, $kwas)
	checkKey("4C", $l, $lwas)
	checkKey("4D", $m, $mwas)
	checkKey("4E", $n, $nwas)
	checkKey("4F", $o, $owas)
	checkKey("50", $p, $pwas)
	checkKey("51", $q, $qwas)
	checkKey("52", $r, $rwas)
	checkKey("53", $s, $swas)
	checkKey("54", $t, $twas)
	checkKey("55", $u, $uwas)
	checkKey("56", $v, $vwas)
	checkKey("57", $w, $wwas)
	checkKey("58", $x, $xwas)
	checkKey("59", $y, $ywas)
	checkKey("5A", $z, $zwas)
	checkKey("A0", $Lshift, $Lshiftwas)
    checkKey("A1", $Rshift, $Rshiftwas)
	checkKey("A2", $Lctrl, $Lctrlwas)
	checkKey("A3", $Rctrl, $Rctrlwas)
	checkKey("A4", $Lalt, $Laltwas)
	checkKey("A5", $Ralt, $Raltwas)
	checkKey("BA", $semicolon, $semicolonwas)
	checkKey("BB", $eq, $eqwas)
	checkKey("BC", $comma, $commawas)
	checkKey("BD", $dash, $dashwas)
	checkKey("BE", $Period, $Periodwas)
	checkKey("BF", $FrontSlash, $FrontSlashwas)
	checkKey("C0", $tilda, $tildawas)
	checkKey("DB", $OpenBracket, $OpenBracketwas)
	checkKey("DC", $BkSlash, $BkSlashwas)
	checkKey("DD", $CloseBracket, $CloseBracketwas)
	checkKey("DE", $quotes, $quoteswas)
EndFunc

Func checkKey($keyHex, $keyVar, ByRef $keyWas)
   If _IsPressed($keyHex, $hDLL) AND ($keyWas = False) Then
	  $keyWas = True
	  GUICtrlSetBkColor($keyVar,$color_keypressed)
	  
	  ;Capslock
	  If ($keyHex = "14") Then
		 $capslock_on = Not($capslock_on)
		 If ($capslock_on = True) Then
			shiftKeys(True, "caps")
		 Else
			shiftKeys(False, "caps")
		 EndIf
	  EndIf
	  
	  ;Shift
	  If ($keyHex = "A0") OR ($keyHex = "A1") Then
		 shiftKeys(NOT($capslock_on), "shift")
	  EndIf
   ElseIf NOT(_IsPressed($keyHex, $hDLL)) AND ($keyWas = True) Then
	  $keyWas = False
	  GUICtrlSetBkColor($keyVar,$color_keyboard)
	  
	  ;Shift
	  If ($keyHex = "A0") OR ($keyHex = "A1") Then
		 shiftKeys($capslock_on, "shift")
	  EndIf
   EndIf
EndFunc

Func shiftKeys($isShifted, $shiftorcaps)
   If $isShifted = True Then

	  $qlabel = $qlabelshift
	  $wlabel = $wlabelshift
	  $elabel = $elabelshift
	  $rlabel = $rlabelshift
	  $tlabel = $tlabelshift
	  $ylabel = $ylabelshift
	  $ulabel = $ulabelshift
	  $ilabel = $ilabelshift
	  $olabel = $olabelshift
	  $plabel = $plabelshift

	  $alabel = $alabelshift
	  $slabel = $slabelshift
	  $dlabel = $dlabelshift
	  $flabel = $flabelshift
	  $glabel = $glabelshift
	  $hlabel = $hlabelshift
	  $jlabel = $jlabelshift
	  $klabel = $klabelshift
	  $llabel = $llabelshift  

	  $zlabel = $zlabelshift
	  $xlabel = $xlabelshift
	  $clabel = $clabelshift
	  $vlabel = $vlabelshift
	  $blabel = $blabelshift
	  $nlabel = $nlabelshift
	  $mlabel = $mlabelshift

	  If ($shiftorcaps = "shift") AND NOT($capslock_on) Then
		  $tildalabel = $tildalabelshift
		  $1label = $1labelshift
	  	  $2label = $2labelshift
		  $3label = $3labelshift
		  $4label = $4labelshift
		  $5label = $5labelshift
		  $6label = $6labelshift
		  $7label = $7labelshift
		  $8label = $8labelshift
		  $9label = $9labelshift
		  $0label = $0labelshift
		  $dashlabel = $dashlabelshift
		  $eqlabel = $eqlabelshift

		  $OpenBracketlabel = $OpenBracketlabelshift
		  $CloseBracketlabel = $CloseBracketlabelshift
		  $BkSlashlabel = $BkSlashlabelshift

		  $semicolonlabel = $semicolonlabelshift
		  $quoteslabel = $quoteslabelshift

		  $commalabel = $commalabelshift
		  $Periodlabel = $Periodlabelshift
		  $FrontSlashlabel = $FrontSlashlabelshift
	  EndIf
   Else
	  $qlabel = $qlabelnorm
	  $wlabel = $wlabelnorm
	  $elabel = $elabelnorm
	  $rlabel = $rlabelnorm
	  $tlabel = $tlabelnorm
	  $ylabel = $ylabelnorm
	  $ulabel = $ulabelnorm
	  $ilabel = $ilabelnorm
	  $olabel = $olabelnorm
	  $plabel = $plabelnorm

	  $alabel = $alabelnorm
	  $slabel = $slabelnorm
	  $dlabel = $dlabelnorm
	  $flabel = $flabelnorm
	  $glabel = $glabelnorm
	  $hlabel = $hlabelnorm
	  $jlabel = $jlabelnorm
	  $klabel = $klabelnorm
	  $llabel = $llabelnorm

	  $zlabel = $zlabelnorm
	  $xlabel = $xlabelnorm
	  $clabel = $clabelnorm
	  $vlabel = $vlabelnorm
	  $blabel = $blabelnorm
	  $nlabel = $nlabelnorm
	  $mlabel = $mlabelnorm

	  If ($shiftorcaps = "shift") AND NOT($capslock_on) Then
		  $tildalabel = $tildalabelnorm
		  $1label = $1labelnorm
		  $2label = $2labelnorm
		  $3label = $3labelnorm
		  $4label = $4labelnorm
		  $5label = $5labelnorm
		  $6label = $6labelnorm
		  $7label = $7labelnorm
		  $8label = $8labelnorm
		  $9label = $9labelnorm
		  $0label = $0labelnorm
		  $dashlabel = $dashlabelnorm
		  $eqlabel = $eqlabelnorm

		  $OpenBracketlabel = $OpenBracketlabelnorm
		  $CloseBracketlabel = $CloseBracketlabelnorm
		  $BkSlashlabel = $BkSlashlabelnorm

		  $semicolonlabel = $semicolonlabelnorm
		  $quoteslabel = $quoteslabelnorm

		  $commalabel = $commalabelnorm
		  $Periodlabel = $Periodlabelnorm
		  $FrontSlashlabel = $FrontSlashlabelnorm
	  EndIf
   EndIf
   
   GUICtrlSetData($tilda, $tildalabel)
   GUICtrlSetData($1, $1label)
   GUICtrlSetData($2, $2label)
   GUICtrlSetData($3, $3label)
   GUICtrlSetData($4, $4label)
   GUICtrlSetData($5, $5label)
   GUICtrlSetData($6, $6label)
   GUICtrlSetData($7, $7label)
   GUICtrlSetData($8, $8label)
   GUICtrlSetData($9, $9label)
   GUICtrlSetData($0, $0label)
   GUICtrlSetData($dash, $dashlabel)
   GUICtrlSetData($eq, $eqlabel)

   GUICtrlSetData($q, $qlabel)
   GUICtrlSetData($w, $wlabel)
   GUICtrlSetData($e, $elabel)
   GUICtrlSetData($r, $rlabel)
   GUICtrlSetData($t, $tlabel)
   GUICtrlSetData($y, $ylabel)
   GUICtrlSetData($u, $ulabel)
   GUICtrlSetData($i, $ilabel)
   GUICtrlSetData($o, $olabel)
   GUICtrlSetData($p, $plabel)
   GUICtrlSetData($OpenBracket, $OpenBracketlabel)
   GUICtrlSetData($CloseBracket, $CloseBracketlabel)
   GUICtrlSetData($BkSlash, $BkSlashlabel)

   GUICtrlSetData($a, $alabel)
   GUICtrlSetData($s, $slabel)
   GUICtrlSetData($d, $dlabel)
   GUICtrlSetData($f, $flabel)
   GUICtrlSetData($g, $glabel)
   GUICtrlSetData($h, $hlabel)
   GUICtrlSetData($j, $jlabel)
   GUICtrlSetData($k, $klabel)
   GUICtrlSetData($l, $llabel)
   GUICtrlSetData($semicolon, $semicolonlabel)
   GUICtrlSetData($quotes, $quoteslabel)

   GUICtrlSetData($z, $zlabel)
   GUICtrlSetData($x, $xlabel)
   GUICtrlSetData($c, $clabel)
   GUICtrlSetData($v, $vlabel)
   GUICtrlSetData($b, $blabel)
   GUICtrlSetData($n, $nlabel)
   GUICtrlSetData($m, $mlabel)
   GUICtrlSetData($comma, $commalabel)
   GUICtrlSetData($Period, $Periodlabel)
   GUICtrlSetData($FrontSlash, $FrontSlashlabel)
EndFunc

Func createKeys()
   $tilda = GUICtrlCreateLabel($tildalabel, 0, 0, 42, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $1 = GUICtrlCreateLabel($1label, 40, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $2 = GUICtrlCreateLabel($2label, 80, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $3 = GUICtrlCreateLabel($3label, 120, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $4 = GUICtrlCreateLabel($4label, 160, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $5 = GUICtrlCreateLabel($5label, 200, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $6 = GUICtrlCreateLabel($6label, 240, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $7 = GUICtrlCreateLabel($7label, 280, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $8 = GUICtrlCreateLabel($8label, 320, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $9 = GUICtrlCreateLabel($9label, 360, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $0 = GUICtrlCreateLabel($0label, 400, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $dash = GUICtrlCreateLabel($dashlabel, 440, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $eq = GUICtrlCreateLabel($eqlabel, 480, 0, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $bs = GUICtrlCreateLabel($bslabel, 522, 0, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))

   $tab = GUICtrlCreateLabel($tablabel, 0, 40, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $q = GUICtrlCreateLabel($qlabel, 58, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $w = GUICtrlCreateLabel($wlabel, 98, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $e = GUICtrlCreateLabel($elabel, 138, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $r = GUICtrlCreateLabel($rlabel, 178, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $t = GUICtrlCreateLabel($tlabel, 218, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $y = GUICtrlCreateLabel($ylabel, 258, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $u = GUICtrlCreateLabel($ulabel, 298, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $i = GUICtrlCreateLabel($ilabel, 338, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $o = GUICtrlCreateLabel($olabel, 378, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $p = GUICtrlCreateLabel($plabel, 418, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $OpenBracket = GUICtrlCreateLabel($OpenBracketlabel, 458, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $CloseBracket = GUICtrlCreateLabel($CloseBracketlabel, 498, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $BkSlash = GUICtrlCreateLabel($BkSlashlabel, 538, 40, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))

   $CapsLock = GUICtrlCreateLabel($CapsLocklabel, 0, 80, 75, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $a = GUICtrlCreateLabel($alabel, 73, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $s = GUICtrlCreateLabel($slabel, 113, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $d = GUICtrlCreateLabel($dlabel, 153, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $f = GUICtrlCreateLabel($flabel, 193, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $g = GUICtrlCreateLabel($glabel, 233, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $h = GUICtrlCreateLabel($hlabel, 273, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $j = GUICtrlCreateLabel($jlabel, 312, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $k = GUICtrlCreateLabel($klabel, 353, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $l = GUICtrlCreateLabel($llabel, 393, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $semicolon = GUICtrlCreateLabel($semicolonlabel, 433, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $quotes = GUICtrlCreateLabel($quoteslabel, 473, 80, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $enter = GUICtrlCreateLabel($enterlabel, 514, 80, 67, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))


   $Lshift = GUICtrlCreateLabel($Lshiftlabel, 0, 120, 91, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $z = GUICtrlCreateLabel($zlabel, 89, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $x = GUICtrlCreateLabel($xlabel, 129, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $c = GUICtrlCreateLabel($clabel, 169, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $v = GUICtrlCreateLabel($vlabel, 209, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $b = GUICtrlCreateLabel($blabel, 249, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $n = GUICtrlCreateLabel($nlabel, 289, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $m = GUICtrlCreateLabel($mlabel, 329, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $comma = GUICtrlCreateLabel($commalabel, 369, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $Period = GUICtrlCreateLabel($Periodlabel, 409, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $FrontSlash = GUICtrlCreateLabel($FrontSlashlabel, 449, 120, 43, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $Rshift = GUICtrlCreateLabel($Rshiftlabel, 490, 120, 91, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))

   $Lctrl = GUICtrlCreateLabel($Lctrllabel, 0, 160, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   GUICtrlCreateLabel("", 56, 160, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $Lalt = GUICtrlCreateLabel($Laltlabel, 112, 160, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $space = GUICtrlCreateLabel($spacelabel, 168, 160, 187, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $Ralt = GUICtrlCreateLabel($Raltlabel, 352, 160, 59, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   GUICtrlCreateLabel("", 409, 160, 58, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   GUICtrlCreateLabel("", 465, 160, 51, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
   $Rctrl = GUICtrlCreateLabel($Rctrllabel, 515, 160, 66, 41, BitOR($WS_BORDER, $SS_CENTER, $SS_CENTERIMAGE, $SS_NOPREFIX))
EndFunc

Func initKeyLabels()
   ; If not default layout
   If Not($file_keylayout = "") Then
	  Local $file = FileOpen($file_keylayout, 0)

	  ; Check if file opened for reading OK
	  If $file = -1 Then
		  MsgBox(0, "Error", "Unable to open file " & $file_keylayout)
		  Exit
	  EndIf

	  ; File read at lines 1-4, 6-9
	  Local $line = FileReadLine($file,1)
	  Local $aline = StringSplit($line,"")
	  Local $i = 1

	  $tildalabelnorm = $aline[$i]
	  $i = $i + 1
	  $1labelnorm = $aline[$i]
	  $i = $i + 1
	  $2labelnorm = $aline[$i]
	  $i = $i + 1
	  $3labelnorm = $aline[$i]
	  $i = $i + 1
	  $4labelnorm = $aline[$i]
	  $i = $i + 1
	  $5labelnorm = $aline[$i]
	  $i = $i + 1
	  $6labelnorm = $aline[$i]
	  $i = $i + 1
	  $7labelnorm = $aline[$i]
	  $i = $i + 1
	  $8labelnorm = $aline[$i]
	  $i = $i + 1
	  $9labelnorm = $aline[$i]
	  $i = $i + 1
	  $0labelnorm = $aline[$i]
	  $i = $i + 1
	  $dashlabelnorm = $aline[$i]
	  $i = $i + 1
	  $eqlabelnorm = $aline[$i]
	  
	  $line = FileReadLine($file,2)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $qlabelnorm = $aline[$i]
	  $i = $i + 1
	  $wlabelnorm = $aline[$i]
	  $i = $i + 1
	  $elabelnorm = $aline[$i]
	  $i = $i + 1
	  $rlabelnorm = $aline[$i]
	  $i = $i + 1
	  $tlabelnorm = $aline[$i]
	  $i = $i + 1
	  $ylabelnorm = $aline[$i]
	  $i = $i + 1
	  $ulabelnorm = $aline[$i]
	  $i = $i + 1
	  $ilabelnorm = $aline[$i]
	  $i = $i + 1
	  $olabelnorm = $aline[$i]
	  $i = $i + 1
	  $plabelnorm = $aline[$i]
	  $i = $i + 1
	  $OpenBracketlabelnorm = $aline[$i]
	  $i = $i + 1
	  $CloseBracketlabelnorm = $aline[$i]
	  $i = $i + 1
	  $BkSlashlabelnorm = $aline[$i]

	  $line = FileReadLine($file,3)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $alabelnorm = $aline[$i]
	  $i = $i + 1
	  $slabelnorm = $aline[$i]
	  $i = $i + 1
	  $dlabelnorm = $aline[$i]
	  $i = $i + 1
	  $flabelnorm = $aline[$i]
	  $i = $i + 1
	  $glabelnorm = $aline[$i]
	  $i = $i + 1
	  $hlabelnorm = $aline[$i]
	  $i = $i + 1
	  $jlabelnorm = $aline[$i]
	  $i = $i + 1
	  $klabelnorm = $aline[$i]
	  $i = $i + 1
	  $llabelnorm = $aline[$i]
	  $i = $i + 1
	  $semicolonlabelnorm = $aline[$i]
	  $i = $i + 1
	  $quoteslabelnorm = $aline[$i]

	  $line = FileReadLine($file,4)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $zlabelnorm = $aline[$i]
	  $i = $i + 1
	  $xlabelnorm = $aline[$i]
	  $i = $i + 1
	  $clabelnorm = $aline[$i]
	  $i = $i + 1
	  $vlabelnorm = $aline[$i]
	  $i = $i + 1
	  $blabelnorm = $aline[$i]
	  $i = $i + 1
	  $nlabelnorm = $aline[$i]
	  $i = $i + 1
	  $mlabelnorm = $aline[$i]
	  $i = $i + 1
	  $commalabelnorm = $aline[$i]
	  $i = $i + 1
	  $Periodlabelnorm = $aline[$i]
	  $i = $i + 1
	  $FrontSlashlabelnorm = $aline[$i]

	  $tildalabel = $tildalabelnorm
	  $1label = $1labelnorm
	  $2label = $2labelnorm
	  $3label = $3labelnorm
	  $4label = $4labelnorm
	  $5label = $5labelnorm
	  $6label = $6labelnorm
	  $7label = $7labelnorm
	  $8label = $8labelnorm
	  $9label = $9labelnorm
	  $0label = $0labelnorm
	  $dashlabel = $dashlabelnorm
	  $eqlabel = $eqlabelnorm
  
  
	  $qlabel = $qlabelnorm
	  $wlabel = $wlabelnorm
	  $elabel = $elabelnorm
	  $rlabel = $rlabelnorm
	  $tlabel = $tlabelnorm
	  $ylabel = $ylabelnorm
	  $ulabel = $ulabelnorm
	  $ilabel = $ilabelnorm
	  $olabel = $olabelnorm
	  $plabel = $plabelnorm
	  $OpenBracketlabel = $OpenBracketlabelnorm
	  $CloseBracketlabel = $CloseBracketlabelnorm
	  $BkSlashlabel = $BkSlashlabelnorm
  
  
	  $alabel = $alabelnorm
	  $slabel = $slabelnorm
	  $dlabel = $dlabelnorm
	  $flabel = $flabelnorm
	  $glabel = $glabelnorm
	  $hlabel = $hlabelnorm
	  $jlabel = $jlabelnorm
	  $klabel = $klabelnorm
	  $llabel = $llabelnorm
	  $semicolonlabel = $semicolonlabelnorm
	  $quoteslabel = $quoteslabelnorm
  
  
	  $zlabel = $zlabelnorm
	  $xlabel = $xlabelnorm
	  $clabel = $clabelnorm
	  $vlabel = $vlabelnorm
	  $blabel = $blabelnorm
	  $nlabel = $nlabelnorm
	  $mlabel = $mlabelnorm
	  $commalabel = $commalabelnorm
	  $Periodlabel = $Periodlabelnorm
	  $FrontSlashlabel = $FrontSlashlabelnorm

	  ;shifted keys
	  $line = FileReadLine($file,6)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $tildalabelshift = $aline[$i]
	  $i = $i + 1
	  $1labelshift = $aline[$i]
	  $i = $i + 1
	  $2labelshift = $aline[$i]
	  $i = $i + 1
	  $3labelshift = $aline[$i]
	  $i = $i + 1
	  $4labelshift = $aline[$i]
	  $i = $i + 1
	  $5labelshift = $aline[$i]
	  $i = $i + 1
	  $6labelshift = $aline[$i]
	  $i = $i + 1
	  $7labelshift = $aline[$i]
	  $i = $i + 1
	  $8labelshift = $aline[$i]
	  $i = $i + 1
	  $9labelshift = $aline[$i]
	  $i = $i + 1
	  $0labelshift = $aline[$i]
	  $i = $i + 1
	  $dashlabelshift = $aline[$i]
	  $i = $i + 1
	  $eqlabelshift = $aline[$i]
	  
	  $line = FileReadLine($file,7)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $qlabelshift = $aline[$i]
	  $i = $i + 1
	  $wlabelshift = $aline[$i]
	  $i = $i + 1
	  $elabelshift = $aline[$i]
	  $i = $i + 1
	  $rlabelshift = $aline[$i]
	  $i = $i + 1
	  $tlabelshift = $aline[$i]
	  $i = $i + 1
	  $ylabelshift = $aline[$i]
	  $i = $i + 1
	  $ulabelshift = $aline[$i]
	  $i = $i + 1
	  $ilabelshift = $aline[$i]
	  $i = $i + 1
	  $olabelshift = $aline[$i]
	  $i = $i + 1
	  $plabelshift = $aline[$i]
	  $i = $i + 1
	  $OpenBracketlabelshift = $aline[$i]
	  $i = $i + 1
	  $CloseBracketlabelshift = $aline[$i]
	  $i = $i + 1
	  $BkSlashlabelshift = $aline[$i]

	  $line = FileReadLine($file,8)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $alabelshift = $aline[$i]
	  $i = $i + 1
	  $slabelshift = $aline[$i]
	  $i = $i + 1
	  $dlabelshift = $aline[$i]
	  $i = $i + 1
	  $flabelshift = $aline[$i]
	  $i = $i + 1
	  $glabelshift = $aline[$i]
	  $i = $i + 1
	  $hlabelshift = $aline[$i]
	  $i = $i + 1
	  $jlabelshift = $aline[$i]
	  $i = $i + 1
	  $klabelshift = $aline[$i]
	  $i = $i + 1
	  $llabelshift = $aline[$i]
	  $i = $i + 1
	  $semicolonlabelshift = $aline[$i]
	  $i = $i + 1
	  $quoteslabelshift = $aline[$i]

	  $line = FileReadLine($file,9)
	  $aline = StringSplit($line,"")
	  $i = 1

	  $zlabelshift = $aline[$i]
	  $i = $i + 1
	  $xlabelshift = $aline[$i]
	  $i = $i + 1
	  $clabelshift = $aline[$i]
	  $i = $i + 1
	  $vlabelshift = $aline[$i]
	  $i = $i + 1
	  $blabelshift = $aline[$i]
	  $i = $i + 1
	  $nlabelshift = $aline[$i]
	  $i = $i + 1
	  $mlabelshift = $aline[$i]
	  $i = $i + 1
	  $commalabelshift = $aline[$i]
	  $i = $i + 1
	  $Periodlabelshift = $aline[$i]
	  $i = $i + 1
	  $FrontSlashlabelshift = $aline[$i]


	  FileClose($file)
   EndIf
EndFunc

Func initSettings()
   $file_keylayout = IniRead($file_settingsini, "Keyboard Layouts", "Current", $file_keylayout)
   $color_keypressed = IniRead($file_settingsini, "Colours", "Key Pressed", $color_keypressed)
   $color_keyboard = IniRead($file_settingsini, "Colours", "Keyboard", $color_keyboard)
   $color_keytext = IniRead($file_settingsini, "Colours", "Key Text", $color_keytext)
   $color_transparency = IniRead($file_settingsini, "Colours", "Transparency", $color_transparency)
   $font_size = IniRead($file_settingsini, "Font", "Size", $font_size)
   $font_weight = IniRead($file_settingsini, "Font", "Weight", $font_weight)
   $font_font = IniRead($file_settingsini, "Font", "Font Face", $font_font)
   $size_width = IniRead($file_settingsini, "Interface", "Width", $size_width)
   $size_height = IniRead($file_settingsini, "Interface", "Height", $size_height)
EndFunc

Func _Exit()
   GUIDelete($hGUI)
   DllClose($hDLL)
   Exit
EndFunc