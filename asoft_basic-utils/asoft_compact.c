/* asoft_compact */
/* make applesoft code as compact as possible	*/
/* + Renumber lines to be as short as possible	*/
/* + Remove extraneous "LET" commands		*/
/* + Transform "THEN GOTO" to "THEN"		*/
/* + Make variables as short as possible	*/
/* + Remove REM statements			*/
/* + Combine lines right up to 255 char limit	*/

/* Example */
/* demo.bas  = 22,219 bytes */
/* tokenized = 17,407 bytes */
/* compacted =              */

#include <stdio.h>
#include <string.h>	/* strlen() */
#include <stdlib.h>

#include "version.h"

#define LOW(_x)  ((_x)&0xff)
#define HIGH(_x) (((_x)>>8)&0xff)


	/* Starting at 0x80 */
char applesoft_tokens[][8]={
/* 80 */ "END","FOR","NEXT","DATA","INPUT","DEL","DIM","READ",
/* 88 */ "GR","TEXT","PR #","IN #","CALL","PLOT","HLIN","VLIN",
/* 90 */ "HGR2","HGR","HCOLOR=","HPLOT","DRAW","XDRAW","HTAB","HOME",
/* 98 */ "ROT=","SCALE=","SHLOAD","TRACE","NOTRACE","NORMAL","INVERSE","FLASH",
/* A0 */ "COLOR=","POP","VTAB ","HIMEM:","LOMEM:","ONERR","RESUME","RECALL",
/* A8 */ "STORE","SPEED=","LET","GOTO","RUN","IF","RESTORE","&",
/* B0 */ "GOSUB","RETURN","REM","STOP","ON","WAIT","LOAD","SAVE",
/* B8 */ "DEF FN","POKE","PRINT","CONT","LIST","CLEAR","GET","NEW",
/* C0 */ "TAB","TO","FN","SPC(","THEN","AT","NOT","STEP",
/* C8 */ "+","-","*","/","^","AND","OR",">",
/* D0 */ "=","<","SGN","INT","ABS","USR","FRE","SCRN (",
/* D8 */ "PDL","POS","SQR","RND","LOG","EXP","COS","SIN",
/* E0 */ "TAN","ATN","PEEK","LEN","STR$","VAL","ASC","CHR$",
/* E8 */ "LEFT$","RIGHT$","MID$","","","","","",
/* F0 */ "","","","","","","","",
/* F8 */ "","","","","","(","(","("
};

