#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "notes.h"

int main(int argc, char **argv) {

	int i;
	unsigned char triad[3];
	char temp[5];
	int fd,result;
	char *filename;
	int instrument1=-1,new_instrument1=0;
	int instrument2=-1,new_instrument2=0;
	int line=0;
	int length=0;

	if (argc>1) {
		filename=argv[1];
	}
	else {
		printf("Usage: %s file.ed\n\n",argv[0]);
		return 0;
	}

	fd=open(filename,O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Could not open %s\n",filename);
		return -1;
	}

	printf("\' HEADER:\t\t2\n");
	printf("\'\n");
	printf("\' TITLE:\t%s\n",filename);
	printf("\' AUTHOR:\t%s\n","dump_ed.c");
	printf("\' COMMENTS:\tConverted from Electric Duet format\n");
	printf("\' LOOP:\t\t0\n");
	printf("\' BPM:\t\t120\n");
	printf("\' TEMPO:\t3\n");
	printf("\' FREQ:\t\t1000000\n");
	printf("\' IRQ:\t\t50\n");
	printf("\' LYRICS:\t0\n");
	printf("\'\n");
	printf("\' INSTRUMENT:   0\n");
	printf("\' NAME:         piano\n");
	printf("\' ADSR:         1\n");
	printf("\' NOISE:        0\n");
	printf("\' ATTACK:       14,15,15\n");
	printf("\' DECAY:        14\n");
	printf("\' SUSTAIN:      13\n");
	printf("\' RELEASE:      10,5\n");
	printf("\' ONCE:         0\n");
	printf("\' ENDINSTRUMENT\n");
	printf("\'\n");
	printf("\' ENDHEADER\n");
	printf("\'\n");

/* from about.md */
/* First byte 0:        Voice */
/*              byte1 = voice1 instrument */
/*              byte2 = voice2 instrument */
/*              Varies, bigger than 8 seem to make no difference */

/* Otherwise,   byte0 = duration (20=quarter, 40=half) */
/*              byte1 = voice1 note */
/*              byte2 = voice2 note */

// assume for us, we have 96/3=32 lines per whole note
// 80/x = 32	whole
// 40/2 = 16	half
// 20/x = 8	quarter
// 10/x = 4 	eigth
// 5/x = 2	sixteenth
// 2.5 = 1      thirtysecond
// so times 2 divide by 5 


	while(1) {
		result=read(fd,triad,3);
		if (result<3) break;

		if ((triad[0]==0) && (triad[1]==0) && (triad[2]==0)) break;

		if (triad[0]==0) {
			new_instrument1=triad[1];
			new_instrument2=triad[2];
			//printf("Instrument 1=%d, Instrument 2=%d\n",triad[1],triad[2]);
		}
		else {
//			printf("Duration %d, ",triad[0]);
			length=(triad[0]*2)/5;
		//	printf("Duration %d, ",length);
			printf("%02X\t%s? ",line,ed_to_note(triad[1],temp));
			if (new_instrument1!=instrument1) {
				printf("%d",new_instrument1);
			}
			else {
				printf("-");
			}
			printf("------\t");

			printf("%s? ",ed_to_note(triad[2],temp));
			if (new_instrument2!=instrument2) {
				printf("%d",new_instrument2);
			}
			else {
				printf("-");
			}
			printf("------");
			printf("\n");
		}
		instrument1=new_instrument1;
		instrument2=new_instrument2;

		line++;
		if (line==32) {
			line=0;
			printf("\'\n");
		}

		for(i=0;i<length-1;i++) {
			printf("%02X\t------------\t------------\n",line);
			line++;
			if (line==32) {
				line=0;
				printf("\'\n");
			}
		}
	}

	close(fd);

	return 0;
}
