; Applesoft Shape Table

; Size
;.byte	$07,00
; Offsets 
;.byte	$10,$00	; 0
;.byte	$1b,$00	; 1
;.byte	$2e,$00	; 2
;.byte	$42,$00	; 3
;.byte	$61,$00	; 4
;.byte	$80,$00 ; 5
;.byte	$8a,$00	; 6

; Shape 0
; "Cross Hair"  (why is this in quotes?)
;   #
;   #
;   #                
;   #                  
; ##.##  
;   #                   
;   #
;   #
;   #
; START
; NLT NLT
; RT RT NRT NRT LT LT 
; NDN NDN NDN NDN UP UP UP UP UP UP UP UP UP
; STOP
;
.byte $1b,$6d,$39,$97,$12,$24,$24,$24,$24, $04,$00


; Shape 1
;
; "Portal"
;   #
;  # #
;  # #
;  # #
; #   #
; #   #
; # * #
; #   #
; #   #
;  # #
;  # #
;  # #
;   #
;
; START
; NLT NLT UP UP UP NRT UP UP UP NRT RT NDN
; DN DN DN NRT DN DN DN DN DN NLT DN DN DN NLT
; UP NLT UP UP UP NLT UP UP UP
; STOP

.byte $1b,$24,$0c,$24,$0c,$15,$36,$0e,$36, $36,$1e,$36,$1e,$1c,$24,$1c,$24
.byte $04,$00

; Shape 2
; Sideways Portal
;    #*#*#*#*#*#*#
;  #*#           #*#
; *#       .       #*
;  #*#           #*#
;    #*#*#*#*#*#*#
; START
; NDN NDN NRT RT NRT RT NRT RT NRT UP 
; RT NRT UP UP LT NLT UP
; LT NLT LT NLT LT NLT LT NLT LT NLT LT NLT DN 
; LT NLT DN DN RT NRT DN
; RT NRT RT NRT RT
; STOP

.byte	$52,$0d,$0d,$0d,$6c,$24,$1f,$fc, $1f,$1f,$1f,$1f,$1f,$fe,$36,$0d
.byte	$6e,$0d,$05,$00

; Shape 3
; Chell Right
;
;   B B
; B ##
; B ###
; B ##
; B  O  ######
;  O O ##  ## 
;  O O .######
;  O O
;  O O
;  O O
; B  O
; B  O
; B  O O
; START
; NLT NLT DN DN DN DN DN DN RT NRT LT NLT NLT NLT NLT
; # FALL ARRESTOR BEGIN
; UP UP UP NRT UP UP UP UP UP NLT 
; # HAIR 
; UP UP UP UP NRT NRT RT NRT DN
; # FACE
; NLT LT DN RT RT DN NLT LT DN NRT DN RT NRT
; # GUN
; RT UP RT RT RT RT RT DN NLT LT LT NLT NLT NDN RT RT RT RT RT RT
; STOP

chell_right:
.byte	$1b,$36,$36,$36,$0d,$df,$1b,$24, $0c,$24,$24,$1c,$24,$64,$69,$1e
.byte	$37,$2d,$1e,$77,$6e,$25,$2d,$2d, $f5,$ff,$13,$2d,$2d,$2d,$00

; Shape 4
; Chell LEFT
;
; START
; NRT NRT DN DN DN DN DN DN LT NLT RT NRT NRT NRT NRT
; # FALL ARRESTOR BEGIN
; UP UP UP NLT UP UP UP UP UP NRT 
; # HAIR 
; UP UP UP UP NLT NLT LT NLT DN
; # FACE
; NRT RT DN LT LT DN NRT RT DN NLT DN LT NLT
; # GUN
; LT UP LT LT LT LT LT DN NRT RT RT NRT NRT NDN LT LT LT LT LT LT
; STOP

.byte	$09,$36,$36,$36,$1f,$4d,$09,$24, $1c,$24,$24,$0c,$24,$e4,$fb,$0e
.byte	$35,$3f,$0e,$f5,$fe,$27,$3f,$3f, $77,$6d,$11,$3f,$3f,$3f,$00

; Shape 5
; FireBall
; 
;     #
;    # #
;   # . #
;    # #
;     #
; START
; NDN NDN UP NRT UP NRT UP NLT UP NLT DN NLT DN NLT DN NRT DN NRT
; STOP

fireball:
.byte	$12,$0c,$0c,$1c,$1c,$1e,$1e,$0e, $0e,$00

; Shape 6
; Blue Core
;      #######
;     ##     ##
;    ## # # # ##
;    ## # . # ##
;    ## # # # ##
;     ##     ##
;      #######

; START
; # Inner
; NDN LT NLT UP UP RT NRT RT NRT DN DN LT NLT NDN NDN
; # Outer
; LT LT LT UP LT UP LT UP RT UP LT UP NRT RT UP RT RT RT RT RT RT DN
; # Upper Left
; RT DN RT DN LT DN RT DN NLT LT DN LT LT LT 
; STOP

blue_core:
.byte $fa,$24,$0d,$0d,$36,$9f,$3a,$3f, $3c,$3c,$2c,$3c,$0c,$25,$2d,$2d
.byte $2d,$2e,$2e,$3e,$2e,$1e,$37,$3f, $07,$00
