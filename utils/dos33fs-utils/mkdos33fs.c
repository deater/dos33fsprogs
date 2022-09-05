#include <stdio.h>
#include <string.h> /* strncpy() */
#include <fcntl.h>  /* open() */
#include <unistd.h> /* close() */
#include <stdlib.h> /* strtol() */
#include <errno.h>

#include "version.h"

#include "dos33.h"

int debug=0;

static void usage(char *binary,int help) {

	printf("\n%s - version %s\n",binary,VERSION);
	printf("\tby Vince Weaver <vince@deater.net>\n");
	printf("\thttp://www.deater.net/weave/vmwprod/apple/\n\n");
	if (help) {
		printf("Usage:\t%s [-t track] [-s sector] [-b size] "
			"[-d filename] [-f filename] device_name\n\n",binary);
		printf("\t-t tracks    : number of tracks (default is 35)\n");
		printf("\t-s sectors   : number of sectors (default is 16)\n");
		printf("\t-b blocksize : size of sector, in bytes (default is 256)\n");
		printf("\t-d filename  : file to copy first 3 tracks over from\n");
		printf("\t-f filename  : name of BASIC file to autoboot.  Default is HELLO\n");
		printf("\t-m maxfiles  : maximum files in CATALOG (default is 105)\n");
		printf("\t-n volume    : volume number (default is 254)\n");
		printf("\n\n");
	}
	exit(0);
	return;
}

