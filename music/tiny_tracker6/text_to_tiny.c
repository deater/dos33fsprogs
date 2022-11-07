/* make music for tiny_music player */

#define VERSION	"1.0"

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

static int octave_adjust=0;

static int notes_used[12*8];
static int allocated_notes[12*8];
static int notes_allocated=0;
static int total_len=0;


unsigned short frequencies[]={
//C   C#    D     D#    E     F     F#    G     G#    A     A#      B
0x7A3,0x735,0x6CD,0x66C,0x60F,0x5B8,0x566,0x518,0x4CF,0x48A,0x449,0x40B,
0x3D1,0x39A,0x366,0x336,0x307,0x2DC,0x2B3,0x28C,0x267,0x245,0x224,0x205, //2
0x1E8,0x1CD,0x1B3,0x19B,0x183,0x16E,0x159,0x146,0x133,0x122,0x112,0x102, //3
0x0F4,0x0E6,0x0D9,0x0CD,0x0C1,0x0B7,0x0AC,0x0A3,0x099,0x091,0x089,0x081, //4
0x07A,0x073,0x06C,0x066,0x060,0x05B,0x056,0x051,0x04C,0x048,0x044,0x040, //5
0x03D,0x039,0x036,0x033,0x030,0x02D,0x02B,0x028,0x026,0x024,0x022,0x020, //6
//0x01E,0x01C,0x01B,0x019,0x018,0x016,0x015,0x014,0x013,0x012,0x011,0x010,
//0x00F,0x00E,0x00D,0x00C,0x00C,0x00B,0x00A,0x00A,0x009,0x009,0x008,0x008,
};

// CLLNNNN

int note_to_ed(char note, int flat, int sharp, int octave) {

	int offset;

	switch(note) {
		case 'C': offset=0; break;
		case 'D': offset=2; break;
		case 'E': offset=4; break;
		case 'F': offset=5; break;
		case 'G': offset=7; break;
		case 'A': offset=9; break;
		case 'B': offset=11; break;

		case 'R': offset=12; flat=0; sharp=0; octave=3; break;

		default:
			fprintf(stderr,"Unknown note %c\n",note);
			return -1;
	}
	if (flat==1) offset--;
	if (sharp==1) offset++;
	if (sharp==2) offset+=2;


	offset=((((octave+octave_adjust)-1)&0x7)*12)+offset;
//	offset=((((octave+octave_adjust)-3)&0x3)<<4)|offset;

	return offset;
}



static int debug=0;

static int line=0;

static int header_version=0;


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
	int offset;
};


static int allocate_note(int which) {

	int i;
	for(i=0;i<notes_allocated;i++) {
		if (allocated_notes[i]==which) return i;
	}

	allocated_notes[notes_allocated]=which;
	notes_allocated++;

	return notes_allocated-1;

}

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
	n->ed_freq=-1;
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
					n->octave);

		n->enabled=1;
		n->length=0;
		n->ed_freq=freq;
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


static int write_note(int *a_last,int *b_last,int *c_last,int *total_len) {

	// NNNNNNEC

	unsigned char temp_value;

	if (*a_last>=0) {
		temp_value=(*a_last<<2)|0;
		if ((*b_last<0) && (*c_last<0)) {
			 temp_value|=2;
		}
		printf("\t.byte $%02X ; A=%d L=%d\n",
			temp_value,
			*a_last,(*b_last<0)||(*c_last<0));
		(*total_len)++;
		*a_last=-1;
	}

	if (*b_last>=0) {
		temp_value=(*b_last<<2)|1;
		if (*c_last<0) temp_value|=2;

		printf("\t.byte $%02X ; B=%d L=%d\n",
			temp_value,
			*b_last,(*c_last<0));
		(*total_len)++;
		*b_last=-1;
	}

	if (*c_last>=0) {
		fprintf(stderr,"Unsupported C!\n");
//		printf("\t.byte $%02X ; C=%d L=%d\n",
//			(unsigned char)(*c_last<<3)|4|2,
//			*c_last,1);
//		(*total_len)++;
//		*c_last=-1;
	}

	return 0;
}


