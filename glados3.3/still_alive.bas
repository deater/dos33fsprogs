1 REM PORTAL CLOSING CREDITS APPLESOFT
2 REM BASED ON QBASIC VERSION BY Thomas Moss (spinneretsystems)
5 TEXT:HOME
'
10 PRINT "----------------------------------------"
20 PRINT "| Forms FORM-29827281-12:              |"
30 PRINT "| Test Assessment Report               |"
40 REM SLEEP 2
'
' This was a triump.
'
50 PRINT "| This ";
51 REM SOUND 392, 4.8
52 PRINT "was ";
53 REM SOUND 370, 4.8
54 PRINT "a ";
55 REM SOUND 330, 4.8
56 PRINT "tri";
57 REM SOUND 0, .01
58 REM SOUND 330, 4.8
59 PRINT "umph."
60 REM SOUND 370, 19.2
'
'SOUND 123.4, 4.8
'SOUND 146.8, 4.8
'SOUND 184.9, 4.8
'SOUND 146.8, 4.8
'SOUND 110, 4.8
'SOUND 146.8, 4.8
'SOUND 184.9, 4.8
'
70 REM I'm making a note here:
'text$ = "|I'm "
'slowtext
'SOUND 220, 4.8
'text$ = "ma"
'slowtext
'SOUND 392, 4.8
'text$ = "king "
'slowtext
'SOUND 370, 4.8
'text$ = "a "
'slowtext
'SOUND 330, 4.8
'text$ = "note "
'slowtext
'SOUND 0, .1
'SOUND 330, 9.6
'text$ = "here:" + CHR$(13)
'slowtext
'SOUND 370, 14.4
'
80 REM HUGE SUCCESS.
'
'text$ = "|HUGE "
'slowtext
'SOUND 294, 9.6
'text$ = "SUC"
'slowtext
'SOUND 330, 4.8
'text$ = "CESS." + CHR$(13)
'slowtext
'SOUND 220, 3.36
'delaytime = .48
'delay
'
' It's hard to overstate
'
'text$ = "|It's "
'slowtext
'SOUND 220, 4.8
'text$ = "hard "
'slowtext
'SOUND 330, 9.6
'text$ = "to "
'slowtext
'SOUND 370, 4.8
'text$ = "o"
'slowtext
'SOUND 392, 14.4
'text$ = "ver"
'slowtext
'SOUND 330, 4.8
'text$ = "state" + CHR$(13)
'slowtext
'SOUND 277, 9.6
'
' my satisfaction.
'
'text$ = "|my "
'slowtext
'SOUND 294, 14.4
'text$ = "sa"
'slowtext
'SOUND 330, 9.6
'text$ = "tis"
'slowtext
'SOUND 220, 4.8
'text$ = "fac"
'slowtext
'SOUND 0, .01
'SOUND 220, 9.6
'text$ = "tion." + CHR$(13)
'slowtext
'SOUND 370, 3.36
'
'SOUND 110, 4.8
'SOUND 146.8, 4.8
'SOUND 184.9, 4.8
'SOUND 146.8, 4.8
'
100 GOSUB 2000: REM APETURE SCIENCE LOGO
'.if 0
text$ = "|A"
slowtext
SOUND 392, 4.8
text$ = "per"
slowtext
SOUND 370, 4.8
text$ = "ture "
slowtext
SOUND 330, 4.8
text$ = "Sci"
slowtext
SOUND 0, .01
SOUND 330, 4.8
text$ = "ence" + CHR$(13)
slowtext
SOUND 370, 1.92
REM                             "|Aperture Science" + CHR$(13)

SOUND 123.4, 4.8
SOUND 146.8, 4.8
SOUND 184.9, 4.8
SOUND 146.8, 4.8
SOUND 110, 4.8
SOUND 146.8, 4.8
SOUND 184.8, 4.8

text$ = "|We "
slowtext
SOUND 220, 4.8
text$ = "do "
slowtext
SOUND 392, 4.8
text$ = "what "
slowtext
SOUND 370, 4.8
text$ = "we "
slowtext
SOUND 330, 4.8
text$ = "must" + CHR$(13)
slowtext
SOUND 0, .1
SOUND 330, 14.4
REM                             "|We do what we must" + CHR$(13)

text$ = "|be"
slowtext
SOUND 370, 4.8
text$ = "cause "
slowtext
SOUND 294, 14.4
text$ = "we "
slowtext
SOUND 330, 4.8
text$ = "can." + CHR$(13)
slowtext
SOUND 220, 14.4
REM                             "|because we can." + CHR$(13)

SOUND 184.9, 4.8
SOUND 146.8, 4.8
SOUND 123.4, 4.8
SOUND 146.8, 4.8
SOUND 184.9, 4.8
SOUND 146.8, 4.8

text$ = "|For "
slowtext
SOUND 330, 9.6
text$ = "the "
slowtext
SOUND 370, 4.8
text$ = "good "
slowtext
SOUND 392, 14.4
text$ = "of "
slowtext
SOUND 330, 4.8
text$ = "all "
slowtext
SOUND 277.2, 14.4
text$ = "of "
slowtext
SOUND 294, 4.8
text$ = "us." + CHR$(13)
slowtext
SOUND 330, 9.6
REM                             "|For the good of all of us." + CHR$(13)

radiation
LOCATE 16, 1

text$ = "|Ex"
slowtext
SOUND 220, 4.8
text$ = "cept "
slowtext
SOUND 294, 4.8
text$ = "the "
slowtext
SOUND 330, 4.8
text$ = "ones "
slowtext
SOUND 349.2, 4.8
text$ = "who "
slowtext
SOUND 330, 4.8
text$ = "are" + CHR$(13)
slowtext
SOUND 293.6, 4.8
text$ = "|dead." + CHR$(13)
slowtext
SOUND 261.6, 4.8
REM                             "|Except the ones who are" + CHR$(13) + "|dead." + CHR$(13)

SOUND 0, 9.6

aplabs
LOCATE 17, 1
PRINT "|"

