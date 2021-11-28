#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include "dos33.h"

unsigned char dos33_file_type(int value) {

	unsigned char result;

	switch(value&0x7f) {
		case 0x0: result='T'; break;
		case 0x1: result='I'; break;
		case 0x2: result='A'; break;
		case 0x4: result='B'; break;
		case 0x8: result='S'; break;
		case 0x10: result='R'; break;
		case 0x20: result='N'; break;
		case 0x40: result='L'; break;
		default: result='?'; break;
	}
	return result;
}


unsigned char dos33_char_to_type(char type, int lock) {

	unsigned char result,temp_type;

	temp_type=type;
	/* Covert to upper case */
	if (temp_type>='a') temp_type=temp_type-0x20;

	switch(temp_type) {
		case 'T': result=0x0; break;
		case 'I': result=0x1; break;
		case 'A': result=0x2; break;
		case 'B': result=0x4; break;
		case 'S': result=0x8; break;
		case 'R': result=0x10; break;
		case 'N': result=0x20; break;
		case 'L': result=0x40; break;
		default: result=0x0;
	}
	if (lock) result|=0x80;
	return result;
}

	/* dos33 filenames have top bit set on ascii chars */
	/* and are padded with spaces */
char *dos33_filename_to_ascii(char *dest,unsigned char *src,int len) {

	int i=0,last_nonspace=0;

	for(i=0;i<len;i++) if (src[i]!=0xA0) last_nonspace=i;

	for(i=0;i<last_nonspace+1;i++) {
		dest[i]=src[i]^0x80; /* toggle top bit */
	}

	dest[i]='\0';
	return dest;
}

	/* Get a T/S value from a Catalog Sector */
static int dos33_get_catalog_ts(unsigned char *vtoc) {

	return TS_TO_INT(vtoc[VTOC_CATALOG_T],vtoc[VTOC_CATALOG_S]);
}

	/* returns the next valid catalog entry */
	/* after the one passed in */
static int dos33_find_next_file(int fd,int catalog_tsf,unsigned char *vtoc) {

	int catalog_track,catalog_sector,catalog_file;
	int file_track,i;
	int result;
	unsigned char sector_buffer[BYTES_PER_SECTOR];

	catalog_file=catalog_tsf>>16;
	catalog_track=(catalog_tsf>>8)&0xff;
	catalog_sector=(catalog_tsf&0xff);

	if (debug) {
		fprintf(stderr,"CATALOG FIND NEXT, "
			"CURRENT FILE=%X TRACK=%X SECTOR=%X\n",
			catalog_file,catalog_track,catalog_sector);
	}

catalog_loop:

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,BYTES_PER_SECTOR);
	if (result<0) {
		fprintf(stderr,"Error on I/O %s\n",strerror(errno));
		return -1;
	}

	i=catalog_file;
	while(i<7) {

		file_track=sector_buffer[CATALOG_FILE_LIST+
						(i*CATALOG_ENTRY_SIZE)];
		/* 0xff means file deleted */
		/* 0x0 means empty */
		if (debug) {
			if (file_track==0xff) fprintf(stderr,"\tFILE %d DELETED\n",i);
			if (file_track==0x00) fprintf(stderr,"\tFILE %d UNALLOCATED\n",i);
		}

		if ((file_track!=0xff) && (file_track!=0x0)) {
			if (debug) fprintf(stderr,"\tFOUND FILE %X TRACK $%X SECTOR $%X\n",i,catalog_track,catalog_sector);
			return ((i<<16)+(catalog_track<<8)+catalog_sector);
		}
		i++;
	}

	catalog_track=sector_buffer[CATALOG_NEXT_T];
	catalog_sector=sector_buffer[CATALOG_NEXT_S];

	if (debug) fprintf(stderr,"\tTRYING NEXT SECTOR T=$%X S=$%X\n",
		catalog_track,catalog_sector);

	/* FIXME: this wouldn't happen on 140k disks */
	/* but who knows if you're doing something fancy? */
	if ((catalog_track<0) || (catalog_track>40)) {
		return -1;
	}

	if (catalog_sector!=0) {
		catalog_file=0;
		goto catalog_loop;
	}



	return -1;
}

static int dos33_print_file_info(int fd,int catalog_tsf) {

	int catalog_track,catalog_sector,catalog_file,i;
	char temp_string[BUFSIZ];
	int result;
	unsigned char sector_buffer[BYTES_PER_SECTOR];

	catalog_file=catalog_tsf>>16;
	catalog_track=(catalog_tsf>>8)&0xff;
	catalog_sector=(catalog_tsf&0xff);

	if (debug) fprintf(stderr,"CATALOG FILE=%X TRACK=%X SECTOR=%X\n",
		catalog_file,catalog_track,catalog_sector);

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,BYTES_PER_SECTOR);

	if (sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]>0x7f) {
		printf("*");
	}
	else {
		printf(" ");
	}

	printf("%c",dos33_file_type(sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]));
	printf(" ");
	printf("%.3i ",sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE+FILE_SIZE_L)]+
		(sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE+FILE_SIZE_H)]<<8));

	dos33_filename_to_ascii(temp_string,sector_buffer+(CATALOG_FILE_LIST+
			(catalog_file*CATALOG_ENTRY_SIZE+FILE_NAME)),30);

	for(i=0;i<strlen(temp_string);i++) {
		if (temp_string[i]<0x20) {
			printf("^%c",temp_string[i]+0x40);
		}
		else {
			printf("%c",temp_string[i]);
		}
	}

	printf("\n");

	if (result<0) {
		fprintf(stderr,"Error on I/O\n");
		return -1;
	}

	return 0;
}

int dos33_catalog(int dos_fd, unsigned char *vtoc) {

	int catalog_entry;
	int result;

	/* get first catalog */
	catalog_entry=dos33_get_catalog_ts(vtoc);

	printf("\nDISK VOLUME %i\n\n",vtoc[VTOC_DISK_VOLUME]);
	while(catalog_entry>0) {
		catalog_entry=dos33_find_next_file(dos_fd,catalog_entry,vtoc);
		if (debug) fprintf(stderr,"CATALOG entry=$%X\n",catalog_entry);
		if (catalog_entry>0) {
			result=dos33_print_file_info(dos_fd,catalog_entry);
			if (result<0) return -1;
			/* why 1<<16 ? */
			catalog_entry+=(1<<16);
			/* dos33_find_next_file() handles wrapping issues */
		}
	}
	printf("\n");

	return 0;
}
