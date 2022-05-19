/* Creates an AppleSoft BASIC shape table                    */
/* See the AppleSoft manual for info on how this works       */
/* Some online info (I'm looking at you, atariarchives.org)  */
/* is inaccurate                                             */

/* Format of table is: */
/*	1 byte -- num shapes */
/*	1 byte -- don't care */
/*	offsets (repeats): 2 bytes (low/high) offset from start to each shape */
/*	Data (repeats), 0 at end of each */
/* data packed in as XX YYY ZZZ */
/* ZZZ = first dir, YYY = next, XX = last, can only be no-draw as 2 bits */
/*	note XX can't be NUP (00) */
/* */
/* NUP=0	UP=4 */
/* NRT=1	RT=5 */
/* NDN=2	DN=6 */
/* NLT=3	LT=7 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_SIZE 8192 /* not really, but anything larger would be crazy */

static int debug=0,line=1;

static unsigned char table[MAX_SIZE];

static void set_offset(int current_shape,int current_offset) {

	table[2+(current_shape*2)]=current_offset&0xff;
	table[2+(current_shape*2)+1]=(current_offset>>8)&0xff;
}

#define LOC_A 0
#define LOC_B 1
#define LOC_C 2

static void warn_if_zero(unsigned char byte, int line) {

	/* Check to see if we're accidentally ignoring bytes */
	if (byte==0) {
		fprintf(stderr,
			"Warning, all-0 byte will be ignored on line %d!\n",
			line);
	}

	if ((byte&0xf8)==0) {
		fprintf(stderr,
			"Warning, ignoring C and B due to 0 on line %d!\n",
			line);
	}
}

static void print_usage(char *exe) {

	printf("Usage:\t%s [-h] [-a] [-b] [-x]\n\n",exe);
	printf("\t-h\tprint this help message\n");
	printf("\t-a\toutput shape table in applesoft BASIC format\n");
	printf("\t-b\toutput shape table in binary format for appleiibot\n");
	printf("\t-x\toutput shape table in hex format for assembly language\n");
	printf("\n");
	exit(1);
}

static int get_token(char *token, FILE *fff) {

	int ch;
	int ptr=0;

	/* skip leading spaces/comments */
	while(1) {
		ch=fgetc(fff);
		if (ch<0) return -1;

		/* Skip comment to end of line */
		if (ch=='#') {
			while(ch!='\n') ch=fgetc(fff);
		}

		if ((ch==' ') || (ch=='\t') || (ch=='\n')) {
			if (ch=='\n') line++;
			continue;
		}

		break;
	}

	while(1) {
		token[ptr]=ch;
		ptr++;

		ch=fgetc(fff);
		if (ch<0) return -1;

		if ((ch==' ') || (ch=='\t') || (ch=='\n')) {
			if (ch=='\n') line++;
			break;
		}
	}
	token[ptr]=0;


	return 0;

}

#define OUTPUT_BASIC	0
#define OUTPUT_BINARY	1
#define OUTPUT_HEX	2