int main(int argc, char **argv) {

	int num_tracks=35,num_sectors=16,sector_size=256;
	int max_files=105,catalog_track=17,vtoc_track=17,volume_number=254;
	int catalog_sectors,current_sector;
	int max_ts_pairs=255;
	int fd,dos_fd;
	char device[BUFSIZ],dos_src[BUFSIZ];
	unsigned char *vtoc_buffer=NULL,*sector_buffer=NULL;
	char *endptr;
	int i,c,copy_dos=0;
	int result;

	char boot_filename[30]="HELLO                         ";

	/* Parse Command Line Arguments */

	while ((c = getopt (argc, argv,"t:s:b:d:f:m:n:hv"))!=-1) {
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
				sector_size=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;

			case 'm':
				max_files=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;

			case 'n':
				volume_number=strtol(optarg,&endptr,10);
				if ( endptr == optarg ) usage(argv[0], 1);
				break;

			case 'd':
				copy_dos=1;
				strncpy(dos_src,optarg,BUFSIZ-1);
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

	strncpy(device,argv[optind],BUFSIZ-1);

	/***********************/
	/* Sanity check values */
	/***********************/

	/* sectors: 2->32  (limited by 4-byte bitfields) */
	if ((num_sectors<2) || (num_sectors>32)) {
		printf("Number of sectors must be >2 and <=32\n\n");
		goto end_of_program;
	}

	/* tracks 18-50 ->(sector_size-0x38)/4 */
	/* limited by VTOC room for freespace bitmap (which is $38 to $ff) */
	/* VOTC is always on track 17 so we need at least that many */
	/* though could double if we used the unused sector fields */
	if ((num_tracks<vtoc_track) || (num_tracks>(sector_size-0x38)/4)) {
		printf("Number of tracks must be >%d and <=%i\n\n",
			vtoc_track,(sector_size-0x38)/4);
		goto end_of_program;
	}

	/* sector_size 256->65536 (or 512 based on one byte t/s size field?) */
	if ((sector_size<256)||(sector_size>65536)) {
		printf("Block size must be >=256 and <65536\n\n");
		goto end_of_program;
	}

	/* allocate space for buffers */
	vtoc_buffer=calloc(1,sizeof(char)*sector_size);
	if (vtoc_buffer==NULL) {
		fprintf(stderr,"Error allocating memory!\n");
		goto end_of_program;
	}

	sector_buffer=calloc(1,sizeof(char)*sector_size);
	if (sector_buffer==NULL) {
		fprintf(stderr,"Error allocating memory!\n");
		goto end_of_program;
	}


	/* Open device */
	fd=open(device,O_RDWR|O_CREAT,0666);
	if (fd<0) {
		fprintf(stderr,"Error opening %s (%s)\n",
			device,strerror(errno));
		goto end_of_program;
	}

	/* zero out file */
	for(i=0;i<num_tracks*num_sectors;i++) {
		result=write(fd,vtoc_buffer,sector_size);
	}

	/**************************/
	/* Calculating Paramaters */
	/**************************/

	if (volume_number>255) {
		printf("Warning!  Truncating volume number %d to %d\n",
			volume_number,volume_number&0xff);
		volume_number&=0xff;
	}

	if (catalog_track>num_tracks) {
		printf("Warning!  Catalog track too high!  Adjusting...\n");
		catalog_track=(num_tracks/2)+1;
	}

	if (vtoc_track>num_tracks) {
		printf("Warning!  VTOC track too high!  Adjusting...\n");
		vtoc_track=(num_tracks/2)+1;
	}

	if (vtoc_track!=17) {
		printf("Warning!  VTOC track is %d, not 17, so unpatched DOS won't be able to find it!\n",
			vtoc_track);
	}

	max_ts_pairs=((sector_size-0xc)/2);
	if (max_ts_pairs>255) {
		printf("Warning!  Truncating max_ts pairs to 255\n");
		max_ts_pairs=255;
	}

	catalog_sectors=max_files/7;
	if (max_files%7) catalog_sectors++;
	if (catalog_sectors>num_sectors-1) {
		printf("Warning! num_files leads to too many sectors %d, max is %d\n",catalog_sectors,num_sectors-1);
		catalog_sectors=num_sectors-1;
	}

	/***************/
	/* Create VTOC */
	/***************/

	/* fake dos 3.3 */
	vtoc_buffer[VTOC_DOS_RELEASE]=0x3;

	/* 1st Catalog typically at 0x11/0xf */
	vtoc_buffer[VTOC_CATALOG_T]=catalog_track;
	vtoc_buffer[VTOC_CATALOG_S]=num_sectors-1;

	/* typically volume is 254 */
	vtoc_buffer[VTOC_DISK_VOLUME]=volume_number;

	/* Number of T/S pairs fitting */
	/* in a T/S list sector */
	/* Note, overflows if sector_size>524 */
	vtoc_buffer[VTOC_MAX_TS_PAIRS]=max_ts_pairs;

	/* last track space was allocated on */
	/* so filesystem can try to do things in order */
	/* also start at catalog track and work our way outward */
	vtoc_buffer[VTOC_LAST_ALLOC_T]=catalog_track+1;
	vtoc_buffer[VTOC_ALLOC_DIRECT]=1;

	vtoc_buffer[VTOC_NUM_TRACKS]=num_tracks;
	vtoc_buffer[VTOC_S_PER_TRACK]=num_sectors;
	vtoc_buffer[VTOC_BYTES_PER_SL]=sector_size&0xff;
	vtoc_buffer[VTOC_BYTES_PER_SH]=(sector_size>>8)&0xff;

	/* Set sector bitmap so whole disk is free */
	for(i=0;i<num_tracks;i++) {
		vtoc_buffer[VTOC_FREE_BITMAPS+(i*4)]=0xff;
		vtoc_buffer[VTOC_FREE_BITMAPS+(i*4)+1]=0xff;
		if (num_sectors>16) {
			vtoc_buffer[VTOC_FREE_BITMAPS+(i*4)+2]=0xff;
			vtoc_buffer[VTOC_FREE_BITMAPS+(i*4)+3]=0xff;
		}
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
			result=read(dos_fd,sector_buffer,sector_size);
			result=write(fd,sector_buffer,sector_size);
		}
		close(dos_fd);

		/* Set boot filename */

		/* Track 1 sector 9 */
		lseek(fd,((1*num_sectors)+9)*sector_size,SEEK_SET);
		result=read(fd,sector_buffer,sector_size);

		/* filename begins at offset 75 */
		for(i=0;i<30;i++) {
			sector_buffer[0x75+i]=boot_filename[i]|0x80;
		}
		lseek(fd,((1*num_sectors)+9)*sector_size,SEEK_SET);
		result=write(fd,sector_buffer,sector_size);

		/* if copying dos reserve tracks 1 and 2 as well */
		for(i=0;i<num_sectors;i++) {
			dos33_vtoc_reserve_sector(vtoc_buffer, 1, i);
		}
		/* free some room as DOS doesn't use all */
		/* of track 2, only sectors 0-4 */
		dos33_vtoc_reserve_sector(vtoc_buffer, 2, 0);
		dos33_vtoc_reserve_sector(vtoc_buffer, 2, 1);
		dos33_vtoc_reserve_sector(vtoc_buffer, 2, 2);
		dos33_vtoc_reserve_sector(vtoc_buffer, 2, 3);
		dos33_vtoc_reserve_sector(vtoc_buffer, 2, 4);

	}


	/* reserve track 0 */
	/* No user data can be stored here as track=0 is used */
	/*   as a special-case end of file indicator */
	for(i=0;i<num_sectors;i++) {
		dos33_vtoc_reserve_sector(vtoc_buffer, 0, i);
	}

	/********************/
	/* reserve the VTOC */
	/********************/
	dos33_vtoc_reserve_sector(vtoc_buffer, vtoc_track, 0);

	/*****************/
	/* Setup Catalog */
	/*****************/

	/* clear buffer */
	memset(sector_buffer,0,sector_size);

	/* Set catalog next pointers */
	for(i=0;i<catalog_sectors;i++) {
		/* point to next */
		/* for first sector_size-1 walk backwards from T17S15 */
		/* if more, allocate room on disk??? */
		/* Max on 140k disk is 280 or so */

		current_sector=num_sectors-i-1;

		if (i==catalog_sectors-1) {
			/* last one, pointer is to 0,0 */
			sector_buffer[1]=0;
			sector_buffer[2]=0;
		}
		else {
			printf("Writing $%02X,$%02X=%d,%d\n",
				catalog_track,current_sector,
				catalog_track,current_sector-1);
			sector_buffer[1]=catalog_track;
			sector_buffer[2]=current_sector-1;
		}

		/* reserve */
		dos33_vtoc_reserve_sector(vtoc_buffer,
			catalog_track, current_sector);

		lseek(fd,((catalog_track*num_sectors)+current_sector)*
			sector_size,SEEK_SET);
		result=write(fd,sector_buffer,sector_size);
		if (result!=sector_size) {
			fprintf(stderr,"Error writing catalog sector %d! (%s)\n",
				current_sector,strerror(errno));

		}
	}

	/**************************/
	/* Write out VTOC to disk */
	/**************************/
	lseek(fd,((vtoc_track*num_sectors)+0)*sector_size,SEEK_SET);

	result=write(fd,vtoc_buffer,sector_size);
	if (result<0) {
		fprintf(stderr,"Error writing VTOC (%s)!\n",strerror(errno));
	}



	close(fd);

end_of_program:
	if (vtoc_buffer) free(vtoc_buffer);
	if (sector_buffer) free(sector_buffer);

	return 0;
}
