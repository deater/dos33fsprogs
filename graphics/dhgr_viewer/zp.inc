;; Zero Page


;; ZX0 addresses

ZX0_src         = $00
ZX0_dst         = $02
offset          = $04
bitr            = $06
pntr            = $07
WHICH_LOAD      = $09
CURRENT_DISK    = $0A

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
COLOR	= $30
			;INVFLG	= $32

; dos33 zero page = 26-2f, 35-38, 3e 3f 40-4d 
; overlap applesoft  67-6a,6f,70,af,b0,ca-cd,d8 


; DOS33: Confirmed kills $68

RWTSL		= $60
RWTSH		= $61
DOSBUFL		= $62
DOSBUFH		= $63
FILEML		= $64
FILEMH		= $65


FRAME           = $60
FRAMEH		= $61
WAITING         = $62
LETTERL         = $63
LETTERH         = $64
LETTERX         = $65
LETTERY         = $66
LETTERD         = $67
LETTER          = $68
BLARGH          = $69

				;FACTOR_I	= $66
				;FACTOR_F	= $67
				;DX_I		= $68
				;DX_F		= $69
				;SPACEX_I	= $6A
				;SPACEX_F	= $6B
				;CX_I		= $6C
				;CX_F		= $6D
				;DY_I		= $6E
				;DY_F		= $6F


ZPOS		= $78

REGISTER_DUMP	= $70
A_FINE_TONE	= $70
A_COARSE_TONE	= $71
B_FINE_TONE	= $72
B_COARSE_TONE	= $73
C_FINE_TONE	= $74
C_COARSE_TONE	= $75
NOISE		= $76
ENABLE		= $77
A_VOLUME	= $78
B_VOLUME	= $79
C_VOLUME	= $7A
ENVELOPE_FINE	= $7B
ENVELOPE_COARSE	= $7C
ENVELOPE_SHAPE  = $7D


COPY_OFFSET	= $7E
DECODER_STATE	= $7F


REGISTER_DUMP2	= $80
A_FINE_TONE2	= $80
A_COARSE_TONE2	= $81
B_FINE_TONE2	= $82
B_COARSE_TONE2	= $83
C_FINE_TONE2	= $84
C_COARSE_TONE2	= $85
NOISE2		= $86
ENABLE2		= $87
A_VOLUME2	= $88
B_VOLUME2	= $89
C_VOLUME2	= $8A
ENVELOPE_FINE2	= $8B
ENVELOPE_COARS2	= $8C
ENVELOPE_SHAPE2 = $8D
LYRICSL		= $8E
LYRICSH		= $8F

FRAME_COUNT	= $90
MB_VALUE	= $91
MB_ADDRL	= $91
MB_ADDRH	= $92
DONE_PLAYING	= $93
MB_CHUNK_OFFSET = $94
MB_FRAME	= $94
MB_PATTERN	= $95
CHUNKSIZE	= $95
LZ4_DONE	= $96
DECODE_ERROR	= $97
COPY_TIME	= $98
DECOMPRESS_TIME	= $99
TIME_TAKEN	= $9A
LYRICS_ACTIVE	= $9B
;FORTYCOL	= $9C
CURSOR		= $9D

; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

			;COLOR1		=	$E0
			;COLOR2		=	$E1
			;MATCH		=	$E2
XX	=	$E3
YY	=	$E4
HGR_COLOR       = $E4
			;SHIPY		=	$E4
			;YADD		=	$E5
			;LOOP		=	$E6
			;MEMPTRL	=	$E7
			;MEMPTRH	=	$E8
			;NAMEL		=	$E9
			;NAMEH		=	$EA
			;NAMEX		=	$EB
			;CHAR		=	$EC

INL		= $EE
INH		= $EF



OUTL		=	$FE
OUTH		=	$FF






; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assembled with ca64 -- vmw
; added code to patch it to run from current disk slot -- vmw


	adrlo	=	$26	; constant from boot prom
	adrhi	=	$27	; constant from boot prom
	tmpsec	=	$3c	; constant from boot prom
	reqsec	=	$3d	; constant from boot prom
	sizelo	=	$44
	sizehi	=	$45
	secsize	=	$46

	ldsizel	=	$f0
	ldsizeh	=	$f1
	namlo	=	$fb
	namhi	=	$fc
	step	=	$fd	; state for stepper motor
	tmptrk	=	$fe	; temporary copy of current track
	phase	=	$ff	; current phase for /seek

