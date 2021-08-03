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

    /* Read volume directory into a buffer */
int prodos_read_voldir(int fd, struct voldir_t *voldir,
				int interleave, int image_offset) {

	int result;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];

	voldir->interleave=interleave;
	voldir->image_offset=image_offset;

	/* read in VOLDIR KEY Block*/
	voldir->fd=fd;
	result=prodos_read_block(voldir,voldir_buffer,PRODOS_VOLDIR_KEY_BLOCK);

	if (result<0) {
		fprintf(stderr,"Error reading VOLDIR\n");
		return -1;
	}

	voldir->fd=fd;

	voldir->storage_type=(voldir_buffer[0x4]>>4)&0xf;
	voldir->name_length=(voldir_buffer[0x4]&0xf);
	if (voldir->storage_type!=0xf) {
		fprintf(stderr,"ERROR! Expected storage type F\n");
	}

	memcpy(voldir->volume_name,&voldir_buffer[0x5],voldir->name_length);
	voldir->volume_name[voldir->name_length]=0;

	voldir->creation_time=(voldir_buffer[0x1c]<<16)|
			(voldir_buffer[0x1d]<<24)|
			(voldir_buffer[0x1e]<<0)|
			(voldir_buffer[0x1f]<<8);

	voldir->version=voldir_buffer[0x20];
	voldir->min_version=voldir_buffer[0x21];
	voldir->access=voldir_buffer[0x22];
	voldir->entry_length=voldir_buffer[0x23];

	if (voldir->entry_length!=PRODOS_FILE_DESC_LEN) {
		printf("Error!  Unexpected desc len %d\n",
			voldir->entry_length);
	}

	voldir->entries_per_block=voldir_buffer[0x24];
	voldir->file_count=voldir_buffer[0x25]|(voldir_buffer[0x26]<<8);
	voldir->bit_map_pointer=voldir_buffer[0x27]|(voldir_buffer[0x28]<<8);
	voldir->total_blocks=voldir_buffer[0x29]|(voldir_buffer[0x2A]<<8);
	voldir->next_block=voldir_buffer[0x2]|(voldir_buffer[0x3]<<8);

	return 0;
}



int prodos_sync_voldir(struct voldir_t *voldir) {

	unsigned char newvoldir[PRODOS_BYTES_PER_BLOCK];

	memset(newvoldir,0,PRODOS_BYTES_PER_BLOCK);

	newvoldir[0x4]=(voldir->storage_type<<4)|(voldir->name_length&0xf);
	memcpy(&newvoldir[0x5],voldir->volume_name,voldir->name_length);

	/* FIXME: probably endianess issues */

	newvoldir[0x1c]=(voldir->creation_time>>16)&0xff;
	newvoldir[0x1d]=(voldir->creation_time>>24)&0xff;
	newvoldir[0x1e]=(voldir->creation_time>>0)&0xff;
	newvoldir[0x1f]=(voldir->creation_time>>8)&0xff;

	newvoldir[0x20]=voldir->version;
	newvoldir[0x21]=voldir->min_version;
	newvoldir[0x22]=voldir->access;
	newvoldir[0x23]=voldir->entry_length;

	newvoldir[0x24]=voldir->entries_per_block;

	newvoldir[0x25]=voldir->file_count&0xff;
	newvoldir[0x26]=(voldir->file_count>>8)&0xff;

	newvoldir[0x27]=voldir->bit_map_pointer&0xff;
	newvoldir[0x28]=(voldir->bit_map_pointer>>8)&0xff;

	newvoldir[0x29]=voldir->total_blocks&0xff;
	newvoldir[0x2A]=(voldir->total_blocks>>8)&0xff;

	newvoldir[0x2]=voldir->next_block&0xff;
	newvoldir[0x3]=(voldir->next_block>>8)&0xff;

	prodos_write_block(voldir,newvoldir,PRODOS_VOLDIR_KEY_BLOCK);

	return 0;

}

int prodos_change_volume_name(struct voldir_t *voldir, char *volname) {

	int volname_len;

	volname_len=strlen(volname);
	if (volname_len>15) {
		printf("Warning!  Volume name %s is too long, truncating\n",
				volname);
		volname_len=15;
	}

	memcpy(voldir->volume_name,volname,15);
	voldir->name_length=volname_len;

	prodos_sync_voldir(voldir);

	return 0;

}
