text_offset_table:
.byte word_already-word_table	;DIALOG_ALREADY		= $80
.byte word_cottage-word_table	;DIALOG_COTTAGE		= $81
.byte word_peasant-word_table	;DIALOG_PEASANT		= $82
.byte word_theres-word_table	;DIALOG_CAPITAL_THERES	= $83
.byte word_trogdor-word_table	;DIALOG_CAPITAL_TROGDOR	= $84

.byte word_little-word_table	;DIALOG_LITTLE		= $85
.byte word_youre-word_table	;DIALOG_YOURE		= $86
.byte word_Youre-word_table	;DIALOG_CAPITAL_YOURE	= $87

.byte word_about-word_table	;DIALOG_ABOUT		= $88
.byte word_cant-word_table	;DIALOG_CANT		= $89
.byte word_dont-word_table	;DIALOG_DONT		= $8A
.byte word_there-word_table	;DIALOG_THERE		= $8B
.byte word_There-word_table	;DIALOG_CAPITAL_THERE	= $8C

.byte word_baby-word_table	;DIALOG_BABY		= $8D
.byte word_dead-word_table	;DIALOG_DEAD		= $8E
.byte word_from-word_table	;DIALOG_FROM		= $8F
.byte word_have-word_table	;DIALOG_HAVE		= $90
.byte word_here-word_table	;DIALOG_HERE		= $91
.byte word_into-word_table	;DIALOG_INTO		= $92
.byte word_its-word_table	;DIALOG_ITS		= $93
.byte word_Its-word_table	;DIALOG_CAPITAL_ITS	= $94
.byte word_just-word_table	;DIALOG_JUST		= $95
.byte word_like-word_table	;DIALOG_LIKE		= $96
.byte word_says-word_table	;DIALOG_SAYS		= $97
.byte word_some-word_table	;DIALOG_SOME		= $98
.byte word_that-word_table	;DIALOG_THAT		= $99
.byte word_That-word_table	;DIALOG_CAPITAL_THAT	= $9A
.byte word_this-word_table	;DIALOG_THIS		= $9B
.byte word_with-word_table	;DIALOG_WITH		= $9C
.byte word_your-word_table	;DIALOG_YOUR		= $9D

.byte word_all-word_table	;DIALOG_ALL		= $9E
.byte word_and-word_table	;DIALOG_AND		= $9F
.byte word_are-word_table	;DIALOG_ARE		= $A0
.byte word_but-word_table	;DIALOG_BUT		= $A1
.byte word_for-word_table	;DIALOG_FOR		= $A2
.byte word_get-word_table	;DIALOG_GET		= $A3
.byte word_got-word_table	;DIALOG_GOT		= $A4
.byte word_him-word_table	;DIALOG_HIM		= $A5
.byte word_his-word_table	;DIALOG_HIS		= $A6
.byte word_not-word_table	;DIALOG_NOT		= $A7
.byte word_now-word_table	;DIALOG_NOW		= $A8
.byte word_old-word_table	;DIALOG_OLD		= $A9
.byte word_one-word_table	;DIALOG_ONE		= $AA
.byte word_out-word_table	;DIALOG_OUT		= $AB
.byte word_see-word_table	;DIALOG_SEE		= $AC
.byte word_the-word_table	;DIALOG_THE		= $AD
.byte word_The-word_table	;DIALOG_CAPITAL_THE	= $AE
.byte word_was-word_table	;DIALOG_WAS		= $AF
.byte word_you-word_table	;DIALOG_YOU		= $B0
.byte word_You-word_table	;DIALOG_CAPITAL_YOU	= $B1

