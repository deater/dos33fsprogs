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

#if 0
static int debug=0,ignore_errors=0;

static unsigned char get_high_byte(int value) {
	return (value>>8)&0xff;
}

static unsigned char get_low_byte(int value) {
	return (value&0xff);
}
#endif

int prodos_read_block(struct voldir_t *voldir,
			unsigned char *block, int blocknum) {

	int result;

	/* Note, we need to handle interleave, etc */
	/* For now assume it's linear */

	/* Seek to VOLDIR */
	lseek(voldir->fd,blocknum*PRODOS_BYTES_PER_BLOCK,SEEK_SET);
	result=read(voldir->fd,block,PRODOS_BYTES_PER_BLOCK);

	if (result<PRODOS_BYTES_PER_BLOCK) {
		fprintf(stderr,"Error reading block %d\n",blocknum);
		return -1;
	}
	return 0;
}

