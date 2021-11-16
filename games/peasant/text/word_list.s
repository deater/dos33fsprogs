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
.byte word_looks-word_table	;DIALOG_LOOKS		= $8B
.byte word_there-word_table	;DIALOG_THERE		= $8C
.byte word_those-word_table	;DIALOG_THOSE		= $8D
.byte word_There-word_table	;DIALOG_CAPITAL_THERE	= $8E

.byte word_baby-word_table	;DIALOG_BABY		= $8F
.byte word_dead-word_table	;DIALOG_DEAD		= $90
.byte word_from-word_table	;DIALOG_FROM		= $91
.byte word_game-word_table	;DIALOG_GAME		= $92
.byte word_good-word_table	;DIALOG_GOOD		= $93
.byte word_have-word_table	;DIALOG_HAVE		= $94
.byte word_here-word_table	;DIALOG_HERE		= $95
.byte word_into-word_table	;DIALOG_INTO		= $96
.byte word_its-word_table	;DIALOG_ITS		= $97
.byte word_Its-word_table	;DIALOG_CAPITAL_ITS	= $98
.byte word_just-word_table	;DIALOG_JUST		= $99
.byte word_like-word_table	;DIALOG_LIKE		= $9A
.byte word_over-word_table	;DIALOG_OVER		= $9B
.byte word_says-word_table	;DIALOG_SAYS		= $9C
.byte word_some-word_table	;DIALOG_SOME		= $9D
.byte word_that-word_table	;DIALOG_THAT		= $9E
.byte word_That-word_table	;DIALOG_CAPITAL_THAT	= $9F
.byte word_this-word_table	;DIALOG_THIS		= $A0
.byte word_with-word_table	;DIALOG_WITH		= $A1
.byte word_your-word_table	;DIALOG_YOUR		= $A2

.byte word_all-word_table	;DIALOG_ALL		= $A3
.byte word_and-word_table	;DIALOG_AND		= $A4
.byte word_are-word_table	;DIALOG_ARE		= $A5
.byte word_but-word_table	;DIALOG_BUT		= $A6
.byte word_for-word_table	;DIALOG_FOR		= $A7
.byte word_get-word_table	;DIALOG_GET		= $A8
.byte word_got-word_table	;DIALOG_GOT		= $A9
.byte word_him-word_table	;DIALOG_HIM		= $AA
.byte word_his-word_table	;DIALOG_HIS		= $AB
.byte word_not-word_table	;DIALOG_NOT		= $AC
.byte word_now-word_table	;DIALOG_NOW		= $AD
.byte word_old-word_table	;DIALOG_OLD		= $AE
.byte word_one-word_table	;DIALOG_ONE		= $AF
.byte word_out-word_table	;DIALOG_OUT		= $B0
.byte word_see-word_table	;DIALOG_SEE		= $B1
.byte word_the-word_table	;DIALOG_THE		= $B2
.byte word_The-word_table	;DIALOG_CAPITAL_THE	= $B3
.byte word_was-word_table	;DIALOG_WAS		= $B4
.byte word_you-word_table	;DIALOG_YOU		= $B5
.byte word_You-word_table	;DIALOG_CAPITAL_YOU	= $B6

.byte word_an-word_table	;DIALOG_AN		= $B7
.byte word_at-word_table	;DIALOG_AT		= $B8
.byte word_be-word_table	;DIALOG_BE		= $B9
.byte word_do-word_table	;DIALOG_DO		= $BA
.byte word_go-word_table	;DIALOG_GO		= $BB
.byte word_he-word_table	;DIALOG_HE		= $BC
.byte word_He-word_table	;DIALOG_CAPITAL_HE	= $BD
.byte word_in-word_table	;DIALOG_IN		= $BE
.byte word_is-word_table	;DIALOG_IS		= $BF
.byte word_it-word_table	;DIALOG_IT		= $C0
.byte word_It-word_table	;DIALOG_CAPITAL_IT	= $C1
.byte word_my-word_table	;DIALOG_MY		= $C2
.byte word_no-word_table	;DIALOG_NO		= $C3
.byte word_No-word_table	;DIALOG_CAPITAL_NO	= $C4
.byte word_of-word_table	;DIALOG_OF		= $C5
.byte word_on-word_table	;DIALOG_ON		= $C6
.byte word_or-word_table	;DIALOG_OR		= $C7
.byte word_so-word_table	;DIALOG_SO		= $C8
.byte word_to-word_table	;DIALOG_TO		= $C9
.byte word_up-word_table	;DIALOG_UP		= $CA