#define TOKEN_END	0
#define TOKEN_FOR	1
#define TOKEN_NEXT	2
#define TOKEN_DATA	3
#define TOKEN_INPUT	4
#define TOKEN_DEL	5
#define TOKEN_DIM	6
#define TOKEN_READ	7
#define TOKEN_GR	8
#define TOKEN_TEXT	9
#define TOKEN_PR	10
#define TOKEN_IN	11
#define TOKEN_CALL	12
#define TOKEN_PLOT	13
#define TOKEN_HLIN	14
#define TOKEN_VLIN	15
#define TOKEN_HGR2	16
#define TOKEN_HGR	17
#define TOKEN_HCOLOR	18
#define TOKEN_HPLOT	19
#define TOKEN_DRAW	20
#define TOKEN_XDRAW	21
#define TOKEN_HTAB	22
#define TOKEN_HOME	23
#define TOKEN_ROT	24
#define TOKEN_SCALE	25
#define TOKEN_SHLOAD	26
#define TOKEN_TRACE	27
#define TOKEN_NOTRACE	28
#define TOKEN_NORMAL	29
#define TOKEN_INVERSE	30
#define TOKEN_FLASH	31
#define TOKEN_COLOR	32
#define TOKEN_POP	33
#define TOKEN_VTAB	34
#define TOKEN_HIMEM	35
#define TOKEN_LOMEM	36
#define TOKEN_ONERR	37
#define TOKEN_RESUME	38
#define TOKEN_RECALL	39
#define TOKEN_STORE	40
#define TOKEN_SPEED	41
#define TOKEN_LET	42
#define TOKEN_GOTO	43
#define TOKEN_RUN	44
#define TOKEN_IF	45
#define TOKEN_RESTORE	46
#define TOKEN_AMP	47
#define TOKEN_GOSUB	48
#define TOKEN_RETURN	49
#define TOKEN_REM	50
#define TOKEN_STOP	51
#define TOKEN_ON	52
#define TOKEN_WAIT	53
#define TOKEN_LOAD	54
#define TOKEN_SAVE	55
#define TOKEN_DEFFN	56
#define TOKEN_POKE	57
#define TOKEN_PRINT	58
#define TOKEN_CONT	59
#define TOKEN_LIST	60
#define TOKEN_CLEAR	61
#define TOKEN_GET	62
#define TOKEN_NEW	63
#define TOKEN_TAB	64
#define TOKEN_TO	65
#define TOKEN_FN	66
#define TOKEN_SPC	67
#define TOKEN_THEN	68
#define TOKEN_AT	69
#define TOKEN_NO	70
#define TOKEN_STEP	71
#if 0
/* C8 */ "+","-","*","/","^","AND","OR",">",
/* D0 */ "=","<","SGN","INT","ABS","USR","FRE","SCRN (",
/* D8 */ "PDL","POS","SQR","RND","LOG","EXP","COS","SIN",
/* E0 */ "TAN","ATN","PEEK","LEN","STR$","VAL","ASC","CHR$",
/* E8 */ "LEFT$","RIGHT$","MID$","","","","","",
#endif

static void color_red(void) {
	fprintf(stderr,"%c[1;31;40m",27);
}

static void color_green(void) {
	fprintf(stderr,"%c[1;32;40m",27);
}

static void color_cyan(void) {
	fprintf(stderr,"%c[1;36;40m",27);
}

static void color_yellow(void) {
	fprintf(stderr,"%c[1;33;40m",27);
}

static void color_normal(void) {
	fprintf(stderr,"%c[0m",27);
}

static int linenums[65536];	/* lazy */
static int output[65536];


static void print_int(int value, int *offset) {

	unsigned char buffer[16];
	int pointer=15;
	int r,q;

	q=value;

	while(1) {
		r=q%10;
		q/=10;

		buffer[pointer]=r+'0';

		if (q==0) break;

		pointer--;
	}

	while(pointer<16) {
		output[*offset]=buffer[pointer];
		pointer++;
		(*offset)++;
	}
}

