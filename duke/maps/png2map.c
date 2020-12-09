#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"


/* converts a png of map to format by our duke engine */

/* 1280x200 image */
/* 256 sprites of size 2x4 in a 16x16 grid at 8,4 */


static unsigned char tiles[256][2][4];
static unsigned char tilemap[256][40];
static unsigned char temp_tile[2][4];

static int ascii_output=0;

int main(int argc, char **argv) {

	int i,j,x,y;
	int numtiles=0,found_tile;

	unsigned char *image;
	int xsize,ysize;
	FILE *outfile;

	if (argc<3) {
		fprintf(stderr,"Usage:\t%s INFILE OUTFILE\n\n",argv[0]);
		exit(-1);
	}

	outfile=fopen(argv[2],"w");
	if (outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[2]);
		exit(-1);
	}

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_WHOLETHING)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image %d by %d\n",xsize,ysize);

//	for(x=0;x<128;x++) {
//		for(y=0;y<64;y++) {
//			printf("%02X,",image[(y*xsize)+x]);
//		}
//		printf("\n");
//	}

	/* loading tiles */
	for(x=0;x<16;x++) {
		for(y=0;y<16;y++) {
			tiles[(y*16)+x][0][0]=image[((y*4+4)*xsize)+8+(x*4)];
			tiles[(y*16)+x][1][0]=image[((y*4+4)*xsize)+8+(x*4)+2];
			tiles[(y*16)+x][0][1]=image[((y*4+5)*xsize)+8+(x*4)];
			tiles[(y*16)+x][1][1]=image[((y*4+5)*xsize)+8+(x*4)+2];
			tiles[(y*16)+x][0][2]=image[((y*4+6)*xsize)+8+(x*4)];
			tiles[(y*16)+x][1][2]=image[((y*4+6)*xsize)+8+(x*4)+2];
			tiles[(y*16)+x][0][3]=image[((y*4+7)*xsize)+8+(x*4)];
			tiles[(y*16)+x][1][3]=image[((y*4+7)*xsize)+8+(x*4)+2];
		}
	}

	i=0;
	for(j=0;j<256;j++) {
		if ((tiles[j][0][0]!=0) ||
			(tiles[j][1][0]!=0) ||
			(tiles[j][0][1]!=0) ||
			(tiles[j][1][1]!=0) ||
			(tiles[j][0][2]!=0) ||
			(tiles[j][1][2]!=0) ||
			(tiles[j][0][3]!=0) ||
			(tiles[j][1][3]!=0)) {
				numtiles=j+1;
		}
	}

	printf("Found %d tiles\n",numtiles);

	if (ascii_output) {
	fprintf(outfile,"tiles:\n");
	for(i=0;i<numtiles;i++) {
		fprintf(outfile,"tile%02x:\t.byte ",i);
		fprintf(outfile,"$%02x,",tiles[i][0][0]+(tiles[i][0][1]<<4));
		fprintf(outfile,"$%02x,",tiles[i][1][0]+(tiles[i][1][1]<<4));
		fprintf(outfile,"$%02x,",tiles[i][0][2]+(tiles[i][0][3]<<4));
		fprintf(outfile,"$%02x" ,tiles[i][1][2]+(tiles[i][1][3]<<4));
		fprintf(outfile,"\n");
	}
	}
	else {
		for(i=0;i<256;i++) {
			fputc(tiles[i][0][0]+(tiles[i][0][1]<<4),outfile);
			fputc(tiles[i][1][0]+(tiles[i][1][1]<<4),outfile);
			fputc(tiles[i][0][2]+(tiles[i][0][3]<<4),outfile);
			fputc(tiles[i][1][2]+(tiles[i][1][3]<<4),outfile);
		}
	}

	if (ascii_output) fprintf(outfile,"\n");

	/* loading tilemap */

	/* starts at 80,12 */

	for(x=0;x<256;x++) {
		for(y=0;y<40;y++) {
			/* get temp tile */
			temp_tile[0][0]=image[((y*4+12)*xsize)+80+(x*4)];
			temp_tile[1][0]=image[((y*4+12)*xsize)+80+(x*4)+2];
			temp_tile[0][1]=image[((y*4+13)*xsize)+80+(x*4)];
			temp_tile[1][1]=image[((y*4+13)*xsize)+80+(x*4)+2];
			temp_tile[0][2]=image[((y*4+14)*xsize)+80+(x*4)];
			temp_tile[1][2]=image[((y*4+14)*xsize)+80+(x*4)+2];
			temp_tile[0][3]=image[((y*4+15)*xsize)+80+(x*4)];
			temp_tile[1][3]=image[((y*4+15)*xsize)+80+(x*4)+2];

			/* find tile */

			found_tile=-1;

			/* if all black, assume transparent */
			if ((temp_tile[0][0]==0) &&
				(temp_tile[1][0]==0) &&
				(temp_tile[0][1]==0) &&
				(temp_tile[1][1]==0) &&
				(temp_tile[0][2]==0) &&
				(temp_tile[1][2]==0) &&
				(temp_tile[0][3]==0) &&
				(temp_tile[1][3]==0)) {
				found_tile=0;
			}
			else for(i=0;i<numtiles;i++) {

				if ((temp_tile[0][0]==tiles[i][0][0]) &&
					(temp_tile[1][0]==tiles[i][1][0]) &&
					(temp_tile[0][1]==tiles[i][0][1]) &&
					(temp_tile[1][1]==tiles[i][1][1]) &&
					(temp_tile[0][2]==tiles[i][0][2]) &&
					(temp_tile[1][2]==tiles[i][1][2]) &&
					(temp_tile[0][3]==tiles[i][0][3]) &&
					(temp_tile[1][3]==tiles[i][1][3])) {
					found_tile=i;
					break;
				}
			}
			tilemap[x][y]=found_tile;
			if (found_tile==-1) {
				printf("Error!  Unknown tile at %d,%d\n",
					80+(x*4),12+(y*4));
			}
		}
	}

	if (ascii_output) {
		fprintf(outfile,"tilemap:\n");

		for(j=0;j<40;j++) {
			fprintf(outfile,"\t.byte ");
			for(i=0;i<256;i++) {
				fprintf(outfile,"$%02x",tilemap[i][j]);
				if (i!=255) fprintf(outfile,",");
			}
			fprintf(outfile,"\n");
		}

		fprintf(outfile,"\n");
	}
	else {
		for(j=0;j<40;j++) {
			for(i=0;i<256;i++) {
				fputc(tilemap[i][j],outfile);
			}
		}
	}
	fclose(outfile);

	return 0;
}
