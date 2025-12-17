/* Convert 80x48 png image to two files to be loaded as Apple II DGR */
/* But makes a diff, for animation purposes */


#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "loadpng.h"


static short gr_offsets[]={
	0x400,0x480,0x500,0x580,0x600,0x680,0x700,0x780,
	0x428,0x4a8,0x528,0x5a8,0x628,0x6a8,0x728,0x7a8,
	0x450,0x4d0,0x550,0x5d0,0x650,0x6d0,0x750,0x7d0,
};

/* in even colors in AUX mem the colors are rotated right by one */
/* for some reason */
static unsigned char aux_colors[]={
	 0,	/* 0000 -> 0000 */
	 8,	/* 0001 -> 1000 */
	 1,	/* 0010 -> 0001 */
	 9,	/* 0011 -> 1001 */
	 2,	/* 0100 -> 0010 */
	10,	/* 0101 -> 1010 */
	 3,	/* 0110 -> 0011 */
	11,	/* 0111 -> 1011 */
	 4,	/* 1000 -> 0100 */
	12,	/* 1001 -> 1100 */
	 5,	/* 1010 -> 0101 */
	13,	/* 1011 -> 1101 */
	 6,	/* 1100 -> 0110 */
	14,	/* 1101 -> 1110 */
	 7,	/* 1110 -> 0111 */
	15	/* 1111 -> 1111 */
};
/* Converts a PNG to a GR file you can BLOAD to 0x400		*/
/* HOWEVER you *never* want to do this in real life		*/
/* as it will clobber important values in the memory holes	*/

int main(int argc, char **argv) {

	int row=0;
	int col=0;
	int temp_low,temp_high,temp_color;

	unsigned char aux_buffer1[1024];
	unsigned char aux_buffer2[1024];
	unsigned char main_buffer1[1024];
	unsigned char main_buffer2[1024];

	unsigned char *image;
	int xsize,ysize;

	if (argc<4) {
		fprintf(stderr,"Usage:\t%s FILE1 FILE2 BASE\n\n",argv[0]);
		exit(-1);
	}

	/* clear buffers */

	memset(main_buffer1,0,1024);
	memset(aux_buffer1,0,1024);
	memset(main_buffer2,0,1024);
	memset(aux_buffer2,0,1024);

	/* load image1 */

	if (loadpng(argv[1],&image,&xsize,&ysize,PNG_NO_ADJUST)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image1 %d by %d\n",xsize,ysize);



	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			/* note, the aux bytes are rotated right by 1 (!?) */
			temp_low=(image[row*xsize+(col*2)])&0xf;
			temp_high=(image[row*xsize+(col*2)]>>4)&0xf;
			temp_color=(aux_colors[temp_high]<<4)|
					(aux_colors[temp_low]);

			aux_buffer1[(gr_offsets[row]-0x400)+col]=temp_color;
			main_buffer1[(gr_offsets[row]-0x400)+col]=
						image[row*xsize+(col*2)+1];
		}
	}

	/* load image2 */

	if (loadpng(argv[2],&image,&xsize,&ysize,PNG_NO_ADJUST)<0) {
		fprintf(stderr,"Error loading png!\n");
		exit(-1);
	}

	fprintf(stderr,"Loaded image2 %d by %d\n",xsize,ysize);



	for(row=0;row<24;row++) {
		for(col=0;col<40;col++) {
			/* note, the aux bytes are rotated right by 1 (!?) */
			temp_low=(image[row*xsize+(col*2)])&0xf;
			temp_high=(image[row*xsize+(col*2)]>>4)&0xf;
			temp_color=(aux_colors[temp_high]<<4)|
					(aux_colors[temp_low]);

			aux_buffer2[(gr_offsets[row]-0x400)+col]=temp_color;
			main_buffer2[(gr_offsets[row]-0x400)+col]=
						image[row*xsize+(col*2)+1];
		}
	}

	int last_diff,diff_bytes,i,j,differences;
        int diff_start,in_diff,diff_diff,run_length;

	last_diff=0;
	diff_bytes=0;
	differences=0;
	diff_start=0;
	in_diff=0;
	diff_diff=0;
	run_length=0;

	/* print aux differences */

	printf("%s_aux_diff:\n",argv[3]);

        for(i=0;i<1024;i++) {
                if (aux_buffer1[i]!=aux_buffer2[i]) {
                        if (in_diff==0) {
                                diff_start=i;
                                in_diff=1;
                                diff_diff=i-last_diff;
                                last_diff=i;
                        }
                        else {

                        }
//                      fprintf(stderr,"; Difference at %x: %02x %02x\n",
//                              i,apple2_image1[i],apple2_image2[i]);
                        differences++;
                }

/* ended a diff */
                else if (in_diff) {
//                      printf("Diff ended: %x %x %x\n",
//                              diff_diff,diff_start,i);
                        run_length=i-diff_start;

                        if (run_length>254) {
                                fprintf(stderr,"FIXME!  Run too big %d!\n",run_length);
                                exit(-1);
                        }

                        printf(".byte $%02X,$%02X,$%02X",
                                run_length,diff_diff&0xff,(diff_diff>>8)&0xff);

                        diff_bytes+=3;

                        for(j=0;j<run_length;j++) {
                                printf(",$%02X",aux_buffer2[i-run_length+j]);
                                diff_bytes++;
                        }

                        printf("\n");
                        in_diff=0;
                }
        }
        printf(".byte $ff\n\n");


	/* print main differences */

	last_diff=0;
	diff_bytes=0;
	differences=0;
	diff_start=0;
	in_diff=0;
	diff_diff=0;
	run_length=0;


	printf("%s_main_diff:\n",argv[3]);

        for(i=0;i<1024;i++) {
                if (main_buffer1[i]!=main_buffer2[i]) {
                        if (in_diff==0) {
                                diff_start=i;
                                in_diff=1;
                                diff_diff=i-last_diff;
                                last_diff=i;
                        }
                        else {

                        }
//                      fprintf(stderr,"; Difference at %x: %02x %02x\n",
//                              i,apple2_image1[i],apple2_image2[i]);
                        differences++;
                }

/* ended a diff */
                else if (in_diff) {
//                      printf("Diff ended: %x %x %x\n",
//                              diff_diff,diff_start,i);
                        run_length=i-diff_start;

                        if (run_length>254) {
                                fprintf(stderr,"FIXME!  Run too big %d!\n",run_length);
                                exit(-1);
                        }

                        printf(".byte $%02X,$%02X,$%02X",
                                run_length,diff_diff&0xff,(diff_diff>>8)&0xff);

                        diff_bytes+=3;

                        for(j=0;j<run_length;j++) {
                                printf(",$%02X",main_buffer2[i-run_length+j]);
                                diff_bytes++;
                        }

                        printf("\n");
                        in_diff=0;
                }
        }
        printf(".byte $ff\n");



//      fprintf(stderr,"Total warnings: %d\n",color_warnings);
        fprintf(stderr,"Total differences: %d, %d bytes\n",
                        differences,diff_bytes);

        printf("; Total differences: %d, %d bytes\n",
                        differences,diff_bytes);



	return 0;
}
