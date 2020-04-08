#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <getopt.h>

/* Converts text to a GR image */
/* Why?  On Apple II GR is just a form of text */
/* Maybe it will compress better */

static int loadtext(char *filename, unsigned char **image_ptr,
	int *xsize, int *ysize, int inverse) {

	FILE *infile;
	char string[BUFSIZ];
	char *result;
	unsigned char *image;
	int width,height,x,y;

	x=0; y=0;

	width=40;
	height=24;

	*xsize=40;
	*ysize=24;

	image=calloc(width*height,sizeof(unsigned char));

	/* set to plain spaces */
	if (inverse) {
		memset(image,' '&0x3f,width*height);
	}
	else {
		memset(image,' '|0x80,width*height);
	}

	infile=fopen(filename,"rb");
	if (infile==NULL) {
		fprintf(stderr,"Error, could not open %s!\n",filename);
		return -1;
	}

	while(1) {
		result=fgets(string,BUFSIZ,infile);
		if (result==NULL) break;

		if (string[0]=='#') continue;

//		printf("%s",string);

		for(x=0;x<width;x++) {
			if ((string[x]=='\n') || (string[x]==0)) break;

			if (inverse) {
				if (string[x]=='~') {
					image[(y*width)+x]=' '|0x80;
				}
				else {
					image[(y*width)+x]=string[x]&0x3f;
				}
			}
			else {
				image[(y*width)+x]=string[x]|0x80;
			}
		}
		y++;
		if (y>=height) break;

	}

	fclose(infile);

	*image_ptr=image;

	return 0;
}

static int usage(char *name) {

	fprintf(stderr,"Usage:\t%s INFILE OUTFILE\n\n",name);
	exit(-1);
}

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int x,c;
	unsigned char out_buffer[1024];

	unsigned char *image;
	int xsize,ysize;
	FILE *outfile;
	int inverse=0;

	opterr=0;

	while ((c=getopt(argc,argv,"i"))!=-1) {
		switch(c) {
			case 'i':
				inverse=1;
				break;
			default:
				usage(argv[0]);
				break;
		}
	}

	if (argc-optind < 2) {
		usage(argv[0]);
	}

	outfile=fopen(argv[optind+1],"w");
	if (outfile==NULL) {
		fprintf(stderr,"Error!  Could not open %s\n",argv[2]);
		exit(-1);
	}

	if (loadtext(argv[optind],&image,&xsize,&ysize,inverse)<0) {
		fprintf(stderr,"Error loading text!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded text %d by %d\n",xsize,ysize);

	short gr_offsets[]={
		0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
		0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
		0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
	};

	memset(out_buffer,0,1024);
	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			out_buffer[(gr_offsets[row]-0x400)+col]=image[row*xsize+col];
		}
	}

	for(x=0;x<1024;x++) fputc( out_buffer[x],outfile);

	fclose(outfile);

	return 0;
}
