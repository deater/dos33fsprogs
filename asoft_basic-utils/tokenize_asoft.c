/* tokenize_asoft: Tokenize an Applesoft BASIC program	*/
/* by Vince Weaver <vince@deater.net>			*/

#include <stdio.h>
#include <string.h> /* strlen() */
#include <stdlib.h> /* exit() */
#include <unistd.h> /* getopt() */

#include "version.h"

static int debug=0;

/* TODO */
/* match lowercase tokens as well as upper case ones */

/* Info from http://docs.info.apple.com/article.html?coll=ap&artnum=57 */

/* In memory, applesoft file starts at address $801			*/
/* format is <LINE><LINE><LINE>$00$00					*/
/* Where <LINE> is:							*/
/*    2 bytes (little endian) of LINK indicating addy of next line	*/
/*    2 bytes (little endian) giving the line number			*/
/*    a series of bytes either ASCII or tokens (see below)		*/
/*    a $0 char indicating end of line					*/

#define NUM_TOKENS 107

   /* Starting at 0x80 */
char applesoft_tokens[][8]={

/* 80 */ "END","FOR","NEXT","DATA","INPUT","DEL","DIM","READ",
/* 88 */ "GR","TEXT","PR #","IN #","CALL","PLOT","HLIN","VLIN",
/* 90 */ "HGR2","HGR","HCOLOR=","HPLOT","DRAW","XDRAW","HTAB","HOME",
/* 98 */ "ROT=","SCALE=","SHLOAD","TRACE","NOTRACE","NORMAL","INVERSE","FLASH",
/* A0 */ "COLOR=","POP","VTAB ","HIMEM:","LOMEM:","ONERR","RESUME","RECALL",
/* A8 */ "STORE","SPEED=","LET","GOTO","RUN","IF","RESTORE","&",
/* B0 */ "GOSUB","RETURN","REM","STOP","ON","WAIT","LOAD","SAVE",
/* B8 */ "DEF","POKE","PRINT","CONT","LIST","CLEAR","GET","NEW",
/* C0 */ "TAB(","TO","FN","SPC(","THEN","AT","NOT","STEP",
/* C8 */ "+","-","*","/","^","AND","OR",">",
/* D0 */ "=","<","SGN","INT","ABS","USR","FRE","SCRN(",
/* D8 */ "PDL","POS","SQR","RND","LOG","EXP","COS","SIN",
/* E0 */ "TAN","ATN","PEEK","LEN","STR$","VAL","ASC","CHR$",
/* E8 */ "LEFT$","RIGHT$","MID$","","","","","",
/* F0 */ "","","","","","","","",
/* F8 */ "","","","","","(","(","("
};

#define LOW(_x)  ((_x)&0xff)
#define HIGH(_x) (((_x)>>8)&0xff)
#define MAXSIZE 65535

/* File cannot be longer than 64k */
unsigned char output[MAXSIZE+1];

char *line_ptr;
int line=0;
char input_line[BUFSIZ];

static void show_problem(char *line_ptr) {

	int offset,i;

	offset=(int)(line_ptr-input_line);
	fprintf(stderr,"%s",input_line);
	for(i=0;i<offset;i++) fputc(' ',stderr);
	fprintf(stderr,"^\n");
}

static int get_line_num(int *linenum, int *custom_offset) {

	int num=0;
	int offset=0;

	/* skip any whitespace */
	while((*line_ptr<=' ') && (*line_ptr!=0)) line_ptr++;

	/* Custom Offset */
	if (*line_ptr=='*') {
		line_ptr++;
		while(*line_ptr>' ') {
			if ((*line_ptr>='0')&&(*line_ptr<='9')) {
				offset*=16;
				offset+=(*line_ptr)-'0';
			} else if ((*line_ptr>='A')&&(*line_ptr<='F')) {
				offset*=16;
				offset+=(*line_ptr)-'A'+10;
			}
			else {
				fprintf(stderr,"Invalid offset line %d\n",line);
				show_problem(line_ptr);
				exit(-1);
			}
			line_ptr++;
		}

		/* Skip whitespace */
		while((*line_ptr<=' ') && (*line_ptr!=0)) line_ptr++;
	}

	while (*line_ptr>' ') {
		if ((*line_ptr<'0')||(*line_ptr>'9')) {
//			fprintf(stderr,"Invalid line number line %d\n",line);
//			show_problem(line_ptr);
//			exit(-1);
			/* not a bug */
			break;
		}
		num*=10;
		num+=(*line_ptr)-'0';
		line_ptr++;
	}

	if (!(*line_ptr)) {
		fprintf(stderr,"Missing line number line %d\n",line);
		exit(-1);
	}

	if (linenum) *linenum=num;
	if (custom_offset) {
		*custom_offset=offset;
		if (debug) fprintf(stderr,"CO=%x\n",offset);

	}

	return num;
}