text$ = "|But "
slowtext
SOUND 220, 4.8
text$ = "there's "
slowtext
SOUND 233, 4.8
text$ = "no "
slowtext
SOUND 261.6, 9.6
text$ = "sense" + CHR$(13)
slowtext
SOUND 349.2, 9.6
text$ = "|cry"
slowtext
SOUND 330, 4.8
text$ = "ing "
slowtext
SOUND 293.6, 4.8
text$ = "o"
slowtext
SOUND 0, .1
SOUND 293.6, 4.8
text$ = "ver "
slowtext
SOUND 261.6, 4.8
text$ = "e"
slowtext
SOUND 293.6, 4.8
text$ = "very" + CHR$(13)
slowtext
SOUND 261.6, 4.8
text$ = "|mis"
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
text$ = "take." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
REM                             "|But there's no sense" + CHR$(13) + "|crying over every" + CHR$(13) + "|mistake." + CHR$(13)

text$ = "|You "
slowtext
SOUND 220, 4.8
text$ = "just "
slowtext
SOUND 233, 4.8
text$ = "keep "
slowtext
SOUND 261.6, 9.6
text$ = "on "
slowtext
SOUND 349.2, 9.6
text$ = "try"
slowtext
SOUND 391.9, 4.8
text$ = "ing" + CHR$(13)
slowtext
SOUND 349.2, 4.8
text$ = "|till "
slowtext
SOUND 329.6, 4.8
text$ = "you "
slowtext
SOUND 293.6, 4.8
text$ = "run "
slowtext
SOUND 0, .2
SOUND 293.6, 4.8
text$ = "out "
slowtext
SOUND 329.6, 4.8
text$ = "of "
slowtext
SOUND 349.2, 9.6
SOUND 0, .2
text$ = "cake." + CHR$(13)
slowtext
SOUND 0, .2
SOUND 349.2, 9.6
REM                             "|You just keep on trying" + CHR$(13) + "|till you run out of cake." + CHR$(13)

atom
LOCATE 22, 1
scroll

text$ = "And "
slowtext
SOUND 391.9, 4.8
text$ = "the "
slowtext
SOUND 440, 4.8
text$ = "Sci"
slowtext
SOUND 466.1, 4.8
text$ = "ence "
slowtext
delaytime = .01
delay
SOUND 466.1, 4.8
text$ = "gets "
slowtext
SOUND 440, 9.6
text$ = "done." + CHR$(13)
slowtext
SOUND 391.9, 9.6
REM                             "And the Science gets done." + CHR$(13)

scroll

text$ = "And "
slowtext
SOUND 349.2, 4.8
text$ = "you "
slowtext
SOUND 391.9, 4.8
text$ = "make "
slowtext
SOUND 440, 4.8
text$ = "a "
slowtext
SOUND 0, .1
SOUND 440, 4.8
text$ = "neat "
slowtext
SOUND 391.9, 9.6
text$ = "gun." + CHR$(13)
slowtext
SOUND 349.2, 9.6
REM                             "And you make a neat gun." + CHR$(13)

scroll
aplabs
LOCATE 22, 1

text$ = "|For "
slowtext
SOUND 293.6, 4.8
text$ = "the "
slowtext
SOUND 261.6, 4.8
text$ = "peo"
slowtext
SOUND 293.6, 4.8
text$ = "ple "
slowtext
SOUND 349.2, 4.8
text$ = "who "
slowtext
SOUND 0, .1
SOUND 349.2, 4.8
text$ = "are" + CHR$(13)
slowtext
SOUND 329.6, 9.6
REM                             "|For the people who are" + CHR$(13)

scroll

text$ = "still "
slowtext
SOUND 329.6, 4.8
text$ = "a"
slowtext
SOUND 369.9, 4.8
text$ = "live." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 369.9, 4.8
REM                             "still alive." + CHR$(13)

FOR i = 1 TO 3
SOUND 146.8, 14.4
SOUND 0, .1
SOUND 146.8, 4.8
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8
NEXT i
SOUND 146.8, 14.4

clearleft
LOCATE 2, 2
text$ = "Forms FORM-55551-5:" + CHR$(13) + "|Personnel File Addendum:" + CHR$(13) + "|" + CHR$(13) + "|Dear <<Subject Name Here>>"
fasttext
PRINT "|"
PRINT "|"

text$ = "|I'm "
slowtext
SOUND 220, 4.8
text$ = "not "
slowtext
SOUND 391.9, 4.8
text$ = "e"
slowtext
SOUND 369.9, 4.8
text$ = "ven "
slowtext
SOUND 329.6, 4.8
text$ = "an"
slowtext
SOUND 0, .1
SOUND 329.6, 7.2
text$ = "gry." + CHR$(13)
slowtext
SOUND 369.9, 1.68

REM                             "|I'm not even angry." + CHR$(13)

SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8
SOUND 146.8, 14.4
delay
SOUND 146.6, 4.8

text$ = "|I'm "
slowtext
SOUND 391.9, 4.8
text$ = "be"
slowtext
SOUND 369.9, 4.8
text$ = "ing "
slowtext
SOUND 329.6, 4.8
text = "so "
slowtext
SOUND 0, .1
SOUND 329.6, 14.4
text = "sin"
slowtext
SOUND 369.9, 4.8
text = "cere "
slowtext
SOUND 293.6, 9.6
text = "right" + CHR$(13)
slowtext
SOUND 329.6, 9.6
text = "|now." + CHR$(13)
slowtext
SOUND 220, 14.4
REM                             "|I'm being so sincere right" + CHR$(13) + "|now." + CHR$(13)

SOUND 146.8, 4.8
SOUND 0, .1
SOUND 146.8, 4.8
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8

text$ = "|E"
slowtext
SOUND 329.6, 9.6
text$ = "ven "
slowtext
SOUND 369.9, 4.8
text$ = "though "
slowtext
SOUND 391.9, 14.4
text$ = "you "
slowtext
SOUND 329.6, 9.6
text$ = "broke "
slowtext
SOUND 277.1, 9.6
text$ = "my" + CHR$(13)
slowtext
SOUND 293.6, 4.8
REM                             "|Even though you broke my" + CHR$(13)

heart
LOCATE 11, 1

text$ = "|heart." + CHR$(13)
slowtext
SOUND 329.6, 14.4
LOCATE 12, 1

text$ = "|And "
slowtext
SOUND 220, 4.8
text$ = "killed "
slowtext
SOUND 0, .1
SOUND 220, 9.6
text$ = "me." + CHR$(13)
slowtext
SOUND 369.9, 2.4
REM                             "|heart. And killed me." + CHR$(13)

REM 480
delaytime = .48
delay

SOUND 123.4, 4.8
SOUND 146.8, 14.4

