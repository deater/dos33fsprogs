#include <stdio.h>
#include <stdint.h>
#include <string.h>

/* https://sourceforge.net/p/ed2midi/code/ */
/* From a spreadsheet from ed2midi */
/*      Octave  1       2       3       4       5
        A       255     128     64      32      16
        A#/B-   240     120     60      30      15
        B       228     114     57      28      14
        C       216     108     54      27      13
        C#/D-   204     102     51      25      12
        D       192      96     48      24      12
        D#/E-   180      90     45      22      11
        E       172      86     43      21      10
        F       160      80     40      20      10
        F#/G-   152      76     38      19      9
        G       144      72     36      18      9
        G#/A-   136      68     34      17      8
*/

int note_to_ed(char note, int flat, int sharp, int octave) {

	int value=0,result=0;
	int octave_divider[5]={1,2,4,8,16};

	switch(note) {
		case 'A':
			if (flat==1) value=272;
			else if (sharp==1) value=240;
			else value=256;
			break;
		case 'B':
			if (flat==1) value=240;
			else if (sharp==1) value=216;
			else value=228;
			break;
		case 'C':
			if (flat==1) value=228;
			else if (sharp==1) value=204;
			else value=216;
			break;
		case 'D':
			if (flat==1) value=204;
			else if (sharp==1) value=180;
			else value=192;
			break;
		case 'E':
			if (flat==1) value=180;
			else if (sharp==1) value=160;
			else value=172;
			break;
		case 'F':
			if (flat==1) value=172;
			else if (sharp==1) value=152;
			else value=160;
			break;
		case 'G':
			if (flat==1) value=152;
			else if (sharp==1) value=136;
			else value=144;
			break;
		default:
			fprintf(stderr,"Unknown note %c\n",note);
	}

	if ((octave<1) || (octave>5)) {
		fprintf(stderr,"Invalid octave %d\n",octave);
		return -1;
	}

	result=value/octave_divider[octave-1];
	if (result>255) result=255;

	return result;
}

static struct note_mapping_type {
        int     freq[12];
} note_mapping[5]={
         /* A   A#  B   C   C#  D   D#  E   F   F#  G   G# */
	{{ 255,240,228,216,204,192,180,172,160,152,144,136}}, // 1
	{{ 128,120,114,108,102, 96, 90, 86, 80, 76, 72, 68}}, // 2
	{{  64, 60, 57, 54, 51, 48, 45, 43, 40, 38, 36, 34}}, // 3
	{{  32, 30, 28, 27, 25, 24, 22, 21, 20, 19, 18, 17}}, // 4
	{{  16, 15, 14, 13, 12, 12, 11, 10, 10,  9,  9,  8}}, // 5
};

static char notes[12]= {'A','A','B','C','C','D','D','E','F','F','G','G'};
static char sharps[12]={' ','#',' ',' ','#',' ','#',' ',' ','#',' ','#'};


char *ed_to_note(int freq, char *out) {

	int i,j;
	int note=0,octave=0;

//	printf("Freq=%d\n",freq);

	for(i=0;i<5;i++) {
		if ((freq<=note_mapping[i].freq[0]) &&
			(freq>=note_mapping[i].freq[11])) {
			octave=i+1;
			break;
		}
	}

	for(j=0;j<12;j++) {
		if (freq==note_mapping[i].freq[j]) {
			note=j;
			break;
		}
	}
	if (j==12) {
		sprintf(out,"%3d",freq);
	}
	else {
		out[0]=notes[note];
		out[1]=sharps[note];
		out[2]=octave+'0';
	}
	out[3]=0;

	return out;
}

