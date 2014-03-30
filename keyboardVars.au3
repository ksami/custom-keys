;;Keys

Global $tilda
Global $1
Global $2
Global $3
Global $4
Global $5
Global $6
Global $7
Global $8
Global $9
Global $0
Global $dash
Global $eq
Global $bs

Global $tab
Global $q
Global $w
Global $e 
Global $r 
Global $t 
Global $y 
Global $u 
Global $i 
Global $o 
Global $p 
Global $OpenBracket 
Global $CloseBracket 
Global $BkSlash 

Global $CapsLock
Global $a
Global $s
Global $d
Global $f
Global $g
Global $h
Global $j
Global $k
Global $l
Global $semicolon 
Global $quotes 
Global $enter

Global $Lshift
Global $z
Global $x
Global $c
Global $v
Global $b
Global $n
Global $m
Global $comma
Global $Period
Global $FrontSlash
Global $Rshift

Global $Lctrl
Global $Lalt
Global $space
Global $Ralt
Global $Rctrl

;;key statuses - saves if prev state of key was pressed
Global $tildawas = False
Global $1was = False
Global $2was = False
Global $3was = False
Global $4was = False
Global $5was = False
Global $6was = False
Global $7was = False
Global $8was = False
Global $9was = False
Global $0was = False
Global $dashwas = False
Global $eqwas = False
Global $bswas = False

Global $tabwas = False
Global $qwas = False
Global $wwas = False
Global $ewas = False
Global $rwas = False
Global $twas = False
Global $ywas = False
Global $uwas = False
Global $iwas = False
Global $owas = False
Global $pwas = False
Global $OpenBracketwas = False
Global $CloseBracketwas = False
Global $BkSlashwas = False

Global $CapsLockwas = False
Global $awas = False
Global $swas = False
Global $dwas = False
Global $fwas = False
Global $gwas = False
Global $hwas = False
Global $jwas = False
Global $kwas = False
Global $lwas = False
Global $semicolonwas = False
Global $quoteswas = False
Global $enterwas = False

Global $Lshiftwas = False
Global $zwas = False
Global $xwas = False
Global $cwas = False
Global $vwas = False
Global $bwas = False
Global $nwas = False
Global $mwas = False
Global $commawas = False
Global $Periodwas = False
Global $FrontSlashwas = False
Global $Rshiftwas = False

Global $Lctrlwas = False
Global $Laltwas = False
Global $spacewas = False
Global $Raltwas = False
Global $Rctrlwas = False

;;Key Labels
Global $tildalabel = "`"
Global $1label = "1"
Global $2label = "2"
Global $3label = "3"
Global $4label = "4"
Global $5label = "5"
Global $6label = "6"
Global $7label = "7"
Global $8label = "8"
Global $9label = "9"
Global $0label = "0"
Global $dashlabel = "-"
Global $eqlabel = "="
Global $bslabel = "Bksp"

Global $tablabel = "Tab"
Global $qlabel = "q"
Global $wlabel = "w"
Global $elabel = "e"
Global $rlabel = "r"
Global $tlabel = "t"
Global $ylabel = "y"
Global $ulabel = "u"
Global $ilabel = "i"
Global $olabel = "o"
Global $plabel = "p"
Global $OpenBracketlabel = "["
Global $CloseBracketlabel = "]"
Global $BkSlashlabel = "\"

Global $CapsLocklabel = "Caps"
Global $alabel = "a"
Global $slabel = "s"
Global $dlabel = "d"
Global $flabel = "f"
Global $glabel = "g"
Global $hlabel = "h"
Global $jlabel = "j"
Global $klabel = "k"
Global $llabel = "l"
Global $semicolonlabel = ";"
Global $quoteslabel = "'"
Global $enterlabel = "Enter"