explode
LOCATE 13, 1
text$ = "|And "
slowtext
SOUND 220, 4.8
text$ = "tore "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 493.8, 1
NEXT i
text$ = "me "
slowtext
FOR i = 1 TO 2.4
SOUND 369.9, 1
SOUND 440, 1
NEXT i
text$ = "to "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "pie"
slowtext
SOUND 0, .1
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text = "ces." + CHR$(13)
slowtext
FOR i = 1 TO 4.8
SOUND 369.9, 1
SOUND 440, 1
NEXT i
REM                             "|And tore me to pieces." + CHR$(13)

REM 480
delaytime = .48
delay

SOUND 146.8, 4.8
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8
SOUND 146.8, 14.4

text$ = "|And "
slowtext
SOUND 220, 4.8
text$ = "threw "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 493.8, 1
NEXT i
text$ = "ev"
slowtext
FOR i = 1 TO 2.4
SOUND 369.9, 1
SOUND 440, 1
NEXT i
text$ = "ery "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "piece "
slowtext
SOUND 0, .1
FOR i = 1 TO 7.2
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "in"
slowtext
FOR i = 1 TO 2.6
SOUND 440, 1
SOUND 369.9, 1
NEXT i
text$ = "to" + CHR$(13)
slowtext
FOR i = 1 TO 7.2
SOUND 369.9, 1
SOUND 293.6, 1
NEXT i
REM                             "|And threw every peice into" + CHR$(13)

fire
LOCATE 15, 1

text$ = "|a "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "fire." + CHR$(13)
slowtext
FOR i = 1 TO 7.2
SOUND 293.6, 1
SOUND 220, 1
NEXT i

REM                             "|a fire." + CHR$(13)

REM 480
delaytime = .48
delay

SOUND 146.8, 4.8
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8

text$ = "|As "
slowtext
SOUND 329.6, 9.6
text$ = "they "
slowtext
SOUND 369.9, 4.8
text$ = "burned "
slowtext
SOUND 391.9, 14.4
text$ = "it "
slowtext
SOUND 329.6, 9.6
text$ = "hurt" + CHR$(13)
slowtext
SOUND 277.1, 9.6
REM                             "|As they burned it hurt" + CHR$(13)

text$ = "|be"
slowtext
SOUND 293.6, 4.8
text$ = "cause "
slowtext
SOUND 329.6, 9.6
text$ = "I "
slowtext
SOUND 220, 4.8
text$ = "was "
slowtext
SOUND 293.6, 4.8
text$ = "so "
slowtext
SOUND 329.6, 4.8
text$ = "hap"
slowtext
SOUND 349.2, 4.8
text = "py "
slowtext
SOUND 329.6, 4.8
text = "for" + CHR$(13)
slowtext
SOUND 293.6, 4.8
text = "|you!" + CHR$(13)
slowtext
SOUND 261.6, 14.4
REM                             "|becuase I was so happy for" + CHR$(13) + "|you!" + CHR$(13)

tick
delaytime = .5
delay
LOCATE 19, 1

text$ = "|Now "
slowtext
SOUND 220, 4.8
text$ = "these "
slowtext
SOUND 233, 4.8
text$ = "points "
slowtext
SOUND 261.6, 9.6
text$ = "of "
slowtext
SOUND 349.2, 9.6
text$ = "da"
slowtext
SOUND 329.6, 4.8
text$ = "ta" + CHR$(13)
slowtext
SOUND 293.6, 4.8
text$ = "|make "
slowtext
SOUND 0, .1
SOUND 293.6, 4.8
text$ = "a "
slowtext
SOUND 261.6, 4.8
text$ = "beau"
slowtext
SOUND 293.6, 4.8
text$ = "ti"
slowtext
SOUND 261.6, 4.8
text$ = "ful "
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
text$ = "line." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
REM                             "|Now these points of data" + CHR$(13) + "|make a beautiful line." + CHR$(13)

text$ = "|And "
slowtext
SOUND 220, 4.8
text$ = "we're "
slowtext
SOUND 233, 4.8
text$ = "out "
slowtext
SOUND 261.6, 9.6
text$ = "of "
slowtext
SOUND 349.2, 9.6
text$ = "be"
slowtext
SOUND 391.9, 4.8
text$ = "ta." + CHR$(13)
slowtext
SOUND 349.2, 4.8

text$ = "|We're "
slowtext
SOUND 329.6, 4.8
text$ = "re"
slowtext
SOUND 293.6, 4.8
text$ = "lea"
slowtext
SOUND 0, .1
SOUND 293.6, 4.8
text$ = "sing "
slowtext
SOUND 329.6, 4.8
text$ = "on "
slowtext
SOUND 349.2, 9.6
text$ = "time." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 349.2, 9.6
REM                             "|And we're out of beta." + CHR$(13) + "|We're releasing on time."

explode
scroll
LOCATE 22, 1

text$ = "|So "
slowtext
SOUND 391.9, 4.8
text$ = "I'm "
slowtext
SOUND 440, 4.8
text$ = "GLaD. "
slowtext
SOUND 466.1, 4.8
scroll

text$ = "I "
slowtext
SOUND 466.1, 4.8
text$ = "got "
slowtext
SOUND 440, 9.6
text$ = "burned." + CHR$(13)
slowtext
SOUND 391.9, 9.6
REM                             "|So I'm GLaD. I got burned." + CHR$(13)

scroll
atom

text$ = "|Think "
slowtext
SOUND 349.2, 4.8
text$ = "of "
slowtext
SOUND 391.9, 4.8
text$ = "all "
slowtext
SOUND 440, 4.8
text$ = "the "
slowtext
SOUND 0, .1
SOUND 440, 4.8
text$ = "things "
slowtext
SOUND 391.9, 4.8
text$ = "we" + CHR$(13)
slowtext
SOUND 349.2, 4.8
REM                             "|Think of all the things we" + CHR$(13)

scroll

text$ = "learned" + CHR$(13)
slowtext
SOUND 349.2, 9.6
REM                             "learned" + CHR$(13)

aplabs
scroll

text$ = "for "
slowtext
SOUND 293.6, 4.8
text$ = "the "
slowtext
SOUND 261.6, 4.8
text$ = "peo"
slowtext
SOUND 293.6, 4.8
text$ = "ple "
slowtext
SOUND 349.2, 4.8
text$ = "who "
slowtext
SOUND 0, .1
SOUND 349.2, 4.8
text$ = "are" + CHR$(13)
slowtext
SOUND 329.6, 9.6
REM                             "for the people who are" + CHR$(13)