int main(int argc, char **argv) {

	char string[BUFSIZ];
	int result;
	int table_size=0;
	int num_shapes=0;
	int current_offset=0,current_shape=0;
	int i;

	int command=0,sub_pointer;

	int output_type=OUTPUT_BASIC;

	if (argc<2) {
		output_type=OUTPUT_BASIC;
	}
	else {
		if (argv[1][0]=='-') {

			switch(argv[1][1]) {

				case 'h':
					print_usage(argv[0]);
					break;
				case 'b':
					output_type=OUTPUT_BINARY;
					break;
				case 'a':
					output_type=OUTPUT_BASIC;
					break;
				case 'x':
					output_type=OUTPUT_HEX;
					break;
				case 'd':
					debug=1;
					break;
				default:
					printf("Unknown options %s\n",argv[1]);
					print_usage(argv[0]);
			}
		}
	}

	result=get_token(string,stdin);
	if (result<0) {
		fprintf(stderr,"Error getting number\n");
		return -1;
	}

	num_shapes=atoi(string);
	if (num_shapes<1) {
		fprintf(stderr,"Error getting numshapes\n");
		return -2;
	}
	if (debug) fprintf(stderr,"Number of shapes = %d\n",num_shapes);

	table[0]=num_shapes;
	table[1]=0;

	current_shape=0;
	current_offset=2+2*(num_shapes);

	for(current_shape=0;current_shape<num_shapes;current_shape++) {

		set_offset(current_shape,current_offset);

		/* Find START */

		while(1) {
			result=get_token(string,stdin);
			if (result<0) {
				fprintf(stderr,"Unexpected EOF, no START!\n");
				return -1;
			}

			if (!strcmp(string,"START")) {
				if (debug) {
					fprintf(stderr,"STARTING SHAPE %d\n",
						current_shape);
				}
				break;

			}
		}

		/* READ DATA */
		sub_pointer=LOC_A;

		while(1) {
			result=get_token(string,stdin);
			if (result<0) {
				fprintf(stderr,"Unexpected end of file! No STOP\n");
				return -2;
			}

			if (!strcmp(string,"STOP")) {
				if (debug) fprintf(stderr,"STOP\n");
				break;
			}

			/* yes, this is inefficient... */

			if (!strcmp(string,"NUP")) {
				if (debug) fprintf(stderr,"NUP\n");
				command=0;
			}
			else if (!strcmp(string,"NRT")) {
				if (debug) fprintf(stderr,"NRT\n");
				command=1;
			}
			else if (!strcmp(string,"NDN")) {
				if (debug) fprintf(stderr,"NDN\n");
				command=2;
			}
			else if (!strcmp(string,"NLT")) {
				if (debug) fprintf(stderr,"NLT\n");
				command=3;
			}
			else if (!strcmp(string,"UP")) {
				if (debug) fprintf(stderr,"UP\n");
				command=4;
			}
			else if (!strcmp(string,"RT")) {
				if (debug) fprintf(stderr,"RT\n");
				command=5;
			}
			else if (!strcmp(string,"DN")) {
				if (debug) fprintf(stderr,"DN\n");
				command=6;
			}
			else if (!strcmp(string,"LT")) {
				if (debug) fprintf(stderr,"LT\n");
				command=7;
			}
			else if (!strcmp(string,"NOP")) {
				if (debug) fprintf(stderr,"NOP\n");
				command=8;
			}
			else {
				fprintf(stderr,"Unknown command '%s'",string);
			}

			if (sub_pointer==LOC_A) {
				table[current_offset]=(command&0x7);
				sub_pointer=LOC_B;
			}
			else if (sub_pointer==LOC_B) {
				table[current_offset]|=((command&0x7)<<3);
				sub_pointer=LOC_C;
			}
			else {
				/* Try to fit in LOC_C.  */

				/* This can only hold no-draw moves */
				/* Also a LOC_C of 0 is ignored     */
				if ((command&0x4) || (command==0)) {

					/* Write to LOC_A instead */

					warn_if_zero(table[current_offset],line);

					current_offset++;
					table[current_offset]=(command&0x7);
					sub_pointer=LOC_B;
				}
				else {
					/* write to LOC_C */

//					if (current_offset==8) {
						/* What?? why?? */
//					}
//					else {
						table[current_offset]|=((command&0x3)<<6);
//					}

					warn_if_zero(table[current_offset],line);

					current_offset++;
					sub_pointer=LOC_A;
				}
			}
		}

		if (sub_pointer!=LOC_A) current_offset++;

		table[current_offset]=0; current_offset++;

	}

	table_size=current_offset;

	if (output_type==OUTPUT_BINARY) {
		unsigned char header[4];
		int offset=0x6000;

		header[0]=offset&0xff;
		header[1]=(offset>>8)&0xff;
		header[2]=table_size&0xff;
		header[3]=(table_size>>8)&0xff;

		fprintf(stderr,"Be sure to POKE 232,%d : POKE 233,%d\n"
			"\tto let applesoft know the location of the table\n",
			offset&0xff,(offset>>8)&0xff);

		fwrite(header,sizeof(unsigned char),4,stdout);

		fwrite(table,sizeof(unsigned char),table_size,stdout);
	}
	else if (output_type==OUTPUT_BASIC) {

		/* put near highmem */
		int address=0x1ff0-table_size;

		printf("10 HIMEM:%d\n",address);
		printf("20 POKE 232,%d:POKE 233,%d\n",(address&0xff),(address>>8)&0xff);
		printf("30 FOR L=%d TO %d: READ B:POKE L,B:NEXT L\n",
			address,(address+table_size)-1);
		printf("35 HGR:ROT=0:SCALE=2\n");
		printf("40 FOR I=1 TO %d: XDRAW I AT I*10,100:NEXT I\n",
			num_shapes);
		printf("90 END\n");

		for(i=0;i<current_offset;i++) {
			if(i%10==0) printf("%d DATA ",100+i/10);
			printf("%d",table[i]);
			if ((i%10==9)||(i==current_offset-1)) printf("\n");
			else printf(",");
		}

	}
	else if (output_type==OUTPUT_HEX) {

		for(i=0;i<current_offset;i++) {
			if(i%8==0) printf(".byte\t");
			printf("$%02x",table[i]);
			if ((i%8==7)||(i==current_offset-1)) printf("\n");
			else printf(",");
		}

	}
	else {
		fprintf(stderr,"Error, unknown output type %d\n",
			output_type);
	}

	return 0;
}
