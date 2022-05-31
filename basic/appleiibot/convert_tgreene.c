/* Based on code by qkumba */
/* TGreene improved the algorithm to be a bit smaller */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

/* ASCII offset */
#define OFFSET	35
#define OFFSET2	35

/* We are jumping into the decoded code using the & operator */
/* This just does a jmp to $3F5 */
/* Easiest is to just load our code there */
/* The problem is this loads most of the code to the 1st text/lo-res page */
/* For text/lo-res programs instead load code so it ends at $3F8, */
/*    usually you have a 3-byte jmp to the start of your code at $3F5 */

#define END_AT_3F5	0
#define BEGIN_AT_3F5	1

static int print_help(char *name) {

	printf("\n");
	printf("Usage: %s [-e] [-h]\n",name);
	printf("\t-e : ends program at 3F5 (useful for lo-res programs)\n");
	printf("\t     default is to start program at 3F5\n");
	printf("\n");

	return 0;
}

int main(int argc, char **argv) {

	int mode=BEGIN_AT_3F5;
	int i = 0;
	int e = 0,filesize;
	int val,pv,final;
	unsigned char in[1024];
	unsigned char enc[1024],enc2[1024];
	int third,enc_ptr=0;
	int filesize_digits;

	if (argc>1) {
		if (argv[1][0]=='-') {
			if (argv[1][1]=='e') {
				mode=END_AT_3F5;
			}
			if (argv[1][1]=='h') {
				print_help(argv[0]);
				exit(1);
			}
		}
	}

//	printf("1REM");

	filesize=read(0,in,1024);
	do {
		third = ((in[i + 2] & 3) << 4) +
			((in[i + 1] & 3) << 2) + (in[i + 0] & 3);
		enc[e++]=third+OFFSET2;
		if (i<filesize) {
			val=in[i+0];
			pv=val;
			val=val+0x40;
			val-=third;
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+third-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i,pv,val,third,final);
			if (pv!=final) fprintf(stderr,"error0: no match!\n");
			if (val<0) fprintf(stderr,"error0, negative! in=%x e=%x val=%x\n",
				in[i+0],third,val);
			if (val<0x20) fprintf(stderr,"error0, unprintable! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
			if (val>0x7e) fprintf(stderr,"error0, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
			if (val=='\"') fprintf(stderr,"error0, additional quotation marks\n");
//			printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			//printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 1 < filesize) {
			val=in[i+1];
			pv=val;
			val=val+0x40;
			val-=(third>>2);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>2)-0x40;

			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+1,pv,val,third>>2,final);
			if (pv!=final) fprintf(stderr,"error1: no match!\n");
			if (val<0) fprintf(stderr,"error1, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error1, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error1, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val); //(in[i + 1] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 2 < filesize) {
			val=in[i+2];
			pv=val;
			val=val+0x40;
			val-=(third>>4);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>4)-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+2,pv,val,third>>4,final);
			if (pv!=final) fprintf(stderr,"error2: no match!\n");
			if (val<0) fprintf(stderr,"error2, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error2, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error2 too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val);//(in[i + 2] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
	} while ((i += 3) < filesize);
	enc[e]=0;
	enc2[enc_ptr]=0;

// from Tom Greene @txgx42
// $850 = 2128
// with call
#if 0
	printf("1FORI=0TO%d:POKE768+I,4*PEEK(%d+I)-"
		"192+(PEEK(%d+I/3)-%d)/4^(I-INT(I/3)*3):NEXT\n",
		filesize-1,2128,2128+filesize,OFFSET2);
	printf("2CALL768\"%s%s\n",enc2,enc);
#endif

	if ((filesize-1)<10) filesize_digits=1;
	else if ((filesize-1)<100) filesize_digits=2;
	else filesize_digits=3;

	if (mode==END_AT_3F5) {
		fprintf(stderr,"Ending at $3F5\n");
		printf("1FORI=0TO%d:POKE%d+I,4*PEEK(%d+I)-"
			"%d+(PEEK(%d+I/3)-%d)/4^(I-INT(I/3)*3):NEXT\n",
			filesize-1,			// filesize for loop
			0x3f5-filesize+3,		// destination
			2122+filesize_digits,		// read from 6
			64+4*OFFSET,			// ??
			2122+filesize+filesize_digits, // read from 2
			OFFSET2);
		printf("2&\"%s%s\n",enc2,enc);
	}


	// if using & to jump to beginning (over-writing text page)
	if (mode==BEGIN_AT_3F5) {
		fprintf(stderr,"Beginning at $3F5\n");
		printf("1FORI=0TO%d:POKE%d+I,4*PEEK(%d+I)-"
			"%d+(PEEK(%d+I/3)-%d)/4^(I-INT(I/3)*3):NEXT\n",
			filesize-1,			// filesize for loop
			0x3f5,				// destination
			2123+filesize_digits,		// read from 6
			4*OFFSET+64,			// ?
			2123+filesize+filesize_digits,	// read from 2
			OFFSET2);
		printf("2&\"%s%s\n",enc2,enc);
	}

//	printf("%s\n",enc);
//	printf("2FORI=0TO%d:POKE768+I,4*PEEK(2054+I)-"
//		"192+(PEEK(%d+I/3)-32)/4^(I-INT(I/3)*3):NEXT:CALL768\n",
//		filesize,2054+filesize);



//	printf("2FORI=0TO%d:C=(PEEK(%d+I/3)-32)/4^(I-INT(I/3)*3):POKE768+I,C+4*(PEEK(2054+I)-32-INT(C/4)):NEXT:CALL768\n",
//		filesize,2054+filesize);

// note, peek/poke truncate?
//2FORI=1013TO1141:C=(PEEK(1843+I/3)-32)/4^(I-INT(I/3)*3):POKEI,C+4*(PEEK(1041+I)-32-INT(C/4)):NEXT:&



	return 0;
}