scroll

text$ = "still "
slowtext
SOUND 329.6, 4.8
text$ = "alive." + CHR$(13)
slowtext
SOUND 369.9, 4.8
SOUND 0, .1
SOUND 369.9, 24
REM                             "still alive." + CHR$(13)

clearleft
text$ = "|Forms FORM-55551-6:" + CHR$(13) + "|Personnel File Addendum" + CHR$(13) + "|Addendum:" + CHR$(13) + "|" + CHR$(13)
fasttext
text$ = "|One last thing:" + CHR$(13) + "|" + CHR$(13)
slowtext

FOR i = 1 TO 3
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8
SOUND 146.6, 14.4
SOUND 0, .1
SOUND 146.6, 4.8
NEXT i

text$ = "|Go "
slowtext
SOUND 391.9, 4.8
text$ = "ahead "
slowtext
SOUND 369.9, 4.8
text$ = "and "
slowtext
SOUND 329.6, 4.8
text$ = "leave "
slowtext
SOUND 0, .1
SOUND 329.6, 9.6
text$ = "me" + CHR$(13)
slowtext
SOUND 369.9, 14.2
REM                             "|Go ahead and leave me" + CHR$(13)

SOUND 123.4, 4.8
SOUND 146.8, 4.8
SOUND 184.9, 4.8
SOUND 146.8, 4.8
SOUND 110, 4.8
SOUND 123.4, 4.8
SOUND 146.8, 4.8

text$ = "|I "
slowtext
SOUND 220, 4.8
text$ = "think "
slowtext
SOUND 391.9, 4.8
text$ = "I "
slowtext
SOUND 369.9, 4.8
text$ = "pre"
slowtext
SOUND 329.6, 4.8
text$ = "fer "
slowtext
SOUND 0, .1
SOUND 329.6, 14.2
text$ = "to "
slowtext
SOUND 369.9, 4.8
text$ = "stay" + CHR$(13)
slowtext
SOUND 293.6, 14.2
text$ = "|in"
slowtext
SOUND 329.6, 4.8
text$ = "side." + CHR$(13)
slowtext
SOUND 220, 24
REM                             "|I think I prefer to stay" + CHR$(13) + "|inside." + CHR$(13)

SOUND 123.4, 4.8
SOUND 146.8, 4.8
SOUND 184.9, 4.8
SOUND 146.8, 4.8

text$ = "|May"
slowtext
SOUND 329.6, 9.6
text$ = "be "
slowtext
SOUND 369.9, 4.8
text$ = "you'll "
slowtext
SOUND 391.9, 14.2
text$ = "find "
slowtext
SOUND 329.6, 9.6
text$ = "some"
slowtext
SOUND 277.1, 9.6
text$ = "one" + CHR$(13)
slowtext
SOUND 293.6, 4.8
text$ = "|else "
slowtext
SOUND 329.6, 9.6

REM 480
delaytime = .48
delay

text$ = "to "
slowtext
SOUND 220, 4.8
text$ = "help "
slowtext
SOUND 0, .1
SOUND 220, 9.6
text$ = "you." + CHR$(13)
slowtext
SOUND 369.9, 24
REM                             "|Maybe you'll find someone" + CHR$(13) + "|else to help you." + CHR$(13)

SOUND 184.9, 4.8
SOUND 146.8, 4.8
SOUND 110, 4.8
SOUND 146.8, 4.8
SOUND 184.9, 4.8
SOUND 146.8, 4.8

bmesa
LOCATE 13, 1

text$ = "|May"
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 493.8, 1
NEXT i
text$ = "be "
slowtext
FOR i = 1 TO 2.4
SOUND 369.9, 1
SOUND 440, 1
NEXT i
text$ = "Black "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "Me"
slowtext
SOUND 0, .1
FOR i = 1 TO 4.755
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "sa."
slowtext
FOR i = 1 TO 4.8
SOUND 440, 1
SOUND 369.9, 1
NEXT i
REM                             "|Maybe Black Mesa."

SOUND 0, .1

SOUND 146.8, 4.8
SOUND 123.4, 14.4
delay
SOUND 123.4, 4.8
SOUND 146.8, 14.4
delay
SOUND 146.8, 4.8

LOCATE 13, 19
FOR i = 1 TO 2
PRINT ".";
NEXT i
PRINT CHR$(13) + CHR$(13)

text$ = "|THAT "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 493.8, 1
NEXT i
text$ = "WAS "
slowtext
FOR i = 1 TO 2.4
SOUND 440, 1
SOUND 369.9, 1
NEXT i
text$ = "A "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "JOKE." + CHR$(13)
slowtext
FOR i = 1 TO 7.2
SOUND 391.9, 1
SOUND 329.6, 1
NEXT i
REM                             "|THAT WAS A JOKE." + CHR$(13)

REM <HAHA>
FOR i = 1 TO 2.4
SOUND 440, 1
SOUND 369.9, 1
NEXT i
FOR i = 1 TO 7.2
SOUND 369.9, 1
SOUND 293.6, 1
NEXT i
text$ = "|FAT "
fasttext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 329.6, 1
NEXT i
text$ = "CHANCE." + CHR$(13)
fasttext
FOR i = 1 TO 7.2
SOUND 293.6, 1
SOUND 220, 1
NEXT i
REM                             "|FAT CHANCE." + CHR$(13)

REM 480
delaytime = .48
delay

SOUND 146.8, 4.8
SOUND 123.4, 14.4
SOUND 0, .1
SOUND 123.4, 4.8

text$ = "|A"
slowtext
SOUND 329.6, 9.6
text$ = "ny"
slowtext
SOUND 369.9, 4.8
text = "way, "
slowtext
SOUND 391.9, 14.4
text = "this "
slowtext
SOUND 329.6, 9.6
text$ = "cake "
slowtext
SOUND 277.1, 9.6
text$ = "is" + CHR$(13)
slowtext
SOUND 293.6, 4.8
REM                             "|Anyway, this cake is" + CHR$(13)

cake
LOCATE 19, 1

text$ = "|great." + CHR$(13)
slowtext
SOUND 329.6, 9.6
REM                             "|great." + CHR$(13)

