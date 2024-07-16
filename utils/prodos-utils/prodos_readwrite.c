#include <stdio.h>
#include <stdlib.h>   /* exit()    */
#include <string.h>   /* strncpy() */
#include <sys/stat.h> /* struct stat */
#include <fcntl.h>    /* O_RDONLY */
#include <unistd.h>   /* lseek() */
#include <ctype.h>    /* toupper() */
#include <errno.h>

#include "version.h"

#include "prodos.h"

extern int debug;

/* we want block 2 -> 0xb */
static int dos_interleave[16]= {
//	0,7,14,6,13,5,12,4,11,3,10,2,9,1,8,15,
	0,14,13,12,11,10,9,8,7,6,5,4,3,2,1,15,
};
		/*  0, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 15 */

		/*  ?? 0 7 14 6 13 5 12 4 11 3 10 2 9 1 8 15 */

int prodos_read_block(struct voldir_t *voldir,
			unsigned char *block, int blocknum) {

	int result=0;
	int track,sector1,sector2;

	if (voldir->interleave==PRODOS_INTERLEAVE_PRODOS) {

		/* Seek to VOLDIR */
		lseek(voldir->fd,voldir->image_offset+
				blocknum*PRODOS_BYTES_PER_BLOCK,SEEK_SET);
		result=read(voldir->fd,block,PRODOS_BYTES_PER_BLOCK);

		if (result<PRODOS_BYTES_PER_BLOCK) {
			fprintf(stderr,"Error reading block $%X\n",blocknum);
			return -1;
		}
	}
	else if (voldir->interleave==PRODOS_INTERLEAVE_DOS33) {
		if (debug) printf("\tUsing DOS33 interleave, finding block $%X\n",blocknum);
		track=(blocknum>>3);
		sector1=dos_interleave[(blocknum&0x7)*2];
		sector2=dos_interleave[(blocknum&0x7)*2+1];
		if (debug) printf("\tRemapping block $%X to T%d S%d and T%d S%d\n",
			blocknum,track,sector1,track,sector2);

		if (debug) printf("\tSeeking to %x\n",((track<<4)+sector1)*256);
		lseek(voldir->fd,voldir->image_offset+
				((track<<4)+sector1)*256,SEEK_SET);
		result=read(voldir->fd,block,PRODOS_BYTES_PER_BLOCK/2);

		if (result<PRODOS_BYTES_PER_BLOCK/2) {
			fprintf(stderr,"Error reading block $%X (%X)\n",
				blocknum,((track<<4)+sector1));
			return -1;
		}

		if (debug) printf("\tSeeking to %x\n",((track<<4)+sector2)*256);
		lseek(voldir->fd,voldir->image_offset+
				((track<<4)+sector2)*256,SEEK_SET);
		result=read(voldir->fd,block+256,PRODOS_BYTES_PER_BLOCK/2);

		if (result<PRODOS_BYTES_PER_BLOCK/2) {
			fprintf(stderr,"Error reading block $%X (%X)\n",
				blocknum,((track<<4)+sector2));
			return -1;
		}

	}
	else {
		fprintf(stderr,"ERROR!  Unknown interleave!\n");
	}


	return 0;
}




int prodos_write_block(struct voldir_t *voldir,
			unsigned char *block, int blocknum) {

	int result=0;
	int track,sector1,sector2;

	if (voldir->interleave==PRODOS_INTERLEAVE_PRODOS) {

		/* Seek to VOLDIR */
		lseek(voldir->fd,voldir->image_offset+
				blocknum*PRODOS_BYTES_PER_BLOCK,SEEK_SET);
		result=write(voldir->fd,block,PRODOS_BYTES_PER_BLOCK);

		if (result<PRODOS_BYTES_PER_BLOCK) {
			fprintf(stderr,"Error writing block $%X\n",blocknum);
			return -1;
		}
	}
	else if (voldir->interleave==PRODOS_INTERLEAVE_DOS33) {
		if (debug) printf("\tUsing DOS33 interleave, finding block $%X\n",blocknum);
		track=(blocknum>>3);
		sector1=dos_interleave[(blocknum&0x7)*2];
		sector2=dos_interleave[(blocknum&0x7)*2+1];
		if (debug) printf("\tRemapping block $%X to T%d S%d and T%d S%d\n",
			blocknum,track,sector1,track,sector2);

		if (debug) printf("\tSeeking to %x\n",((track<<4)+sector1)*256);
		lseek(voldir->fd,voldir->image_offset+
				((track<<4)+sector1)*256,SEEK_SET);
		result=write(voldir->fd,block,PRODOS_BYTES_PER_BLOCK/2);

		if (result<PRODOS_BYTES_PER_BLOCK/2) {
			fprintf(stderr,"Error writing block $%X (%X)\n",
				blocknum,((track<<4)+sector1));
			return -1;
		}

		if (debug) printf("\tSeeking to %x\n",((track<<4)+sector2)*256);
		lseek(voldir->fd,voldir->image_offset+
				((track<<4)+sector2)*256,SEEK_SET);
		result=write(voldir->fd,block+256,PRODOS_BYTES_PER_BLOCK/2);

		if (result<PRODOS_BYTES_PER_BLOCK/2) {
			fprintf(stderr,"Error writing block $%X (%X)\n",
				blocknum,((track<<4)+sector2));
			return -1;
		}

	}
	else {
		fprintf(stderr,"ERROR!  Unknown interleave!\n");
	}


	return 0;
}


