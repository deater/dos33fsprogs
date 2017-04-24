/* asoft_detoken: detokenize an applesoft BASIC program */
/* by Vince Weaver (vince@deater.net)			*/

#include <stdio.h>
#include <string.h> /* strlen() */
#include <unistd.h> /* getopt() */
#include "version.h"

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

int main(int argc, char **argv) {

	int ch1,i;
	int size1,size2;
	int line1,line2;
	int link1,link2,link;
	int debug=0,print_link=0;
	int offset=0x801;
	int c;
	FILE *fff;

	/* Check command line arguments */
	while ((c = getopt (argc, argv,"dl"))!=-1) {
		switch (c) {

		case 'd':
			debug=1;
			break;
		case 'l':
			print_link=1;
			break;
		}
        }

	/* No file specified, used stdin */
	if (optind==argc) {
		fff=stdin;
	}
	else {
		fff=fopen(argv[optind],"r");
		if (fff==NULL) {
			fprintf(stderr,"Error, could not open %s\n",argv[optind]);
			return -1;
		}

	}


	/* read size, first two bytes */
	size1=fgetc(fff);
	size2=fgetc(fff);

	if (debug) fprintf(stderr,"File size: %x %x\n",size1,size2);

	while(!feof(fff)) {

		/* link points to the next line */
		/* assumes asoft program starts at address $801 */
		link1=fgetc(fff);
		link2=fgetc(fff);
		link=(link2<<8)|link1;
		offset+=2;

		if (print_link) printf("%04X:",link);

		/* link==0 indicates EOF */
		if (link==0) goto the_end;

		/* line number is little endian 16-bit value */
		line1=fgetc(fff);
		line2=fgetc(fff);
		if (feof(fff)) goto the_end;
		printf("%4d ",((line2)<<8)+line1);
		offset+=2;

		/* repeat until EOL character (0) */
		while( (ch1=fgetc(fff))!=0 ) {
			offset++;
			/* if > 0x80 it's a token */
			if (ch1>=0x80) {
				fputc(' ',stdout);
				for(i=0;i<strlen(applesoft_tokens[ch1-0x80]);i++) {
					fputc(applesoft_tokens[ch1-0x80][i],stdout);
				}
				fputc(' ',stdout);
			}
			/* otherwise it is an ascii char */
			else {
				fputc(ch1,stdout);
			}
		}
		offset++;
		printf("\n");
		if (link!=offset) {
			fprintf(stderr,"WARNING! link!=offset %x %x\n",link,offset);
		}
	}
	the_end:;
	return 0;
}
