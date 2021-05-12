island_flying_directions:
        .byte   15,$00          ; 2 frames, do nothing
        .byte    1,'Z'          ; start moving forward
        .byte    8,$00          ; 2 frames, do nothing
        .byte    3,'A'          ; 3 frames left
        .byte   15,$00          ; 8 frames, do nothing
        .byte    1,'Z'          ; start moving forward
        .byte    2,'A'          ; 3 frames left
        .byte   15,$00          ; 8 frames, do nothing
        .byte    3,'A'          ; 3 frames, turn left
        .byte    1,'Z'          ; move faster
        .byte   15,$00          ; 8 frames, do nothing
        .byte    2,'D'          ; 2 frames, turn left
        .byte   15,$00          ; 8 frames, do nothing
        .byte    2,'A'          ; 2 frames, turn left
        .byte    1,'Z'          ; speedup
        .byte   15,$00          ; 8 frames, do nothing
        .byte    2,'W'          ; 2 frames UP
        .byte    8,$00          ; 6 frames do nothing
        .byte    3,'A'          ; 3 frames left
        .byte    5,$00          ; 5 frames nothing
        .byte    8,'D'          ; 8 frame right
        .byte    1,'Z'          ; 8 frames up
        .byte    6,'W'          ; 2 speedup
	.byte   20,$00          ; 10 nothing
        .byte    5,'S'          ; 5 down
        .byte    1,'Q'          ; quit