text$ = "|It's "
slowtext
SOUND 220, 4.8
text$ = "so "
slowtext
SOUND 293.6, 4.8
text$ = "de"
slowtext
SOUND 329.6, 4.8
text$ = "li"
slowtext
SOUND 349.2, 4.8
text$ = "cious "
slowtext
SOUND 329.6, 4.8
text$ = "and" + CHR$(13)
slowtext
SOUND 293.6, 4.8
text$ = "|moist." + CHR$(13)
slowtext
SOUND 261.6, 14.4
REM                             "|It's so delicious and" + CHR$(13) + "|moist." + CHR$(13)

GLaDOS
LOCATE 22, 1

text$ = "|Look "
slowtext
SOUND 220, 4.8
text$ = "at "
slowtext
SOUND 233, 4.8
text$ = "me "
slowtext
SOUND 261.6, 9.6
text$ = "still" + CHR$(13)
slowtext
SOUND 349.2, 9.6
REM                             "|Look at me still" + CHR$(13)

scroll

text$ = "tal"
slowtext
SOUND 329.6, 4.8
text$ = "king "
slowtext
SOUND 293.6, 4.8
text$ = "when "
slowtext
SOUND 0, .1
SOUND 293.6, 4.8
text$ = "there's" + CHR$(13)
slowtext
SOUND 261.6, 4.8
REM                             "talking when there's" + CHR$(13)

scroll
radiation
LOCATE 22, 1

text$ = "|Sci"
slowtext
SOUND 293.6, 4.8
text$ = "ence "
slowtext
SOUND 261.6, 4.8
text$ = "to "
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
text$ = "do." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 261.6, 9.6
REM                             "|Science to do." + CHR$(13)

aplabs
scroll
LOCATE 22, 1

text$ = "|When "
slowtext
SOUND 220, 4.8
text$ = "I "
slowtext
SOUND 233, 4.8
text$ = "look "
slowtext
SOUND 261.6, 9.6
text$ = "out "
slowtext
SOUND 349.2, 9.6
text$ = "there "
slowtext
SOUND 391.9, 4.8
text$ = "it" + CHR$(13)
slowtext
SOUND 349.2, 4.8
REM                             "|When I look out there it" + CHR$(13)

scroll
LOCATE 22, 1

text$ = "|Makes "
slowtext
SOUND 329.6, 4.8
text$ = "me "
slowtext
SOUND 293.6, 4.8
text$ = "GLaD "
slowtext
SOUND 0, .1
SOUND 293.6, 4.8
text$ = "I'm "
slowtext
SOUND 329.6, 4.8
text$ = "not "
slowtext
SOUND 349.2, 9.6
text$ = "you." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 349.2, 9.6
REM                             "|Makes me GLaD I'm not you." + CHR$(13)

atom
scroll
LOCATE 22, 1

text$ = "|I've "
slowtext
SOUND 391.9, 4.8
text$ = "ex"
slowtext
SOUND 440, 4.8
text$ = "pe"
slowtext
SOUND 466.1, 4.8
text$ = "ri"
slowtext
SOUND 0, .1
SOUND 466.1, 4.8
text$ = "ments "
slowtext
SOUND 440, 4.7
text$ = "to "
slowtext
SOUND 391.9, 4.7

REM 18
SOUND 0, .18

text$ = "run." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 391.9, 9.6
REM                             "|I've experiments to run." + CHR$(13)

scroll
explode
LOCATE 22, 1

text$ = "|There "
slowtext
SOUND 349.2, 4.8
text$ = "is "
slowtext
SOUND 391.9, 4.8
text$ = "re"
slowtext
SOUND 440, 4.8
text$ = "search "
slowtext
SOUND 0, .1
SOUND 440, 4.8
text$ = "to "
slowtext
SOUND 391.9, 4.8
text$ = "be" + CHR$(13)
slowtext
SOUND 349.2, 4.8
REM                             "|There is research to be" + CHR$(13)

scroll

text$ = "done." + CHR$(13)
slowtext
SOUND 349.2, 9.6
REM                             "done." + CHR$(13)

scroll
aplabs
LOCATE 22, 1

text$ = "|On "
slowtext
SOUND 293.6, 4.8
text$ = "the "
slowtext
SOUND 261.6, 4.8
text$ = "peo"
slowtext
SOUND 293.6, 4.8
text$ = "ple "
slowtext
SOUND 349.2, 4.8
text$ = "who "
slowtext
SOUND 0, .1
SOUND 349.2, 4.8
text$ = "are" + CHR$(13)
slowtext
SOUND 329.6, 9.6
REM                             "|On the people who are" + CHR$(13)

scroll

text$ = "still "
slowtext
SOUND 329.6, 4.8
text$ = "a"
slowtext
SOUND 369.9, 4.8
text$ = "live." + CHR$(13)
slowtext
SOUND 0, .1
SOUND 369.9, 24
REM                             "still alive." + CHR$(13)

hl

clearleft
LOCATE 5, 2

hl

text$ = "PS: And "
slowtext
SOUND 440, 4.7

text$ = "be"
slowtext
SOUND 440, 4.7

REM 9
delaytime = .09
delay

text$ = "lieve "
slowtext
SOUND 493.8, 4.7

REM 9
delaytime = .09
delay

text$ = "me "
slowtext
SOUND 440, 4.7

REM 9
delaytime = .09
delay

text$ = "I "
slowtext
SOUND 369.9, 4.7

REM 9
delaytime = .09
delay

text$ = "am" + CHR$(13)
slowtext
SOUND 293.6, 9.6
text$ = "|still "
slowtext
SOUND 329.6, 4.8
text$ = "a"
slowtext
SOUND 369.9, 4.8
text$ = "live." + CHR$(13)
slowtext
FOR i = 1 TO 7.2
SOUND 369.9, 1
SOUND 440, 1
NEXT i
REM                             "PS: And believe me I am" + CHR$(13) + "|still alive." + CHR$(13)

hl

text$ = "|PPS: "
fasttext

text$ = "I'm "
slowtext
SOUND 440, 4.8
text$ = "do"
slowtext
delaytime = .01
delay
SOUND 440, 4.8
text$ = "ing "
slowtext
delay
SOUND 440, 4.8
text$ = "Sci"
slowtext
SOUND 493.8, 4.8
text$ = "ence" + CHR$(13)
slowtext
SOUND 440, 4.8
text$ = "|and "
slowtext
SOUND 369.9, 4.8
text$ = "I'm" + CHR$(13)
slowtext
SOUND 293.6, 9.6
text$ = "|still "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 329.6, 1
NEXT i
text$ = "a"
slowtext
FOR i = 1 TO 2.4
SOUND 440, 1
SOUND 369.9, 1
NEXT i
text$ = "live." + CHR$(13)
slowtext
FOR i = 1 TO 7.2
SOUND 440, 1
SOUND 369.9, 1
NEXT i
REM                             "|PPS: I'm doing Science" + CHR$(13) + "|and I'm" + CHR$(13) + "|still alive." + CHR$(13)

