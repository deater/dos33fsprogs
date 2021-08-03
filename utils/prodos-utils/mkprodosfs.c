#include <stdio.h>
#include <string.h> /* strncpy() */
#include <fcntl.h>  /* open() */
#include <unistd.h> /* close() */
#include <stdlib.h> /* strtol() */
#include <errno.h>
#include <time.h>

#include "version.h"

#include "prodos.h"

int debug=0;

static int ones_lookup[8]={
	0x80, 0xC0, 0xE0, 0xF0, 0xF8, 0xFC, 0xFE, 0xFF,
};

static void usage(char *binary,int help) {

	printf("\n%s - version %s\n",binary,VERSION);
	printf("\tby Vince Weaver <vince@deater.net>\n");
	printf("\thttp://www.deater.net/weave/vmwprod/apple/\n\n");
	if (help) {
		printf("Usage:\t%s [-b size] [-i interleave] "
			"[-s bootsector] device_name\n\n",binary);
		printf("\t-b size       : size of image, in 512B blocks\n");
		printf("\t-i interleave : PRODOS (default) or DOS33\n");
		printf("\t-s filename   : bootsector\n");
		printf("\t-n volume     : volume name\n");
		printf("\n\n");
	}
	exit(0);
	return;
}

int main(int argc, char **argv) {

	int num_blocks=280;
	int fd;
	char device[BUFSIZ];
	char *endptr;
	int i,j,c;
	int result;
	unsigned char data_buffer[PRODOS_BYTES_PER_BLOCK];
	struct voldir_t voldir;
	char volname[PRODOS_VOLNAME_LEN];
	int volname_len;
	int interleave=PRODOS_INTERLEAVE_PRODOS;
	int num_voldirs=4,num_bitmaps,num_bitmap_blocks,ones_to_write;

	strncpy(volname,"EMPTY",6);
	volname_len=strlen(volname);

	/* Parse Command Line Arguments */

	while ((c = getopt (argc, argv,"b:i:s:n:hv"))!=-1) {
		switch (c) {
			case 'b':
				num_blocks=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;
			case 'i':
				if (!strncasecmp(optarg,"prodos",6)) {
					interleave=PRODOS_INTERLEAVE_PRODOS;
				}
				else if (!strncasecmp(optarg,"dos33",5)) {
					interleave=PRODOS_INTERLEAVE_DOS33;
				}
				else {
					fprintf(stderr,"Error!  Unknown interleave: %s\n",optarg);
				}
	                        break;
			case 's':
				fprintf(stderr,"Error!  -s not implemented yet!\n");
				break;
			case 'n':
				memset(volname,0,sizeof(volname));
				volname_len=strlen(optarg);
				if (volname_len>PRODOS_VOLNAME_LEN) {
					fprintf(stderr,"Volname: %s is too long!\n",optarg);
					return -1;
				}
				memcpy(volname,optarg,volname_len);
				break;
			case 'v': usage(argv[0],0);
			case 'h': usage(argv[0],1);
		}
	}

	if (optind==argc) {
		printf("Error!  Must include device name\n\n");
		goto end_of_program;
	}

	strncpy(device,argv[optind],BUFSIZ-1);

	/***********************/
	/* Sanity check values */
	/***********************/

	/* sectors: 2->32  (limited by 4-byte bitfields) */
	if ((num_blocks<6) || (num_blocks>65536)) {
		printf("Number of blocks must be >2 and <65536\n\n");
		goto end_of_program;
	}

	/* Open device */
	fd=open(device,O_RDWR|O_CREAT,0666);
	if (fd<0) {
		fprintf(stderr,"Error opening %s (%s)\n",
			device,strerror(errno));
		goto end_of_program;
	}


	/*****************/
	/* init voldir   */
	/*****************/

	memset(&voldir,0,sizeof(struct voldir_t));

	voldir.fd=fd;
	voldir.interleave=interleave;
	voldir.image_offset=0;
	voldir.storage_type=PRODOS_FILE_VOLUME_HDR;
	voldir.name_length=volname_len;
	memcpy(voldir.volume_name,volname,volname_len);
	voldir.total_blocks=num_blocks;
	voldir.version=0;
	voldir.min_version=0;
	voldir.access=0xc3;	// FIXME
	voldir.entry_length=0x27;
	voldir.entries_per_block=13;

	voldir.bit_map_pointer=6;

	voldir.creation_time=prodos_time(time(NULL));

	voldir.file_count=0;

	voldir.next_block=3;

	/******************/
	/* clear out data */
	/******************/

	memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);

	/* create image */
	for(i=0;i<num_blocks;i++) {
		result=prodos_write_block(&voldir,data_buffer,i);
		if (result<0) {
			fprintf(stderr,"Error writing!\n");
			return -1;
		}

	}


	/*********************************/
	/* create the voldirs		 */
	/*********************************/
	for(i=0;i<num_voldirs;i++) {
		memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);
		/* prev */
		if (i>0) {
			data_buffer[0]=(PRODOS_VOLDIR_KEY_BLOCK+i-1)&0xff;
			data_buffer[1]=(PRODOS_VOLDIR_KEY_BLOCK+i-1)>>8;
		}
		/* next */
		if (i<num_voldirs-1) {
			data_buffer[2]=(PRODOS_VOLDIR_KEY_BLOCK+i+1)&0xff;
			data_buffer[3]=(PRODOS_VOLDIR_KEY_BLOCK+i+1)>>8;
		}
		result=prodos_write_block(&voldir,data_buffer,i+PRODOS_VOLDIR_KEY_BLOCK);
	}

	/*********************************/
	/* create the bitmaps		 */
	/*********************************/
	num_bitmaps=num_blocks/8;
	num_bitmap_blocks=1+((num_bitmaps-1)/512);

	for(i=0;i<num_bitmap_blocks;i++) {
		memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);

		if (i*512*8>num_blocks) {
			ones_to_write=512;
		}
		else {
			ones_to_write=num_blocks%(512*8);
		}

		if (debug) printf("Writing %d ones\n",ones_to_write);

		for(j=0;j<ones_to_write/8;j++) {
			data_buffer[j]=0xff;
		}
		if (ones_to_write%8) {
			data_buffer[j]=ones_lookup[ones_to_write%8];
		}

		result=prodos_write_block(&voldir,data_buffer,
			PRODOS_VOLDIR_KEY_BLOCK+num_voldirs+i);

		if (debug) printf("Wrote bitmap to block $%X\n",
			PRODOS_VOLDIR_KEY_BLOCK+num_voldirs+i);

		if (result<0) {
			fprintf(stderr,"Error writing!\n");
			return -1;
		}
	}

	/*********************************/
	/* reserve all of the used space */
	/*********************************/

	prodos_voldir_reserve_block(&voldir,0);	// boot sector
	prodos_voldir_reserve_block(&voldir,1);	// SOS boot sector
	for(i=0;i<num_voldirs;i++) {
		prodos_voldir_reserve_block(&voldir,
			PRODOS_VOLDIR_KEY_BLOCK+i); // 2..5
	}
	for(i=0;i<num_bitmap_blocks;i++) {
		prodos_voldir_reserve_block(&voldir,
			PRODOS_VOLDIR_KEY_BLOCK+num_voldirs+i); // 6
	}

	/*********************************/
	/* write out voldir              */
	/*********************************/
	prodos_sync_voldir(&voldir);

	close(fd);

end_of_program:

	return 0;
}
