// http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng
int random_8(void) {

	static int seed=0x1f;
	static int newseed;

	newseed=seed;					// lda seed
	if (newseed==0) goto doEor;			// beq doEor
	newseed<<=1;					// asl
	if (newseed==0) goto noEor;			//beq noEor
					// if the input was $80, skip the EOR
	if (!(newseed&0x100)) goto noEor;		// bcc noEor
doEor:
	newseed^=0x1d;					// eor #$1d
noEor:
	seed=(newseed&0xff);				// sta seed
	return seed;
}