hl

text$ = "|PPPS: "
fasttext

text$ = "I "
slowtext
SOUND 440, 4.8
text$ = "feel "
slowtext
delaytime = .01
delay
SOUND 440, 4.8
text$ = "FAN"
slowtext
delaytime = .01
delay
SOUND 440, 4.8
text$ = "TAS"
slowtext
SOUND 493.8, 4.8
text$ = "TIC" + CHR$(13)
slowtext
SOUND 440, 4.8
text$ = "|and "
slowtext
SOUND 369.9, 4.8
text$ = "I'm" + CHR$(13)
slowtext
SOUND 293.6, 9.6
text$ = "|still "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 329.6, 1
NEXT i
text$ = "a"
slowtext
FOR i = 1 TO 2.4
SOUND 440, 1
SOUND 369.9, 1
NEXT i
text$ = "live." + CHR$(13)
slowtext
delaytime = .01
delay
FOR i = 1 TO 7.2
SOUND 440, 1
SOUND 369.9, 1
NEXT i
REM                             "|PPPS: I feel FANTASTIC" + CHR$(13) + "|and I'm" + CHR$(13) + "|still alive" + CHR$(13)

PRINT "|"
text$ = "|FINAL THOUGHT:" + CHR$(13)
fasttext

hl

text$ = "|While "
slowtext
SOUND 440, 4.8
text$ = "you're "
slowtext
delaytime = .01
delay
SOUND 440, 4.8
text$ = "dy"
slowtext
SOUND 493.8, 4.8
text$ = "ing "
slowtext
SOUND 440, 4.8
text$ = "I'll "
slowtext
SOUND 369.9, 4.8
text$ = "be" + CHR$(13)
slowtext
SOUND 293.6, 9.6
text$ = "|still "
slowtext
FOR i = 1 TO 2.4
SOUND 391.9, 1
SOUND 329.6, 1
NEXT i
text$ = "a"
slowtext
FOR i = 1 TO 2.4
SOUND 369.9, 1
SOUND 440, 1
NEXT i
text$ = "live"
slowtext
SOUND 0, .1
FOR i = 1 TO 9.6
SOUND 440, 1
SOUND 369.9, 1
NEXT i
REM                             "|FINAL THOUGHT:" + CHR$(13) + "|While you're dying I'll be" + CHR$(13) + "|still alive." + CHR$(13)

text$ = CHR$(13) + "|" + CHR$(13) + "|FINAL THOUGHT PS:" + CHR$(13)
fasttext

hl

text$ = "|And "
slowtext
SOUND 440, 4.8
text$ = "when "
slowtext
SOUND 0, .1
SOUND 440, 4.8
text$ = "you're "
slowtext
SOUND 0, .1
SOUND 440, 4.8
text$ = "dead "
slowtext
SOUND 493.8, 4.8
text$ = "I" + CHR$(13)
slowtext
SOUND 440, 4.8
text$ = "|will "
slowtext
SOUND 369.9, 4.8
text$ = "be" + CHR$(13)
slowtext
SOUND 293.6, 9.6
text$ = "|still "
slowtext
FOR i = 1 TO 2.4
SOUND 329.6, 1
SOUND 391.9, 1
NEXT i
text$ = "a"
slowtext
FOR i = 1 TO 2.4
SOUND 440, 1
SOUND 369.9, 1
NEXT i
text$ = "live" + CHR$(13)
slowtext
SOUND 0, .1
FOR i = 1 TO 7.2
SOUND 440, 1
SOUND 369.9, 1
NEXT i
REM                             "|FINAL THOUGHT PS:" + CHR$(13) + "|And when you're dead I" + CHR$(13) + "|will be" + CHR$(13) +"|still alive" + CHR$(13)

REM 1440
delaytime = 1.44
delay

scroll
text$ = CHR$(13)
slowtext
scroll

REM <STILL ALIVE>
SOUND 391.9, 4.8
SOUND 440, 4.8
SOUND 0, .1
SOUND 440, 14.4
delaytime = 1.44
delay
REM </STILL ALIVE>

text$ = "STILL "
slowtext
SOUND 391.9, 4.8
text$ = "ALIVE"
slowtext
SOUND 0, .1
SOUND 369.9, 4.8
SOUND 0, .1
SOUND 369.9, 4.8
REM                             "STILL ALIVE"

