#include <stdio.h>
#include <string.h> /* strncpy() */
#include <fcntl.h>  /* open() */
#include <unistd.h> /* close() */
#include <stdlib.h> /* strtol() */
#include "version.h"

#include "dos33.h"

static void usage(char *binary,int help) {

	printf("\n%s - version %s\n",binary,VERSION);
	printf("\tby Vince Weaver <vince@deater.net>\n");
	printf("\thttp://www.deater.net/weave/vmwprod/apple/\n\n");
	if (help) {
		printf("Usage:\t%s [-t track] [-s sector] [-b size] "
			"[-d filename] [-f filename] device_name\n\n",binary);
		printf("\t-t tracks    : number of tracks in filesystem\n");
		printf("\t-s sectors   : number of sectors in filesystem\n");
		printf("\t-b blocksize : size of sector, in bytes\n");
		printf("\t-d filename  : file to copy first 3 tracks over from\n");
		printf("\t-f filename  : name of BASIC file to autoboot.  Default is HELLO\n");
		printf("\n\n");
	}
	exit(0);
	return;
}

int main(int argc, char **argv) {

	int num_tracks=35,num_sectors=16,block_size=256;
	int fd,dos_fd;
	char device[BUFSIZ],dos_src[BUFSIZ];
	char *buffer,*endptr;
	int i,c,copy_dos=0;
	int result;

	char boot_filename[30]="HELLO                         ";

	/* Parse Command Line Arguments */

	while ((c = getopt (argc, argv,"t:s:b:d:f:hv"))!=-1) {
		switch (c) {

			case 't':
				num_tracks=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;

			case 's':
				num_sectors=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;

			case 'b':
				block_size=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;
			case 'd':
				copy_dos=1;
				strncpy(dos_src,optarg,BUFSIZ);
				break;
			case 'f':
				if (strlen(optarg)>30) {
					fprintf(stderr,"Auto boot filename too long!\n");
					exit(1);
				}
				memcpy(boot_filename,optarg,strlen(optarg));
				for(i=strlen(optarg);i<30;i++) boot_filename[i]=' ';
//				printf("Writing boot filename \"%s\"\n",boot_filename);
				break;
			case 'v': usage(argv[0],0);
			case 'h': usage(argv[0],1);
		}
	}

	if (optind==argc) {
		printf("Error!  Must include device name\n\n");
		goto end_of_program;
	}

	strncpy(device,argv[optind],BUFSIZ);

	/* Sanity check values */

	/* s 2->32  (limited by 4-byte bitfields) */
	if ((num_sectors<2) || (num_sectors>32)) {
		printf("Number of sectors must be >2 and <=32\n\n");
		goto end_of_program;
	}

	/* t 17->(block_size-0x38)/2 */
	if ((num_tracks<18) || (num_tracks>(block_size-0x38)/2)) {
		printf("Number of tracks must be >18 and <=%i (block_size-0x38)/2\n\n",
			(block_size-0x38)/2);
		goto end_of_program;
	}

	/* sector_size 256->65536 (or 512 basedon one bye t/s size field?) */
	if ((block_size<256)||(block_size>65536)) {
		printf("Block size must be >=256 and <65536\n\n");
		goto end_of_program;
	}

	buffer=calloc(1,sizeof(char)*block_size);

       /* Open device */
	fd=open(device,O_RDWR|O_CREAT,0666);
	if (fd<0) {
		fprintf(stderr,"Error opening %s\n",device);
		goto end_of_program;
	}

	/* zero out file */
	for(i=0;i<num_tracks*num_sectors;i++) {
		result=write(fd,buffer,block_size);
	}

	/* Copy over OS from elsewhere, if desired */
	if (copy_dos) {
		dos_fd=open(dos_src,O_RDONLY);
		if (fd<0) {
			fprintf(stderr,"Error opening %s\n",dos_src);
			goto end_of_program;
		}
		lseek(fd,0,SEEK_SET);
		/* copy first 3 sectors */
		for(i=0;i<3*(num_sectors);i++) {
			result=read(dos_fd,buffer,block_size);
			result=write(fd,buffer,block_size);
		}
		close(dos_fd);

		/* Set boot filename */

		/* Track 1 sector 9 */
		lseek(fd,((1*num_sectors)+9)*block_size,SEEK_SET);
		result=read(fd,buffer,block_size);

		/* filename begins at offset 75 */
		for(i=0;i<30;i++) {
			buffer[0x75+i]=boot_filename[i]|0x80;
		}
		lseek(fd,((1*num_sectors)+9)*block_size,SEEK_SET);
		result=write(fd,buffer,block_size);
	}

	/* clear buffer */
	for(i=0;i<block_size;i++) buffer[i]=0;

	/* Create VTOC */
	buffer[VTOC_DOS_RELEASE]=0x3;	/* fake dos 3.3 */
	buffer[VTOC_CATALOG_T]=0x11;
	buffer[VTOC_CATALOG_S]=num_sectors-1;
					/* 1st Catalog typically at 0x11/0xf */
	buffer[VTOC_DISK_VOLUME]=254;	/* typical volume 254 */
	buffer[VTOC_MAX_TS_PAIRS]=((block_size-0xc)/2)&0xff;
					/* Number of T/S pairs fitting */
					/* in a T/S list sector */
					/* Note, overflows if block_size>524 */
	buffer[VTOC_LAST_ALLOC_T]=0x12;	/* last track space was allocated */
					/* Start at middle, work way out  */
	buffer[VTOC_ALLOC_DIRECT]=1;	/* Working our way outward */
	buffer[VTOC_NUM_TRACKS]=num_tracks;
	buffer[VTOC_S_PER_TRACK]=num_sectors;
	buffer[VTOC_BYTES_PER_SL]=block_size&0xff;
	buffer[VTOC_BYTES_PER_SH]=(block_size>>8)&0xff;

	/* Set sector bitmap so whole disk is free */
	for(i=VTOC_FREE_BITMAPS;i<block_size;i+=4) {
		buffer[i]=0xff;
		buffer[i+1]=0xff;
		if (num_sectors>16) {
			buffer[i+2]=0xff;
			buffer[i+3]=0xff;
		}
	}

	/* reserve track 0 */
	/* No user data can be stored here as track=0 is special case */
	/* end of file indicator */
	buffer[VTOC_FREE_BITMAPS]=0x00;
	buffer[VTOC_FREE_BITMAPS+1]=0x00;
	buffer[VTOC_FREE_BITMAPS+2]=0x00;
	buffer[VTOC_FREE_BITMAPS+3]=0x00;

	/* if copying dos reserve tracks 1 and 2 as well */
	if (copy_dos) {
		buffer[VTOC_FREE_BITMAPS+4]=0x00;
		buffer[VTOC_FREE_BITMAPS+5]=0x00;
		buffer[VTOC_FREE_BITMAPS+6]=0x00;
		buffer[VTOC_FREE_BITMAPS+7]=0x00;
		buffer[VTOC_FREE_BITMAPS+8]=0x00;
		buffer[VTOC_FREE_BITMAPS+9]=0x00;
		buffer[VTOC_FREE_BITMAPS+10]=0x00;
		buffer[VTOC_FREE_BITMAPS+11]=0x00;
	}

	/* reserve track 17 (0x11) */
	/* reserved for vtoc and catalog stuff */
	buffer[VTOC_FREE_BITMAPS+17*4]=0x00;
	buffer[VTOC_FREE_BITMAPS+17*4+1]=0x00;
	buffer[VTOC_FREE_BITMAPS+17*4+2]=0x00;
	buffer[VTOC_FREE_BITMAPS+17*4+3]=0x00;

	/* Write out VTOC to disk */
	lseek(fd,((17*num_sectors)+0)*block_size,SEEK_SET);

	result=write(fd,buffer,block_size);
	if (result<0) fprintf(stderr,"Error writing!\n");

	/* clear buffer */
	for(i=0;i<block_size;i++) buffer[i]=0;
	/* Set catalog next pointers */
	for(i=(num_sectors-1);i>1;i--) {
		buffer[1]=0x11;
		buffer[2]=i-1;

		lseek(fd,((17*num_sectors)+i)*block_size,SEEK_SET);
		result=write(fd,buffer,block_size);
		if (result<0) fprintf(stderr,"Error writing!\n");
	}

	close(fd);

end_of_program:
	return 0;
}