int main(int argc, char **argv) {

	int ch1;
	int size1,size2;
	int line1,line2;
	int link1,link2,link;
	int debug=1;
	int token,last_token=0;
	int line_no=0;
	int i;
	FILE *fff;

	int offset,link_offset;

	if (argc<2) {
		fprintf(stderr,"Usage: %s FILENAME -1 -2 -3 -4\n",argv[0]);
 		exit(1);
	}

	fff=fopen(argv[1],"r");
	if (fff==NULL) {
		fprintf(stderr,"Error opening %s\n",argv[1]);
		exit(1);
	}

	/* read size, first two bytes */
	size1=fgetc(fff);
	size2=fgetc(fff);

	if (debug) fprintf(stderr,"File size: %x %x\n",size1,size2);

	while(!feof(fff)) {

		/* link points to the next line */
		link1=fgetc(fff);
		link2=fgetc(fff);
		link=(link1<<8)|link2;
		/* link==0 indicates EOF */
		if (link==0) goto the_end;

		/* line number is little endian 16-bit value */
		line1=fgetc(fff);
		line2=fgetc(fff);
		if (feof(fff)) goto the_end;

		color_red();
		fprintf(stderr,"%4d ",((line2)<<8)+line1);
		color_normal();

		/* repeat until EOL character (0) */
		while(1) {

			ch1=fgetc(fff);
after_read:
			if (ch1==0) break;
			/* if > 0x80 it's a token */
			if (ch1>=0x80) {
				color_green();
				fprintf(stderr,"%s",applesoft_tokens[ch1-0x80]);
				color_normal();
				last_token=ch1&0x7f;
			}
			/* otherwise it is an ascii char */
			else {
				if (ch1<0x20) {
					color_cyan();
					fprintf(stderr,"%d",ch1);
					color_normal();
				}

				if ((ch1>='0') && (ch1<='9')) {
					if ((last_token==TOKEN_GOTO) ||
						(last_token==TOKEN_GOSUB) ||
						(last_token==TOKEN_THEN)) {

						line_no=ch1-'0';

						while(1) {
							ch1=fgetc(fff);
							if ((ch1<'0') || (ch1>'9')) break;
							line_no*=10;
							line_no+=(ch1-'0');
						}
						color_yellow();
						fprintf(stderr,"%d",line_no);
						color_normal();
						linenums[line_no]++;
						goto after_read;
					}
				}
				fputc(ch1,stderr);
			}
		}
		fprintf(stderr,"\n");
	}
the_end:;

	fprintf(stderr,"Used Line Numbers:\n");
	for(i=0;i<65536;i++) {
		if(linenums[i]) fprintf(stderr,"\t%d\t%d\n",i,linenums[i]);
	}

	rewind(fff);

	/*********************/
	/* Create new output */
	/*********************/

	/* skip size bytes */
	offset=2;
	size1=fgetc(fff);
	size2=fgetc(fff);

	while(!feof(fff)) {

		link_offset=offset;

		link1=fgetc(fff);
		link2=fgetc(fff);
		link=(link1<<8)|link2;

		output[offset]=link1;
		output[offset+1]=link2;

		/* link==0 indicates end */
		if (link==0) break;
		offset+=2;

		/* line number is little endian 16-bit value */

		// line_offset=offset;

		line1=fgetc(fff);
		line2=fgetc(fff);

		output[offset]=line1;
		output[offset+1]=line2;

		offset+=2;

		if (feof(fff)) break;

		/* repeat until EOL character (0) */
		while(1) {

			ch1=fgetc(fff);
after_read2:
			if (ch1==0) break;

			/* if > 0x80 it's a token */
			if (ch1>=0x80) {
				token=ch1&0x7f;

				if (token==TOKEN_LET) {
					/* Skip superfluous LET */
				}
				else if ((token==TOKEN_GOTO) && (last_token==TOKEN_THEN)) {
					/* Skip superfluous GOTO if THEN GOTO */
				}
				else {
					output[offset]=ch1;
					offset++;
				}
				last_token=token;
			}
			/* otherwise it is an ascii char */
			else {

				if ((ch1>='0') && (ch1<='9')) {
					if ((last_token==TOKEN_GOTO) ||
						(last_token==TOKEN_GOSUB) ||
						(last_token==TOKEN_THEN)) {

						line_no=ch1-'0';

						while(1) {
							ch1=fgetc(fff);
							if ((ch1<'0') || (ch1>'9')) break;
							line_no*=10;
							line_no+=(ch1-'0');
						}
						print_int(line_no,&offset);

						goto after_read2;
					}
				}

				output[offset]=ch1;
				offset++;
			}

		}
		output[offset]=0;
		offset++;

		output[link_offset]=LOW(offset+0x7ff);
		output[link_offset+1]=HIGH(offset+0x7ff);

	}

	/* write out our program */

	/* set last link field to $00 $00 which indicates EOF */
	output[offset]='\0';
	output[offset+1]='\0';
	offset+=2;

	/* Set filesize */
	/* -1 to match observed values */
	output[0]=LOW(offset-1);
	output[1]=HIGH(offset-1);
	/* output our file */
	for(i=0;i<offset;i++) putchar(output[i]);

	return 0;
}