SLEEP 2
clearleft
LOCATE 22, 1
text$ = "|THANK YOU FOR" + CHR$(13)
slowtext
scroll
text$ = "PARTICIPATING IN THIS" + CHR$(13)
slowtext
scroll
text$ = "ENRICHMENT CENTER" + CHR$(13)
slowtext
scroll
text$ = "ACTIVITY!!"
slowtext
FOR i = 1 TO 6
scroll
NEXT i
SLEEP 5
LOCATE 22, 2
'.endif
'
2000 REM APETURE
2001 PRINT "              .,-:;//;:=,               "
2002 PRINT "          . :H@@@MM@M#H/.,+%;,          "
2003 PRINT "       ,/X+ +M@@M@MM%=,-%HMMM@X/,       "
2004 PRINT "     -+@MM; $M@@MH+-,;XMMMM@MMMM@+-     "
2005 PRINT "    ;@M@@M- XM@X;. -+XXXXXHHH@M@M#@/.   "
2006 PRINT "  ,%MM@@MH ,@%=            .---=-=:=,.  "
2007 PRINT "  =@#@@@MX .,              -%HX$$%%%+;  "
2008 PRINT " =-./@M@M$                  .;@MMMM@MM: "
2009 PRINT " X@/ -$MM/                    .+MM@@@M$ "
2010 PRINT ",@M@H: :@:                    . =X#@@@@-"
2011 PRINT ",@@@MMX, .                    /H- ;@M@M="
2012 PRINT ".H@@@@M@+,                    %MM+..%#$."
2013 PRINT " /MMMM@MMH/.                  XM@MH; =; "
2014 PRINT "  /%+%$XHH@$=              , .H@@@@MX,  "
2015 PRINT "   .=--------.           -%H.,@@@@@MX,  "
2016 PRINT "   .%MM@@@HHHXX$$$%+- .:$MMX =M@@MM%.   "
2017 PRINT "     =XMMM@MM@MM#H;,-+HMM@M+ /MMMX=     "
2018 PRINT "       =%@M@M#@$-.=$@MM@@@M; %M%=       "
2019 PRINT "         ,:+$+-,/H#MMMMMMM@= =,         "
2020 PRINT "               =++%%%%+/:-.             "
2030 RETURN
'
2100 REM RADIOACTIVE
2101 PRINT "             =+$HM####@H%;,             "
2102 PRINT "          /H###############M$,          "
2103 PRINT "          ,@################+           "
2104 PRINT "           .H##############+            "
2105 PRINT "             X############/             "
2106 PRINT "              $##########/              "
2107 PRINT "               %########/               "
2108 PRINT "                /X/;;+X/                "
2109 PRINT
2110 PRINT "                 -XHHX-                 "
2111 PRINT "                ,######,                "
2112 PRINT "#############X  .M####M.  X#############"
2113 PRINT "##############-   -//-   -##############"
2114 PRINT "X##############%,      ,+##############X"
2115 PRINT "-##############X        X##############-"
2116 PRINT " %############%          %############% "
2117 PRINT "  %##########;            ;##########%  "
2118 PRINT "   ;#######M=              =M#######;   "
2119 PRINT "    .+M###@,                ,@###M+.    "
2120 PRINT "       :XH.                  .HX:       "
2130 RETURN
'
2200 REM ATOM
2201 PRINT "                 =/;;/-                 "
2202 PRINT "                +:    //                "
2203 PRINT "               /;      /;               "
2204 PRINT "              -X        H.              "
2205 PRINT ".//;;;:;;-,   X=        :+   .-;:=;:;%;."
2206 PRINT "M-       ,=;;;#:,      ,:#;;:=,       ,@"
2207 PRINT ":%           :%.=/++++/=.$=           %="
2208 PRINT " ,%;         %/:+/;,,/++:+/         ;+. "
2209 PRINT "   ,+/.    ,;@+,        ,%H;,    ,/+,   "
2210 PRINT "      ;+;;/= @.  .H##X   -X :///+;      "
2211 PRINT "      ;+=;;;.@,  .XM@$.  =X.//;=%/.     "
2212 PRINT "   ,;:      :@%=        =$H:     .+%-   "
2213 PRINT " ,%=         %;-///==///-//         =%, "
2214 PRINT ";+           :%-;;;:;;;;-X-           +:"
2215 PRINT "@-      .-;;;;M-        =M/;;;-.      -X"
2216 PRINT " :;;::;;-.    %-        :+    ,-;;-;:== "
2217 PRINT "              ,X        H.              "
2218 PRINT "               ;/      %=               "
2219 PRINT "                //    +;                "
2220 PRINT "                 ,////,                 "
2230 RETURN
'
2300 REM BROKEN HEART
2301 PRINT "                          .,---.        "
2302 PRINT "                        ,/XM#MMMX;,     "
2303 PRINT "                      -%##########M%,   "
2304 PRINT "                     -@######%  $###@=  "
2305 PRINT "      .,--,         -H#######$   $###M: "
2306 PRINT "   ,;$M###MMX;     .;##########$;HM###X="
2307 PRINT " ,/@##########H=      ;################+"
2308 PRINT "-+#############M/,      %##############+"
2309 PRINT "%M###############=      /##############:"
2310 PRINT "H################      .M#############;."
2311 PRINT "@###############M      ,@###########M:. "
2312 PRINT "X################,      -$=X#######@:   "
2313 PRINT "/@##################%-     +######$-    "
2314 PRINT ".;##################X     .X#####+,     "
2315 PRINT " .;H################/     -X####+.      "
2316 PRINT "   ,;X##############,       .MM/        "
2317 PRINT "      ,:+$H@M#######M#$-    .$$=        "
2318 PRINT "           .,-=;+$@###X:    ;/=.        "
2319 PRINT "                  .,/X$;   .::,         "
2320 PRINT "                      .,    ..          "
2330 RETURN
'
2400 REM EXPLOSION
2401 PRINT "            .+                          "
2402 PRINT "             /M;                        "
2403 PRINT "              H#@:              ;,      "
2404 PRINT "              -###H-          -@/       "
2405 PRINT "               %####$.  -;  .%#X        "
2406 PRINT "                M#####+;#H :M#M.        "
2407 PRINT "..          .+/;%#########X###-         "
2408 PRINT " -/%H%+;-,    +##############/          "
2409 PRINT "    .:$M###MH$%+############X  ,--=;-   "
2410 PRINT "        -/H#####################H+=.    "
2411 PRINT "           .+#################X.        "
2412 PRINT "         =%M####################H;.     "
2413 PRINT "            /@###############+;;/%%;,   "
2414 PRINT "         -%###################$.        "
2415 PRINT "       ;H######################M=       "
2416 PRINT "    ,%#####MH$%;+#####M###-/@####%      "
2417 PRINT "  :$H%+;=-      -####X.,H#   -+M##@-    "
2418 PRINT " .              ,###;    ;      =$##+   "
2419 PRINT "                .#H,               :XH, "
2420 PRINT "                 +                   .;-"
2430 RETURN
'
2500 REM FIRE
2501 PRINT "                     -$-                "
2502 PRINT "                    .H##H,              "
2503 PRINT "                   +######+             "
2504 PRINT "                .+#########H.           "
2505 PRINT "              -$############@.          "
2506 PRINT "            =H###############@  -X:     "
2507 PRINT "          .$##################:  @#@-   "
2508 PRINT "     ,;  .M###################;  H###;  "
2509 PRINT "   ;@#:  @###################@  ,#####: "
2510 PRINT " -M###.  M#################@.  ;######H "
2511 PRINT " M####-  +###############$   =@#######X "
2512 PRINT " H####$   -M###########+   :#########M, "
2513 PRINT "  /####X-   =########%   :M########@/.  "
2514 PRINT "    ,;%H@X;   .$###X   :##MM@%+;:-      "
2515 PRINT "                 ..                     "
2516 PRINT "  -/;:-,.              ,,-==+M########H "
2517 PRINT " -##################@HX%%+%%$%%%+:,,    "
2518 PRINT "    .-/H%%%+%%$H@###############M@+=:/+:"
2519 PRINT "/XHX%:#####MH%=    ,---:;;;;/%%XHM,:###$"
2520 PRINT "$@#MX %+;-                           .  "
2530 RETURN
'
2600 REM CHECK
2601 PRINT "                                     :X-"
2602 PRINT "                                  :X### "
2603 PRINT "                                ;@####@ "
2604 PRINT "                              ;M######X "
2605 PRINT "                            -@########$ "
2606 PRINT "                          .$##########@ "
2607 PRINT "                         =M############-"
2608 PRINT "                        +##############$"
2609 PRINT "                      .H############$=. "
2610 PRINT "         ,/:         ,M##########M;.    "
2611 PRINT "      -+@###;       =##########M;       "
2612 PRINT "   =%M#######;     :#########M/         "
2613 PRINT "-$M###########;   :#########/           "
2614 PRINT " ,;X###########; =########$.            "
2615 PRINT "     ;H#########+#######M=              "
2616 PRINT "       ,+##############+                "
2617 PRINT "          /M#########@-                 "
2618 PRINT "            ;M######%                   "
2619 PRINT "              +####:                    "
2620 PRINT "               ,$M-                     "
2630 RETURN
'
2800 REM BLACK MESA
2801 PRINT "           .-;+$XHHHHHHX$+;-.           "
2802 PRINT "        ,;X@@X%/;=----=:/%X@@X/,        "
2803 PRINT "      =$@@%=.              .=+H@X:      "
2804 PRINT "    -XMX:                      =XMX=    "
2805 PRINT "   /@@:                          =H@+   "
2806 PRINT "  %@X,                            .$@$  "
2807 PRINT " +@X.                               $@% "
2808 PRINT "-@@,                                .@@="
2809 PRINT "%@%                                  +@$"
2810 PRINT "H@:                                  :@H"
2811 PRINT "H@:         :HHHHHHHHHHHHHHHHHHX,    =@H"
2812 PRINT "%@%         ;@M@@@@@@@@@@@@@@@@@H-   +@$"
2813 PRINT "=@@,        :@@@@@@@@@@@@@@@@@@@@@= .@@:"
2814 PRINT " +@X        :@@@@@@@@@@@@@@@M@@@@@@:%@% "
2815 PRINT "  $@$,      ;@@@@@@@@@@@@@@@@@M@@@@@@$. "
2816 PRINT "   +@@HHHHHHH@@@@@@@@@@@@@@@@@@@@@@@+   "
2817 PRINT "    =X@@@@@@@@@@@@@@@@@@@@@@@@@@@@X=    "
2818 PRINT "      :$@@@@@@@@@@@@@@@@@@@M@@@@$:      "
2819 PRINT "        ,;$@@@@@@@@@@@@@@@@@@X/-        "
2820 PRINT "           .-;+$XXHHHHHX$+;-.           "
2830 RETURN
'
2900 REM CAKE DELICIOUS AND MOIST
2901 PRINT "            ,:/+/-                      "
2902 PRINT "            /M/              .,-=;//;-  "
2903 PRINT "       .:/= ;MH/,    ,=/+%$XH@MM#@:     "
2904 PRINT "      -$##@+$###@H@MMM#######H:.    -/H#"
2905 PRINT " .,H@H@ X######@ -H#####@+-     -+H###@X"
2906 PRINT "  .,@##H;      +XM##M/,     =%@###@X;-  "
2907 PRINT "X%-  :M##########$.    .:%M###@%:       "
2908 PRINT "M##H,   +H@@@$/-.  ,;$M###@%,          -"
2909 PRINT "M####M=,,---,.-%%H####M$:          ,+@##"
2910 PRINT "@##################@/.         :%H##@$- "
2911 PRINT "M###############H,         ;HM##M$=     "
2912 PRINT "#################.    .=$M##M$=         "
2913 PRINT "################H..;XM##M$=          .:+"
2914 PRINT "M###################@%=           =+@MH%"
2915 PRINT "@################M/.          =+H#X%=   "
2916 PRINT "=+M##############M,       -/X#X+;.      "
2917 PRINT "  .;XM##########H=    ,/X#H+:,          "
2918 PRINT "     .=+HM######M+/+HM@+=.              "
2919 PRINT "         ,:/%XM####H/.                  "
2920 PRINT "              ,.:=-.                    "
2930 RETURN
'
3000 REM GLaDOS
3001 PRINT "       #+ @      # #              M#@   "
3002 PRINT " .    .X  X.%##@;# #   +@#######X. @#%  "
3003 PRINT "   ,==.   ,######M+  -#####%M####M-    #"
3004 PRINT "  :H##M%:=##+ .M##M,;#####/+#######% ,M#"
3005 PRINT " .M########=  =@#@.=#####M=M#######=  X#"
3006 PRINT " :@@MMM##M.  -##M.,#######M#######. =  M"
3007 PRINT "             @##..###:.    .H####. @@ X,"
3008 PRINT "   ############: ###,/####;  /##= @#. M "
3009 PRINT "           ,M## ;##,@#M;/M#M  @# X#% X# "
3010 PRINT ".%=   ######M## ##.M#:   ./#M ,M #M ,#$ "
3011 PRINT "##/         $## #+;#: #### ;#/ M M- @# :"
3012 PRINT "#+ #M@MM###M-;M #:$#-##$H# .#X @ + $#. #"
3013 PRINT "      ######/.: #%=# M#:MM./#.-#  @#: H#"
3014 PRINT "+,.=   @###: /@ %#,@  ##@X #,-#@.##% .@#"
3015 PRINT "#####+;/##/ @##  @#,+       /#M    . X, "
3016 PRINT "   ;###M#@ M###H .#M-     ,##M  ;@@; ###"
3017 PRINT "   .M#M##H ;####X ,@#######M/ -M###$  -H"
3018 PRINT "    .M###%  X####H  .@@MM@;  ;@#M@      "
3019 PRINT "      H#M    /@####/      ,++.  / ==-,  "
3020 PRINT "               ,=/:, .+X@MMH@#H  #####$="
3030 RETURN
'
3100 REM hl
3101 REM SOUND 146.6, 4.8
3102 REM SOUND 0, .1
3103 REM SOUND 146.6, 4.8
3104 REM SOUND 123.4, 4.8
3105 RETURN
'
3200 REM SLOWTEXT
3201 REM FOR count = 1 TO LEN(text$)
3202 REM PRINT MID$(text$, count, 1);
3203 REM FOR i = 1 TO 100:NEXT i
3204 REM NEXT count
