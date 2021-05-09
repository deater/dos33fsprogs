island_flying_directions:
        .byte   $2,$00          ; 2 frames, do nothing
        .byte   $1,'Z'          ; start moving forward
        .byte   $10,$00         ; 16 frames, do nothing
        .byte   $3,'D'          ; 3 frames, turn right
        .byte   $1,'Z'          ; move faster
        .byte   $8,$00          ; 8 frames, do nothing
        .byte   $2,'D'          ; 2 frames, turn left
        .byte   $8,$00          ; 8 frames, do nothing
        .byte   $3,'A'          ; 3 frames, turn left
        .byte   $1,'Z'          ; speedup
        .byte   $8,$00          ; 8 frames, do nothing
        .byte   $6,'S'          ; 6 frames down
        .byte   $6,$00          ; 6 frames do nothing
        .byte   $3,'A'          ; 3 frames left
        .byte   $3,'D'          ; 3 frames right
        .byte   $2,$00          ; 2 frames nothing
        .byte   $1,'D'          ; 1 frame right
        .byte   $2,$00          ; 2 frames nothing
        .byte   $8,'D'          ; 8 frame right
        .byte   $1,'Z'          ; 8 frames up
        .byte   $6,'W'          ; 2 speedup
	.byte   $a,$00          ; 10 nothing
        .byte   $3,'S'          ; 3 down
        .byte   $1,'Q'          ; quit