Global $Lshiftlabel = "Shift"
Global $zlabel = "z"
Global $xlabel = "x"
Global $clabel = "c"
Global $vlabel = "v"
Global $blabel = "b"
Global $nlabel = "n"
Global $mlabel = "m"
Global $commalabel = ","
Global $Periodlabel = "."
Global $FrontSlashlabel = "/"
Global $Rshiftlabel = "Shift"

Global $Lctrllabel = "Ctrl"
Global $Laltlabel = "Alt"
Global $spacelabel = "Space"
Global $Raltlabel = "Alt"
Global $Rctrllabel = "Ctrl"


;Shifted keys
Global $tildalabelshift = "~"
Global $1labelshift = "!"
Global $2labelshift = "@"
Global $3labelshift = "#"
Global $4labelshift = "$"
Global $5labelshift = "%"
Global $6labelshift = "^"
Global $7labelshift = "&"
Global $8labelshift = "*"
Global $9labelshift = "("
Global $0labelshift = ")"
Global $dashlabelshift = "_"
Global $eqlabelshift = "+"


Global $qlabelshift = "Q"
Global $wlabelshift = "W"
Global $elabelshift = "E"
Global $rlabelshift = "R"
Global $tlabelshift = "T"
Global $ylabelshift = "Y"
Global $ulabelshift = "U"
Global $ilabelshift = "I"
Global $olabelshift = "O"
Global $plabelshift = "P"
Global $OpenBracketlabelshift = "{"
Global $CloseBracketlabelshift = "}"
Global $BkSlashlabelshift = "|"


Global $alabelshift = "A"
Global $slabelshift = "S"
Global $dlabelshift = "D"
Global $flabelshift = "F"
Global $glabelshift = "G"
Global $hlabelshift = "H"
Global $jlabelshift = "J"
Global $klabelshift = "K"
Global $llabelshift = "L"
Global $semicolonlabelshift = ":"
Global $quoteslabelshift = '"'


Global $zlabelshift = "Z"
Global $xlabelshift = "X"
Global $clabelshift = "C"
Global $vlabelshift = "V"
Global $blabelshift = "B"
Global $nlabelshift = "N"
Global $mlabelshift = "M"
Global $commalabelshift = "<"
Global $Periodlabelshift = ">"
Global $FrontSlashlabelshift = "?"


;Non-shifted
Global $tildalabelnorm = "`"
Global $1labelnorm = "1"
Global $2labelnorm = "2"
Global $3labelnorm = "3"
Global $4labelnorm = "4"
Global $5labelnorm = "5"
Global $6labelnorm = "6"
Global $7labelnorm = "7"
Global $8labelnorm = "8"
Global $9labelnorm = "9"
Global $0labelnorm = "0"
Global $dashlabelnorm = "-"
Global $eqlabelnorm = "="


Global $qlabelnorm = "q"
Global $wlabelnorm = "w"
Global $elabelnorm = "e"
Global $rlabelnorm = "r"
Global $tlabelnorm = "t"
Global $ylabelnorm = "y"
Global $ulabelnorm = "u"
Global $ilabelnorm = "i"
Global $olabelnorm = "o"
Global $plabelnorm = "p"
Global $OpenBracketlabelnorm = "["
Global $CloseBracketlabelnorm = "]"
Global $BkSlashlabelnorm = "\"


Global $alabelnorm = "a"
Global $slabelnorm = "s"
Global $dlabelnorm = "d"
Global $flabelnorm = "f"
Global $glabelnorm = "g"
Global $hlabelnorm = "h"
Global $jlabelnorm = "j"
Global $klabelnorm = "k"
Global $llabelnorm = "l"
Global $semicolonlabelnorm = ";"
Global $quoteslabelnorm = "'"


Global $zlabelnorm = "z"
Global $xlabelnorm = "x"
Global $clabelnorm = "c"
Global $vlabelnorm = "v"
Global $blabelnorm = "b"
Global $nlabelnorm = "n"
Global $mlabelnorm = "m"
Global $commalabelnorm = ","
Global $Periodlabelnorm = "."
Global $FrontSlashlabelnorm = "/"