.byte word_an-word_table	;DIALOG_AN		= $B2
.byte word_at-word_table	;DIALOG_AT		= $B3
.byte word_be-word_table	;DIALOG_BE		= $B4
.byte word_do-word_table	;DIALOG_DO		= $B5
.byte word_go-word_table	;DIALOG_GO		= $B6
.byte word_he-word_table	;DIALOG_HE		= $B7
.byte word_He-word_table	;DIALOG_CAPITAL_HE	= $B8
.byte word_in-word_table	;DIALOG_IN		= $B9
.byte word_is-word_table	;DIALOG_IS		= $BA
.byte word_it-word_table	;DIALOG_IT		= $BB
.byte word_It-word_table	;DIALOG_CAPITAL_IT	= $BC
.byte word_my-word_table	;DIALOG_MY		= $BD
.byte word_no-word_table	;DIALOG_NO		= $BE
.byte word_No-word_table	;DIALOG_CAPITAL_NO	= $BF
.byte word_of-word_table	;DIALOG_OF		= $C0
.byte word_on-word_table	;DIALOG_ON		= $C1
.byte word_or-word_table	;DIALOG_OR		= $C2
.byte word_so-word_table	;DIALOG_SO		= $C3
.byte word_to-word_table	;DIALOG_TO		= $C4
.byte word_up-word_table	;DIALOG_UP		= $C5


word_table:
word_already:	.byte "alread",'y'|$80
word_cottage:	.byte "cottag",'e'|$80
word_peasant:	.byte "peasan",'t'|$80
word_theres:	.byte "There'",'s'|$80
word_trogdor:	.byte "Trogdo",'r'|$80
word_little:	.byte "littl",'e'|$80
word_youre:	.byte "you'r",'e'|$80
word_Youre:	.byte "You'r",'e'|$80
word_about:	.byte "abou",'t'|$80
word_cant:	.byte "can'",'t'|$80
word_dont:	.byte "don'",'t'|$80
word_there:	.byte "ther",'e'|$80
word_There:	.byte "Ther",'e'|$80
word_baby:	.byte "bab",'y'|$80
word_dead:	.byte "dea",'d'|$80
word_from:	.byte "fro",'m'|$80
word_have:	.byte "hav",'e'|$80
word_here:	.byte "her",'e'|$80
word_into:	.byte "int",'o'|$80
word_its:	.byte "it'",'s'|$80
word_Its:	.byte "It'",'s'|$80
word_just:	.byte "jus",'t'|$80
word_like:	.byte "lik",'e'|$80
word_says:	.byte "say",'s'|$80
word_some:	.byte "som",'e'|$80
word_that:	.byte "tha",'t'|$80
word_That:	.byte "Tha",'t'|$80
word_this:	.byte "thi",'s'|$80
word_with:	.byte "wit",'h'|$80
word_your:	.byte "you",'r'|$80
word_all:	.byte "al",'l'|$80
word_and:	.byte "an",'d'|$80
word_are:	.byte "ar",'e'|$80
word_but:	.byte "bu",'t'|$80
word_for:	.byte "fo",'r'|$80
word_get:	.byte "ge",'t'|$80
word_got:	.byte "go",'t'|$80
word_him:	.byte "hi",'m'|$80
word_his:	.byte "hi",'s'|$80
word_not:	.byte "no",'t'|$80
word_now:	.byte "no",'w'|$80
word_old:	.byte "ol",'d'|$80
word_one:	.byte "on",'e'|$80
word_out:	.byte "ou",'t'|$80
word_see:	.byte "se",'e'|$80
word_the:	.byte "th",'e'|$80
word_The:	.byte "Th",'e'|$80
word_was:	.byte "wa",'s'|$80
word_you:	.byte "yo",'u'|$80
word_You:	.byte "Yo",'u'|$80
word_an:	.byte "a",'n'|$80
word_at:	.byte "a",'t'|$80
word_be:	.byte "b",'e'|$80
word_do:	.byte "d",'o'|$80
word_go:	.byte "g",'o'|$80
word_he:	.byte "h",'e'|$80
word_He:	.byte "H",'e'|$80
word_in:	.byte "i",'n'|$80
word_is:	.byte "i",'s'|$80
word_it:	.byte "i",'t'|$80
word_It:	.byte "I",'t'|$80
word_my:	.byte "m",'y'|$80
word_no:	.byte "n",'o'|$80
word_No:	.byte "N",'o'|$80
word_of:	.byte "o",'f'|$80
word_on:	.byte "o",'n'|$80
word_or:	.byte "o",'r'|$80
word_so:	.byte "s",'o'|$80
word_to:	.byte "t",'o'|$80
word_up:	.byte "u",'p'|$80

