/* This is a two-track format to play on the simple 1-bit speaker */
/* Interface available on the Apple II */

/* https://sourceforge.net/p/ed2midi/code/ */
/* From a spreadsheet from ed2midi */
/*	Octave	1	2	3	4	5
	A	255	128	64	32	16
	A#	240	120	60	30	15
	B	228	114	57	28	14
	C	216	108	54	27	13
	C#	204	102	51	25	12
	D	192	 96	48	24	12
	D#	180	 90	45	22	11
	E	172	 86	43	21	10
	F	160	 80	40	20	10
	F#	152	 76	38	19	9
	G	144	 72	36	18	9
	G#	136	 68	34	17	8
*/

/* ed file format */

/* First byte 0:	??? (0,0,0 = exit) */

/* First byte 1:	Voice */
/*		byte1 = voice1 instrument */
/*		byte2 = voice2 instrument */
/*		Varies, bigger than 8 seem to make no difference */

/* Otherwise,	byte0 = duration (20=quarter, 40=half) */
/* 		byte1 = voice1 note */
/*		byte2 = voice2 note */

#define VERSION	"1.0"

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#include "notes.h"

static int debug=0;

static int bpm=120;
static int baselen=80;
static int frames_per_line;
static int octave_adjust=0;

static int line=0;

static int header_version=0;

static int note_to_length(int length) {

	int len=1;

	switch(length) {
		case 0: len=(baselen*5)/2; break;	// 0 = 2.5
		case 1:	len=baselen; break;		// 1 =   1 whole
		case 2: len=baselen/2; break;		// 2 = 1/2 half
		case 3: len=(baselen*3)/8; break;	// 3 = 3/8 dotted quarter
		case 4: len=baselen/4; break;		// 4 = 1/4 quarter
		case 5: len=(baselen*5)/8; break;	// 5 = 5/8 ?
		case 8: len=baselen/8; break;		// 8 = 1/8 eighth
		case 9: len=(baselen*3)/16; break;	// 9 = 3/16 dotted eighth
		case 6: len=baselen/16; break;		// 6 = 1/16 sixteenth
		case 10: len=(baselen*3)/4; break;	// : = 3/4 dotted half
		case 11: len=(baselen*9)/8; break;	// ; = 9/8 dotted half + dotted quarter
		case 12: len=(baselen*3)/2; break;	// < = 3/2 dotted whole
		case 13: len=(baselen*2); break;	// = = 2   double whole
		default:
			fprintf(stderr,"Unknown length %d, line %d\n",
				length,line);
	}

	return len;
}

struct note_type {
	unsigned char which;
	unsigned char note;
	int sharp,flat;
	int octave;
	int len;
	int enabled;
	int freq;
	int length;
	int left;
	int ed_freq;
};



static int get_note(char *string, int sp, struct note_type *n, int line) {

	int freq;
	int ch;

//	fprintf(stderr,"VMW: Entering, sp=%d\n",sp);

	/* Skip white space */
	while((string[sp]==' ' || string[sp]=='\t')) sp++;

	if (string[sp]=='\n') return -1;

	/* return early if no change */
	ch=string[sp];

//	fprintf(stderr,"VMW: %d %d\n",ch,sp);

	if (ch=='-') {
		if (header_version==0) return sp+6;
		else {
			return sp+11;
		}
	}

	/* get note info */
	n->sharp=0;
	n->flat=0;
	n->ed_freq=0;
	n->note=ch;
	sp++;
	if (string[sp]==' ') ;
	else if (string[sp]=='#') n->sharp=1;
	else if (string[sp]=='-') n->flat=1;
	else if (string[sp]=='=') n->flat=2;
	else {
		fprintf(stderr,"Unknown note modifier %c, line %d:%d\n",
			string[sp],line,sp);
		fprintf(stderr,"String: %s\n",string);
	}
//	printf("Sharp=%d Flat=%d\n",n->sharp,n->flat);
	sp++;
	n->octave=string[sp]-'0';
	sp++;
	sp++;
	n->len=string[sp]-'0';
	sp++;


	if (n->note!='-') {

		freq=note_to_ed(n->note,n->flat,n->sharp,
					n->octave+octave_adjust);

		if (debug) printf("(%c) %c%c L=%d O=%d f=%d\n",
				n->which,
				n->note,
				n->sharp?'#':' ',
				n->len,
				n->octave,
				freq);

		n->ed_freq=freq;
		n->enabled=1;
		n->length=note_to_length(n->len);
		n->left=n->length-1;

		if (n->length<=0) {
			printf("Error line %d\n",line);
			exit(-1);
		}
	}
	else {
		n->ed_freq=0;
	}

	if (header_version==2) sp+=6;

	return sp;
}

static int get_string(char *string, char *key, char *output, int strip_linefeed) {

	char *found;

	found=strstr(string,key);
	found=found+strlen(key);

	/* get rid of leading whitespace */
	while(1) {
		if ((*found==' ') || (*found=='\t')) found++;
		else break;
	}

	strcpy(output,found);

	/* remove trailing linefeed */
	if (strip_linefeed) output[strlen(output)-1]=0;

	return 0;

}