word_table:
word_already:	.byte "alread",'y'|$80
word_cottage:	.byte "cottag",'e'|$80
word_peasant:	.byte "peasan",'t'|$80
word_theres:	.byte "There'",'s'|$80
word_trogdor:	.byte "Trogdo",'r'|$80
word_little:	.byte "littl",'e'|$80
word_youre:	.byte "you'r",'e'|$80
word_Youre:	.byte "You'r",'e'|$80
word_about:	.byte "ab"
word_out:	.byte "ou",'t'|$80
word_cant:	.byte "can'",'t'|$80
word_dont:	.byte "don'",'t'|$80
word_looks:	.byte "look",'s'|$80
word_there:	.byte "t"
word_here:	.byte "her",'e'|$80
word_There:	.byte "Ther",'e'|$80
word_those:	.byte "thos",'e'|$80
word_baby:	.byte "bab",'y'|$80
word_dead:	.byte "dea",'d'|$80
word_from:	.byte "fro",'m'|$80
word_game:	.byte "gam",'e'|$80
word_good:	.byte "goo",'d'|$80
word_have:	.byte "hav",'e'|$80
word_into:	.byte "in"
word_to:	.byte "t",'o'|$80
word_its:	.byte "it'",'s'|$80
word_Its:	.byte "It'",'s'|$80
word_just:	.byte "jus",'t'|$80
word_like:	.byte "lik",'e'|$80
word_over:	.byte "ove",'r'|$80
word_says:	.byte "say",'s'|$80
word_some:	.byte "som",'e'|$80
word_that:	.byte "th"
word_at:	.byte "a",'t'|$80
word_That:	.byte "Tha",'t'|$80
word_this:	.byte "th"
word_is:	.byte "i",'s'|$80
word_with:	.byte "wit",'h'|$80
word_your:	.byte "you",'r'|$80
word_all:	.byte "al",'l'|$80
word_and:	.byte "an",'d'|$80
word_are:	.byte "ar",'e'|$80
word_but:	.byte "bu",'t'|$80
word_for:	.byte "f"
word_or:	.byte "o",'r'|$80
word_get:	.byte "ge",'t'|$80
word_got:	.byte "go",'t'|$80
word_him:	.byte "hi",'m'|$80
word_his:	.byte "hi",'s'|$80
word_not:	.byte "no",'t'|$80
word_now:	.byte "no",'w'|$80
word_old:	.byte "ol",'d'|$80
word_one:	.byte "on",'e'|$80
word_see:	.byte "se",'e'|$80
word_the:	.byte "t"
word_he:	.byte "h",'e'|$80
word_The:	.byte "Th",'e'|$80
word_was:	.byte "wa",'s'|$80
word_you:	.byte "yo",'u'|$80
word_You:	.byte "Yo",'u'|$80
word_an:	.byte "a",'n'|$80
word_be:	.byte "b",'e'|$80
word_do:	.byte "d",'o'|$80
word_go:	.byte "g",'o'|$80
word_He:	.byte "H",'e'|$80
word_in:	.byte "i",'n'|$80
word_it:	.byte "i",'t'|$80
word_It:	.byte "I",'t'|$80
word_my:	.byte "m",'y'|$80
word_no:	.byte "n",'o'|$80
word_No:	.byte "N",'o'|$80
word_of:	.byte "o",'f'|$80
word_on:	.byte "o",'n'|$80
word_so:	.byte "s",'o'|$80
word_up:	.byte "u",'p'|$80

