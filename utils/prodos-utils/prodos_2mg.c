#include <stdio.h>
#include <string.h>
#include <time.h>

#include "prodos.h"

/* https://gswv.apple2.org.za/a2zine/Docs/DiskImage_2MG_Info.txt */

int create_2mg_header(unsigned char *header_2mg,int num_blocks) {

	int data_bytes=num_blocks*512;

	/* clear all to zero */
	memset(header_2mg,0,64);

	/* magic number */
	header_2mg[0]='2';
	header_2mg[1]='I';
	header_2mg[2]='M';
	header_2mg[3]='G';

	/* our creation tool magic */
	header_2mg[4]='V';
	header_2mg[5]='M';
	header_2mg[6]='W';
	header_2mg[7]='!';

	/* header size (64 bytes) */
	header_2mg[8]=0x40;
	header_2mg[9]=0x00;

	/* version number */
	header_2mg[10]=1;
	header_2mg[11]=0;

	/* prodos sector order */
	/* TODO: should be configurable */
	header_2mg[12]=1;
	header_2mg[13]=0;
	header_2mg[14]=0;
	header_2mg[15]=0;

	/* flags */
	/* TODO: we should implement these for floppy images */
	header_2mg[16]=0;
	header_2mg[17]=0;
	header_2mg[18]=0;
	header_2mg[19]=0;

	/* prodos blocks */
	header_2mg[20]=num_blocks%256;
	header_2mg[21]=num_blocks/256;
	header_2mg[22]=0;
	header_2mg[23]=0;

	/* offset to disk data */
	header_2mg[24]=0x40;
	header_2mg[25]=0;
	header_2mg[26]=0;
	header_2mg[27]=0;

	/* bytes of disk data */
	header_2mg[28]=(data_bytes&0xff);
	header_2mg[29]=(data_bytes>>8)&0xff;
	header_2mg[30]=(data_bytes>>16)&0xff;
	header_2mg[31]=(data_bytes>>24)&0xff;

	/* we don't set any of the additional fields */

	return 0;

}

int read_2mg_header(unsigned char *header_2mg,
	int *num_blocks,
	int *interleave,
	int *offset,
	int debug) {

	int image_format;
	unsigned char magic[4];

	memcpy(magic,&header_2mg[0],4);

	if (memcmp(magic,"2IMG",4)!=0) {
		if (debug) printf("Unknown magic %c%c%c%c\n",
			magic[0],magic[1],magic[2],magic[3]);
		return -PRODOS_ERROR_BAD_MAGIC;
	}

	*num_blocks= (header_2mg[20])|
				(header_2mg[21]<<8)|
				(header_2mg[22]<<16)|
				(header_2mg[23]<<24);

	*offset= (header_2mg[24])|
			(header_2mg[25]<<8)|
			(header_2mg[26]<<16)|
			(header_2mg[27]<<24);

	image_format=(header_2mg[12])|
			(header_2mg[13]<<8)|
			(header_2mg[14]<<16)|
			(header_2mg[15]<<24);

	if (image_format==0) {
		*interleave=PRODOS_INTERLEAVE_DOS33;
	}
	else if (image_format==1) {
		*interleave=PRODOS_INTERLEAVE_PRODOS;
	}
	else {
		fprintf(stderr,"Unsupported 2MG format\n");
		return -PRODOS_ERROR_INTERLEAVE;
	}

	if (debug) {

		printf("Detected 2MG format\n");

		printf("magic: %c%c%c%c\n",
			header_2mg[0],
			header_2mg[1],
			header_2mg[2],
			header_2mg[3]);

		printf("creator: %c%c%c%c\n",
			header_2mg[4],
			header_2mg[5],
			header_2mg[6],
			header_2mg[7]);

		printf("Header size: %d\n",(header_2mg[8]|(header_2mg[9]<<8)));

		printf("Version: %d\n",(header_2mg[10]|(header_2mg[11]<<8)));

		printf("Flags: $%X\n",(header_2mg[16])|
				(header_2mg[17]<<8)|
				(header_2mg[18]<<16)|
				(header_2mg[19]<<24));

		printf("ProDOS blocks: $%X (%d)\n",
					*num_blocks,*num_blocks);

		printf("Image offset: $%X\n",*offset);

		printf("Bytes of data: %d\n",
					(header_2mg[28])|
					(header_2mg[29]<<8)|
					(header_2mg[30]<<16)|
					(header_2mg[31]<<24));

		printf("Offset to comment: $%X\n",
					(header_2mg[32])|
					(header_2mg[33]<<8)|
					(header_2mg[34]<<16)|
					(header_2mg[35]<<24));

		printf("Length of comment: %d\n",
					(header_2mg[36])|
					(header_2mg[37]<<8)|
					(header_2mg[38]<<16)|
					(header_2mg[39]<<24));

		printf("Offset to creator comment: $%X\n",
					(header_2mg[40])|
					(header_2mg[41]<<8)|
					(header_2mg[42]<<16)|
					(header_2mg[43]<<24));

		printf("Length of creator comment: %d\n",
					(header_2mg[44])|
					(header_2mg[45]<<8)|
					(header_2mg[46]<<16)|
					(header_2mg[47]<<24));
	}

	return 0;
}