static void print_help(int just_version, char *exec_name) {

	printf("\ntext_to_ed version %s by Vince Weaver <vince@deater.net>\n\n",VERSION);
	if (just_version) exit(0);

	printf("This created Electric Duet files\n\n");

	printf("Usage:\n");
	printf("\t%s [-h] [-v] [-d] [-o X] [-i X] textfile outbase\n\n",
		exec_name);
        printf("\t-h: this help message\n");
        printf("\t-v: version info\n");
        printf("\t-d: print debug messages\n");
        printf("\t-o: Offset octave by X\n");
	printf("\t-i: set second instrument to X\n");

	exit(0);
}


int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	char ed_filename[BUFSIZ],lyrics_filename[BUFSIZ],*in_filename;
	char temp[BUFSIZ];
	FILE *ed_file,*lyrics_file,*in_file=NULL;
	//int attributes=0;
	int loop=0,i;
	int sp,external_frequency,irq;
	struct note_type a,b,c;
	int copt;

	// Instruments 0=square
	int voice1=0,voice2=0;

	char song_name[BUFSIZ];
	char author_name[BUFSIZ];
	char comments[BUFSIZ];
	char *comments_ptr=comments;

	unsigned char sharp_char[]=" #-=";

	/* Parse command line arguments */
	while ((copt = getopt(argc, argv, "dhvo:i:"))!=-1) {
		switch (copt) {
                        case 'd':
                                /* Debug messages */
                                printf("Debug enabled\n");
                                debug=1;
                                break;
                        case 'h':
                                /* help */
                                print_help(0,argv[0]);
				break;
			case 'v':
				/* version */
				print_help(1,argv[0]);
				break;
			case 'o':
				/* octave offset */
				octave_adjust=atoi(optarg);
				break;
			case 'i':
				/* instrument to use */
				voice1=atoi(optarg);
				break;
			default:
				print_help(0,argv[0]);
				break;
		}
	}

	if (argv[optind]!=NULL) {
		/* Open the input file */
		if (argv[optind][0]=='-') {
			in_file=stdin;
		}
		else {
			in_filename=strdup(argv[optind]);
			in_file=fopen(in_filename,"r");
			if (in_file==NULL) {
				fprintf(stderr,"Couldn't open %s\n",in_filename);
				return -1;
			}
		}
        }

	if (optind+1>=argc) {
		fprintf(stderr,"Error, need outfile\n");
		exit(0);
        }



	/* Open the output/lyrics files */
	sprintf(ed_filename,"%s.ed",argv[optind+1]);
	sprintf(lyrics_filename,"%s.edlyrics",argv[optind+1]);

	ed_file=fopen(ed_filename,"w");
	if (ed_file==NULL) {
		fprintf(stderr,"Couldn't open %s\n",ed_filename);
		return -1;
	}

	lyrics_file=fopen(lyrics_filename,"w");
	if (lyrics_file==NULL) {
		fprintf(stderr,"Couldn't open %s\n",lyrics_filename);
		return -1;
	}


	/* Get the info for the header */

	while(1) {
		result=fgets(string,BUFSIZ,in_file);
		if (result==NULL) break;
		line++;
		if (strstr(string,"ENDHEADER")) break;
		if (strstr(string,"HEADER:")) {
			get_string(string,"HEADER:",temp,1);
			header_version=atoi(temp);
			printf("Found header version %d\n",header_version);
		}
		if (strstr(string,"TITLE:")) {
			get_string(string,"TITLE:",song_name,1);
		}
		if (strstr(string,"AUTHOR:")) {
			get_string(string,"AUTHOR:",author_name,1);
		}
		if (strstr(string,"COMMENTS:")) {
			get_string(string,"COMMENTS:",comments_ptr,0);
			comments_ptr=&comments[strlen(comments)];
		}
		if (strstr(string,"BPM:")) {
			get_string(string,"BPM:",temp,1);
			bpm=atoi(temp);
		}
		if (strstr(string,"FREQ:")) {
			get_string(string,"FREQ:",temp,1);
			external_frequency=atoi(temp);
		}
		if (strstr(string,"IRQ:")) {
			get_string(string,"IRQ:",temp,1);
			irq=atoi(temp);
		}
		if (strstr(string,"LOOP:")) {
			get_string(string,"LOOP:",temp,1);
			loop=atoi(temp);
		}

	}

	if (bpm==115) {
		baselen=80;
	}
	else if (bpm==120) { // 2Hz, 500ms, 80x=500, x=6.25, should be 80
		baselen=120;
	}
	else if (bpm==136) { // 2.3Hz, 440ms, should be 70
		baselen=70;
	}
	else if (bpm==160) {// 2.66Hz, 375ms, should be 60
		baselen=60;
	}
	else if (bpm==250) {
		baselen=50;	// eyeballed
	}
	else {
		fprintf(stderr,"Warning!  Unusual BPM of %d\n",bpm);
		baselen=80;
	}

	frames_per_line=baselen/16;

	a.which='A';	b.which='B';	c.which='C';

	int first=1;
	int a_last=0,b_last=0,same_count=0;
	int a_len=0,b_len=0,a_freq=0,b_freq=0;
	int frame=0,lyric=0;
	int lyric_line=1;

	fprintf(ed_file,"%c%c%c",1,voice1,voice2);

	while(1) {
		result=fgets(string,BUFSIZ,in_file);
		if (result==NULL) break;
		line++;

		a.ed_freq=0;
		b.ed_freq=0;
		a.length=0;
		b.length=0;

		/* skip comments */
		if (string[0]=='\'') continue;
		if (string[0]=='-') continue;
		if (string[0]=='*') continue;

		sp=0;

		/* Skip line number */
		while((string[sp]!=' ' && string[sp]!='\t')) sp++;

		sp=get_note(string,sp,&a,line);
		if (sp!=-1) sp=get_note(string,sp,&b,line);
		if (sp!=-1) sp=get_note(string,sp,&c,line);

		/* handle lyrics */
		if ((sp!=-1) && (string[sp]!='\n') && (string[sp]!=0)) {
			fprintf(lyrics_file,"; %d: %s",frame,&string[sp]);
			while((string[sp]==' ' || string[sp]=='\t')) sp++;
			if (string[sp]!='\n') {
				fprintf(lyrics_file,".byte\t$%02X",lyric_line&0xff);

				/* get to first quote */
				while(string[sp]!='\"') sp++;
				sp++;

				/* stop at second quote */
				while(string[sp]!='\"') {
					if (string[sp]=='\\') {
						sp++;
						/* Ignore if we have LED panel */
						if (string[sp]=='i') {
							//printf(",$%02X",10);
						}
						/* form feed */
						else if (string[sp]=='f') {
							fprintf(lyrics_file,",$%02X",12);
						}
						/* Vertical tab */
						else if (string[sp]=='v') {
							fprintf(lyrics_file,",$%02X",11);
						}
						else if (string[sp]=='n') {
							fprintf(lyrics_file,",$%02X",13|0x80);
						}
						else if ((string[sp]>='0') &&
							(string[sp]<=':')) {
							fprintf(lyrics_file,",$%02X",string[sp]-'0');
						}
						else {
							printf("UNKNOWN ESCAPE %d\n",string[sp]);
					}
					sp++;
					continue;
				}
				fprintf(lyrics_file,",$%02X",string[sp]|0x80);
				sp++;
			}
			fprintf(lyrics_file,",$00\n");



//				fprintf(lyrics_file," %s",&string[sp]);
//				printf("%s",&string[sp]);
			}
			lyric=1;

		}


		if ((a.ed_freq!=0)||(b.ed_freq!=0)) {
			if (debug) {
				printf("%d: ",frame);
				printf("%c%c%d %d (%d,%d) |%d %d %d %c|\t",
					a.note,sharp_char[a.sharp+2*a.flat],a.octave,
					a.len,a.ed_freq,a.length,
					a.sharp,a.flat,a.sharp+2*a.flat,
					sharp_char[2]);

				printf("%c%c%d %d (%d,%d)\n",
					b.note,sharp_char[b.sharp+2*b.flat],b.octave,
					b.len,b.ed_freq,b.length);
			}
		}

		if (a.length) a_len=a.length;
		if (b.length) b_len=b.length;
		if (a.ed_freq) {
			a_freq=a.ed_freq;
		}
		if (b.ed_freq) {
			b_freq=b.ed_freq;
		}

		if (first) {
			a_last=a_freq;
			b_last=b_freq;
			first=0;
		}

		for(i=0;i<frames_per_line;i++) {

			if ( (a_len==0) || (b_len==0) ) {
			//	fprintf(ed_file,"%c%c%c",same_count*(baselen/16),a_last,b_last);
			//	printf("*** %x %x %x\n",same_count*(baselen/16),a_last,b_last);
				if (a_len==0) {
					a_freq=0;
			//		printf("A hit zero\n");
				}
				if (b_len==0) {
					b_freq=0;
			//		printf("B hit zero\n");
				}
			//	same_count=0;

			}
			else {
			//	printf("%d\n",a_len);
			}

			if ((a_freq!=a_last) ||
				(b_freq!=b_last) ||
				(lyric) ||
				(same_count>250)) {


				/* Avoid changing instrument by accident */
				/* Also keep lyrics in sync */
				if (same_count<2) {
					same_count=2;
				}
				lyric_line++;

				fprintf(ed_file,"%c%c%c",same_count,a_last,b_last);
				if (debug) {
					printf("*** %x %x %x\n",same_count,a_last,b_last);
				}
				same_count=0;

			}

			same_count++;

			if (a_len) a_len--;
			if (b_len) b_len--;

			a_last=a_freq;
			b_last=b_freq;
			lyric=0;

		}
		frame++;

	}
	if (same_count==1) same_count++;
	fprintf(ed_file,"%c%c%c",same_count,a_last,b_last);
	fprintf(ed_file,"%c%c%c",0,0,0);	// EOF?

	fclose(ed_file);
	fclose(lyrics_file);

	(void) irq;
	(void) loop;
	(void) external_frequency;

	return 0;
}