static int in_quotes=0,in_rem=0;

/* note: try to find longest possible token */
/* otherwise ATN is turned into AT N */
static int find_token(void) {

	int ch,i;

	ch=*line_ptr;

	/* end remarks if end of line */
	if (in_rem && (ch=='\n')) {
		in_rem=0;
		return 0;
	}

	/* don't skip whitespace in quotes or remarks */
	if ((!in_quotes)&&(!in_rem)) {
		while(ch<=' ') {
			if ((ch=='\n') || (ch=='\r') || (ch=='\0')) {
				return 0;
			}
			line_ptr++;
			ch=*line_ptr;
		}
	}

	/* toggle quotes mode */
	if (ch=='\"') in_quotes=!in_quotes;

	/* don't tokenize if in quotes */
	if ((!in_quotes)&&(!in_rem)) {

//		fprintf(stderr,"%s",line_ptr);
		for(i=0;i<NUM_TOKENS;i++) {
			if (!strncmp(line_ptr,applesoft_tokens[i],
					strlen(applesoft_tokens[i]))) {

				/* HACK: special case to avoid AT/ATN problem */
				/* Update, apparently actual applesoft uses   */
				/*         a similar hack.  Also the 'A TO'   */
				/*         case which we don't handle because */
				/*         we like sane whitespace.           */
				if ((i==69) && (line_ptr[2]=='N')) continue;
//				fprintf(stderr,
//						"Found token %x (%s) %d\n",0x80+i,
//						applesoft_tokens[i],i);

				line_ptr+=strlen(applesoft_tokens[i]);

				/* REM is 0x32 */
				if (i==0x32) in_rem=1;

				return 0x80+i;
			}

			//fprintf(stderr,"%s ",applesoft_tokens[i]);
		}
	}

	//fprintf(stderr,"\n");

	/* not a token, just ascii */
	line_ptr++;
	return ch;
}

static void check_oflo(int size) {

	if (size>MAXSIZE) {
		fprintf(stderr,"Output file too big!\n");
		exit(-1);
	}
}

int main(int argc, char **argv) {

	int offset=2,i;

	int linenum=0,custom_offset=0,lastline=0,link_offset;
	int link_value=0x801; /* start of applesoft program */
	int token;
	int c;
	FILE *fff;

	/* Check command line arguments */
	while ((c = getopt (argc, argv,"d"))!=-1) {
		switch (c) {

		case 'd':
			debug=1;
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
		if (debug) fprintf(stderr,"Opened file %s\n",argv[optind]);
	}

	while(1) {
		/* get line from input file */
		line_ptr=fgets(input_line,BUFSIZ,fff);
		line++;
		if (line_ptr==NULL) break;

		/* VMW extension, skip between 'if 0 and 'endif */
		if (line_ptr[0]=='\'') {
			if (!strncmp(line_ptr,"\'.if 0",6)) {
				while(1) {
					line_ptr=fgets(input_line,BUFSIZ,fff);
					line++;
					if (line_ptr==NULL) break;
					if (!strncmp(line_ptr,"\'.endif",7)) break;
				}
			}
		}
		if (line_ptr==NULL) break;

		/* VMW extension: use leading ' as a comment char */
		if (line_ptr[0]=='\'') continue;

		/* skip empty lines */
		if (line_ptr[0]=='\n') continue;

		get_line_num(&linenum,&custom_offset);
		if ((linenum>65535) || (linenum<0)) {
			fprintf(stderr,"Invalid line number %d\n",linenum);
			exit(-1);
		}
		if (linenum<lastline) {
			fprintf(stderr,"Line counted backwards %d->%d\n",
				lastline,linenum);
			exit(-1);
		}
		lastline=linenum;

		link_offset=offset;
		check_oflo(offset+4);
		output[offset+2]=LOW(linenum);
		output[offset+3]=HIGH(linenum);
		offset+=4;

		while(1) {
			token=find_token();
			output[offset]=token;
			if (debug) fprintf(stderr,"%2X ",token);
			offset++;
			check_oflo(offset);
			if (!token) break;
		}

		/* remarks end at end of line */
		in_rem=0;

		/* quotes do too */
		in_quotes=0;

		/* 2 bytes is to ignore size from beginning of file */
		link_value=0x801+(offset-2);

		/* point link value to next line */
		check_oflo(offset+2);
		if (custom_offset) {
			output[link_offset]=LOW(custom_offset);
			output[link_offset+1]=HIGH(custom_offset);
		}
		else {
			output[link_offset]=LOW(link_value);
			output[link_offset+1]=HIGH(link_value);
		}
	}
	/* set last link field to $00 $00 which indicates EOF */
	check_oflo(offset+2);
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