int main(int argc, char **argv) {

	char string[BUFSIZ];
	char *result;
	char *in_filename;
	char temp[BUFSIZ];
	FILE *in_file=NULL;
	//int attributes=0;
	int loop=0;
	int sp,external_frequency,irq;
	struct note_type a,b,c;
	int copt;

	char song_name[BUFSIZ];
	char author_name[BUFSIZ];
	char comments[BUFSIZ];
	char *comments_ptr=comments;

//	unsigned char sharp_char[]=" #-=";

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

	a.which='A';	b.which='B';	c.which='C';


	// algorithm
	// get A,B,C


//	int first=1;
//	int a_last=0,b_last=0,same_count=0;
//	int a_len=0,b_len=0,a_freq=0,b_freq=0;
	int current_length=0;
	int first=1;
	int a_last=-1,b_last=-1,c_last=-1;

printf("peasant_song:\n");
printf("; register init\n");
//printf("\t.byte   $00,$00,$00,$00,$00,$00         ; $00: A/B/C fine/coarse\n");
//printf("\t.byte   $00                             ; $06\n");
//printf("\t.byte   $38                             ; $07 mixer (ABC on)\n");
//printf("\t.byte   $0E,$0C,$0C                     ; $08 volume A/B/C\n");
//printf("\t.byte   $00,$00,$00,$00                 ; $09\n");
printf("\n");

	while(1) {
		result=fgets(string,BUFSIZ,in_file);
		if (result==NULL) break;
		line++;

		a.ed_freq=-1;
		b.ed_freq=-1;
		c.ed_freq=-1;
		a.length=0;
		b.length=0;
		c.length=0;

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

		if (a.ed_freq>=0) {
			a.offset=allocate_note(a.ed_freq);
			notes_used[a.ed_freq]++;
			printf("; A: %d\n",a.ed_freq);
		}
		if (b.ed_freq>=0) {
			b.offset=allocate_note(b.ed_freq);
			notes_used[b.ed_freq]++;
			printf("; B: %d\n",b.ed_freq);
		}
		if (c.ed_freq>=0) {
			c.offset=allocate_note(c.ed_freq);
			notes_used[c.ed_freq]++;
			printf("; C: %d\n",c.ed_freq);
		}

		if ((a.ed_freq>=0)||(b.ed_freq>=0)||(c.ed_freq>=0)) {
			printf("; none: a=%d c=%d len=%d\n",a_last,c_last,current_length);

			// now NNNNNNEC

			if (!first) {
				write_note(&a_last,&b_last,&c_last,&total_len);
			}
			current_length=0;

			//if (!first) {
//				printf("\t.byte $%02X ; L = %d\n",
//					current_length|0xc0,current_length);
//				printf("\n");
//				current_length=0;
//				total_len++;
			//}


			first=0;
		}


		if (a.ed_freq>=0) {
			a_last=a.offset;
		}
		if (b.ed_freq>=0) {
			b_last=b.offset;
		}
		if (c.ed_freq>=0) {
			c_last=c.offset;
		}

		current_length++;


	}


	printf("; last: a=%d c=%d len=%d\n",a_last,c_last,current_length);
	write_note(&a_last,&b_last,&c_last,&total_len);

//	printf("\t.byte $FF ; end\n");

	/* assume 32 notes or fewer */
	printf("\t.byte $80 ; end\n");
	total_len++;

	int o,n;

	for(o=0;o<6;o++) {
		printf("; Octave %d : ",o);
		for(n=0;n<12;n++) {
			printf("%d ",notes_used[(o*12)+n]);
		}
		printf("\n");
	}

	printf("; %d notes allocated\n",notes_allocated);

	printf(";.byte ");
	for(n=0;n<notes_allocated;n++) {
		printf("%d,",allocated_notes[n]);
	}
	printf("\n");

	/* put these first as we use the high bit to end things? */
	printf("frequencies_low:\n");
	printf(".byte ");
	for(n=0;n<notes_allocated;n++) {
		printf("$%02X",(frequencies[allocated_notes[n]])&0xff);
		if (n!=(notes_allocated-1)) printf(",");
		total_len++;
	}
	printf("\n");

	printf("frequencies_high:\n");
	printf(".byte ");
	for(n=0;n<notes_allocated;n++) {
		printf("$%02X",(frequencies[allocated_notes[n]]>>8));
		if (n!=(notes_allocated-1)) printf(",");
		total_len++;
	}
	printf("\n");



	printf("; total len=%d\n",total_len);

	(void) irq;
	(void) loop;
	(void) external_frequency;

	return 0;
}

