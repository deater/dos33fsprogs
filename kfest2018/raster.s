; Kansasfest HackFest Entry


TEXT    EQU $FB36			;; Set text mode
HOME    EQU $FC58                       ;; Clear the text screen


	;===================
	; init screen

	jsr     TEXT
	jsr     HOME


