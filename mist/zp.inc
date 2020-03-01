;; Zero Page

;; LZ4 addresses

LZ4_SRC		= $00
LZ4_DST		= $02
LZ4_END		= $04
WHICH_LOAD	= $05
COUNT		= $06
MENU_BASE	= $06
MENU_HIGHLIGHT	= $07
DELTA		= $08


;; Zero page monitor routines addresses

WNDLFT	= $20
WNDWDTH	= $21
WNDTOP	= $22
WNDBTM	= $23
CH	= $24
CV	= $25
GBASL	= $26
GBASH	= $27
BASL	= $28
BASH	= $29
H2	= $2C
V2	= $2D
MASK	= $2E
COLOR_MASK = $2F
COLOR	= $30


SEEDL	= $4e
SEEDH	= $4f
XMAX	= $50

FRAMEL	= $60
FRAMEH	= $61
CURSOR_X= $62
CURSOR_Y= $63
XPOS	= $64
YPOS	= $65
DIRECTION = $66
	DIRECTION_N = $0
	DIRECTION_S = $1
	DIRECTION_E = $2
	DIRECTION_W = $3
LOCATION = $67
LOCATION_STRUCT_L = $68
LOCATION_STRUCT_H = $69
IN_SPECIAL	=	$6A
CURSOR_VISIBLE	=	$6B
IN_LEFT		=	$6C
IN_RIGHT	=	$6D

DISP_PAGE	=	$ED	; ALL
DRAW_PAGE	=	$EE	; ALL


TINL		=	$F0
TINH		=	$F1
BINL		=	$F2
BINH		=	$F3


SCROLL_COUNT	=	$F9
TEMP		=	$FA
TEMPY		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF

; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca64 -- vmw
; added code to patch it to run from current disk slot -- vmw


        adrlo   =       $26     ; constant from boot prom
        adrhi   =       $27     ; constant from boot prom
        tmpsec  =       $3c     ; constant from boot prom
        reqsec  =       $3d     ; constant from boot prom
        sizelo  =       $44
        sizehi  =       $45
        secsize =       $46

        ldsizel =       $70
        ldsizeh =       $71
        namlo   =       $7b
        namhi   =       $7c
        step    =       $7d     ; state for stepper motor
        tmptrk  =       $7e     ; temporary copy of current track
        phase   =       $7f     ; current phase for /seek

