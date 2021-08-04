#include <stdio.h>
#include <stdlib.h>   /* exit()    */
#include <string.h>   /* strncpy() */
#include <sys/stat.h> /* struct stat */
#include <fcntl.h>    /* O_RDONLY */
#include <unistd.h>   /* lseek() */
#include <ctype.h>    /* toupper() */
#include <errno.h>
#include <time.h>

#include "version.h"

#include "prodos.h"

static int ignore_errors=0;
int debug=0;

	/* Given filename, return voldir/offset */
static int prodos_lookup_file(struct voldir_t *voldir,
					char *filename) {

	int voldir_block,voldir_offset;
	struct file_entry_t file_entry;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];
	int result,file;

	voldir_block=PRODOS_VOLDIR_KEY_BLOCK;
	voldir_offset=1;       /* skip the header */

	while(1) {

		/* Read in Block */
		result=prodos_read_block(voldir,
				voldir_buffer,voldir_block);
		if (result<0) {
			fprintf(stderr,"Error on I/O\n");
			return -1;
		}

		for(file=voldir_offset;
			file<voldir->entries_per_block;file++) {

			prodos_populate_filedesc(
				voldir_buffer+4+file*PRODOS_FILE_DESC_LEN,
				&file_entry);

			if (file_entry.storage_type==PRODOS_FILE_DELETED) continue;

			/* FIXME: case insensitive? */
			if (!strncmp(filename,(char *)file_entry.file_name,15)) {
				return (voldir_block<<8)|file;
			}
		}

		voldir_offset=0;
		voldir_block=voldir_buffer[2]|(voldir_buffer[3]<<8);
		if (voldir_block==0) break;

	}

	return -1;
}


	/* Given filename, return voldir/offset */
	/* FIXME: allocate new voldir block if all full */
static int prodos_allocate_directory_entry(struct voldir_t *voldir) {

	int voldir_block,voldir_offset;
	struct file_entry_t file_entry;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];
	int result,file;

	voldir_block=PRODOS_VOLDIR_KEY_BLOCK;
	voldir_offset=1;       /* skip the header */

	while(1) {

		/* Read in Block */
		result=prodos_read_block(voldir,
				voldir_buffer,voldir_block);
		if (result<0) {
			fprintf(stderr,"Error on I/O\n");
			return -1;
		}

		for(file=voldir_offset;
			file<voldir->entries_per_block;file++) {

			prodos_populate_filedesc(
				voldir_buffer+4+file*PRODOS_FILE_DESC_LEN,
				&file_entry);

			if (file_entry.storage_type==PRODOS_FILE_DELETED) {
				return (voldir_block<<8)|file;
			}
		}

		voldir_offset=0;
		voldir_block=voldir_buffer[2]|(voldir_buffer[3]<<8);
		if (voldir_block==0) break;

	}

	return -1;
}



	/* Checks if "filename" exists */
	/* returns file type  */
static int prodos_check_file_exists(struct voldir_t *voldir,
					char *filename) {


	int result;

	result=prodos_lookup_file(voldir,filename);

	return result;
}

static int prodos_free_block(struct voldir_t *voldir,int block) {

	int result;

	/* mark as free using VOLDIR */
	result=prodos_voldir_free_block(voldir,block);

	if (result<0) {
		fprintf(stderr,"Error on I/O\n");
	}

	return 0;
}

static int prodos_allocate_block(struct voldir_t *voldir) {

	int found_block=0;

	/* Find an empty block */
	found_block=prodos_voldir_find_free_block(voldir);
	if (debug) printf("Found free block %x\n",found_block);

	if (found_block<0) {
		fprintf(stderr,"ERROR: prodos_allocate_sector: Disk full!\n");
		return -1;
	}

	prodos_voldir_reserve_block(voldir,found_block);

	return found_block;

}


static int prodos_writeout_filedesc(struct voldir_t *voldir,
				struct file_entry_t *file_entry,
				unsigned char *dest) {

	/* clear it out */
	memset(dest,0,PRODOS_FILE_DESC_LEN);

	dest[0x00]=(file_entry->storage_type<<4)|(file_entry->name_length&0xf);
        memcpy(&dest[0x01],&file_entry->file_name[0],file_entry->name_length);

	dest[0x10]=file_entry->file_type;

	dest[0x11]=file_entry->key_pointer&0xff;
	dest[0x12]=(file_entry->key_pointer>>8)&0xff;

	dest[0x13]=file_entry->blocks_used&0xff;
	dest[0x14]=(file_entry->blocks_used>>8)&0xff;

	dest[0x15]=file_entry->eof&0xff;
	dest[0x16]=(file_entry->eof>>8)&0xff;
	dest[0x17]=(file_entry->eof>>16)&0xff;

	dest[0x18]=(file_entry->creation_time>>16)&0xff;
	dest[0x19]=(file_entry->creation_time>>24)&0xff;
	dest[0x1a]=(file_entry->creation_time>>0)&0xff;
	dest[0x1b]=(file_entry->creation_time>>8)&0xff;

	dest[0x1c]=file_entry->version;
	dest[0x1d]=file_entry->min_version;
	dest[0x1e]=file_entry->access;

	dest[0x1f]=file_entry->aux_type&0xff;
	dest[0x20]=(file_entry->aux_type>>8)&0xff;

	dest[0x21]=(file_entry->last_mod>>16)&0xff;
	dest[0x22]=(file_entry->last_mod>>24)&0xff;
	dest[0x23]=(file_entry->last_mod>>0)&0xff;
	dest[0x24]=(file_entry->last_mod>>8)&0xff;

	dest[0x25]=file_entry->header_pointer&0xff;
	dest[0x26]=(file_entry->header_pointer>>8)&0xff;

	return 0;
}


#define ERROR_MYSTERY		1
#define ERROR_INVALID_FILENAME	2
#define ERROR_FILE_NOT_FOUND	3
#define ERROR_NO_SPACE		4
#define ERROR_IMAGE_NOT_FOUND	5
#define ERROR_CATALOG_FULL	6
#define ERROR_FILE_TOO_BIG	7



#define PRODOS_NUM_FILE_TYPES 5

static struct prodos_file_type {
	int type;
	char name[4];
} file_types[PRODOS_NUM_FILE_TYPES] = {
	{PRODOS_TYPE_TXT,"TXT"},
	{PRODOS_TYPE_BIN,"BIN"},
	{PRODOS_TYPE_BAS,"BAS"},
	{PRODOS_TYPE_VAR,"VAR"},
	{PRODOS_TYPE_SYS,"SYS"},
};


	/* creates file apple_filename on the image from local file filename */
	/* returns ?? */
static int prodos_add_file(struct voldir_t *voldir,
		int fd, char *type,
		int address, int length,
		char *filename, char *apple_filename) {


	int free_blocks,file_size,needed_blocks,total_blocks,storage_type;
	int block,i,j,needed_limit;
	struct stat file_info;
	int input_fd;
	int result;
	unsigned char key_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char index_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char data_buffer[PRODOS_BYTES_PER_BLOCK];
	int key_block,index,inode;
	struct file_entry_t file;
	int file_type=0;


	/* check for valid filename */

	/* Filename rules for Prodos: */
	/*	Only letters, numbers, and periods */
	/*	no special chars */
	/* Traditionally only uppercase (for II+).  Upper/lowercase */
	/*	data later stored in the VERSION/MAX_VERSION fields */

	for(i=0;i<strlen(apple_filename);i++) {
		if ( (!isalnum(apple_filename[i])) &&
			(apple_filename[i]!='.') ) {
			fprintf(stderr,"Warning!  Invalid char in filename!\n");
			//return ERROR_INVALID_FILENAME;
		}
		if ( (isalpha(apple_filename[i])) &&
				(islower(apple_filename[i])) ) {
			fprintf(stderr,"Warning, lowercase filename support not really implemented\n");
			//return ERROR_INVALID_FILENAME;
		}
	}

	/* get file type */
	for(i=0;i<PRODOS_NUM_FILE_TYPES;i++) {
		if (!strncmp(type,file_types[i].name,3)) {
			file_type=file_types[i].type;
			if (debug) printf("Found type %s=%d\n",type,file_type);
		}
	}

	/* Determine size of file to upload */
	if (stat(filename,&file_info)<0) {
		fprintf(stderr,"Error!  %s not found!\n",filename);
		return ERROR_FILE_NOT_FOUND;
	}

	file_size=(int)file_info.st_size;

	/* We need to round up to nearest block size */
	needed_blocks=1+((file_size-1)/PRODOS_BYTES_PER_BLOCK);

	if (debug) printf("Filesize: %d (need %d blocks)\n",
			file_size,needed_blocks);


	if (needed_blocks==0) {
		fprintf(stderr,"Error!  invalid blocksize %d\n",needed_blocks);
		return -ERROR_MYSTERY;
	}
	else if (needed_blocks==1) {
		/* seedling */
		if (debug) printf("File seedling\n");
		storage_type=PRODOS_FILE_SEEDLING;
		total_blocks=needed_blocks;
	}
	else if (needed_blocks<=256) {
		/* sapling */
		if (debug) printf("File sapling\n");
		storage_type=PRODOS_FILE_SAPLING;
		total_blocks=needed_blocks+1;	/* for index block */
	}
	else if (needed_blocks<=65536) {
		/* tree */
		if (debug) printf("File tree\n");
		storage_type=PRODOS_FILE_TREE;
		total_blocks=needed_blocks+1 /* for key index block */
			+(1+needed_blocks/256);	/* for index blocks */
						/* FIXME: -1? */
	}
	else {
		fprintf(stderr,"Error, file too big: %d\n",file_size);
		return -ERROR_FILE_TOO_BIG;
	}

	/* Get free space on device */
	free_blocks=prodos_voldir_free_space(voldir);

	/* Check for free space */
	if (total_blocks>free_blocks) {
		fprintf(stderr,"Error!  Not enough free space "
				"on disk image (need %d have %d)\n",
				total_blocks,free_blocks);
		return ERROR_NO_SPACE;
	}

	/* Open the local file */
	input_fd=open(filename,O_RDONLY);
	if (input_fd<0) {
		fprintf(stderr,"Error! could not open %s\n",filename);
		return ERROR_IMAGE_NOT_FOUND;
	}

	if (storage_type==PRODOS_FILE_SEEDLING) {
		block=prodos_allocate_block(voldir);
		key_block=block;

		memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);
		result=read(input_fd,data_buffer,PRODOS_BYTES_PER_BLOCK);
		if (result<0) {
			fprintf(stderr,"Error reading\n");
			return -ERROR_MYSTERY;
		}
		prodos_write_block(voldir,data_buffer,block);
	}

	if (storage_type==PRODOS_FILE_SAPLING) {
		/* allocate index */
		index=prodos_allocate_block(voldir);
		key_block=index;

		memset(index_buffer,0,PRODOS_BYTES_PER_BLOCK);

		for(i=0;i<needed_blocks;i++) {
			block=prodos_allocate_block(voldir);

			index_buffer[i]=block&0xff;
			index_buffer[i+256]=(block>>8)&0xff;

			memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);

			result=read(input_fd,data_buffer,PRODOS_BYTES_PER_BLOCK);
			if (result<0) {
				fprintf(stderr,"Error reading\n");
				return -ERROR_MYSTERY;
			}
			prodos_write_block(voldir,data_buffer,block);
		}
		prodos_write_block(voldir,index_buffer,index);
	}


	if (storage_type==PRODOS_FILE_TREE) {
		/* allocate key index */
		key_block=prodos_allocate_block(voldir);
		memset(key_buffer,0,PRODOS_BYTES_PER_BLOCK);

		for(j=0;j<(1+needed_blocks/256);j++) {
			index=prodos_allocate_block(voldir);
			memset(index_buffer,0,PRODOS_BYTES_PER_BLOCK);

			key_buffer[j]=index&0xff;
			key_buffer[j+256]=(index>>8)&0xff;

			if (j==needed_blocks/256) {
				needed_limit=needed_blocks%256;
			}
			else {
				needed_limit=256;
			}

			for(i=0;i<needed_limit;i++) {
				block=prodos_allocate_block(voldir);

				index_buffer[i]=block&0xff;
				index_buffer[i+256]=(block>>8)&0xff;

				memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);

				result=read(input_fd,data_buffer,PRODOS_BYTES_PER_BLOCK);
				if (result<0) {
					fprintf(stderr,"Error reading\n");
					return -ERROR_MYSTERY;
				}
				prodos_write_block(voldir,data_buffer,block);
			}
			prodos_write_block(voldir,index_buffer,index);
		}
		prodos_write_block(voldir,key_buffer,key_block);
	}

	close(input_fd);

	/* now that file is on disk, hook up the directory image */

	memset(&file,0,sizeof(struct file_entry_t));


	/* FIXME */
	file.storage_type=storage_type;
	file.name_length=strlen(apple_filename);
	memcpy(file.file_name,apple_filename,file.name_length);
	file.file_type=file_type;
	file.key_pointer=key_block;
	file.blocks_used=total_blocks;	/* includes index blocks */
	file.eof=file_size;
	file.creation_time=prodos_time(time(NULL));
	file.version=0;
	file.min_version=0;
	file.access=0xe3;	// 0x21?
	file.aux_type=0;
	file.last_mod=prodos_time(time(NULL));
	file.header_pointer=PRODOS_VOLDIR_KEY_BLOCK;


	inode=prodos_allocate_directory_entry(voldir);
	if (inode<0) {
		return inode;
	}

	if (debug) printf("Found inode $%x\n",inode);

	/* read in existing voldir entry */
	result=prodos_read_block(voldir,data_buffer,inode>>8);

	/* copy in new data */
	prodos_writeout_filedesc(voldir,&file,
		data_buffer+4+(inode&0xff)*PRODOS_FILE_DESC_LEN);

	/* write back existing voldir entry */
	result=prodos_write_block(voldir,data_buffer,inode>>8);

	/* update file count */
	if (debug) printf("Updating file count...\n");
	voldir->file_count++;
	prodos_sync_voldir(voldir);

	return 0;
}


int prodos_get_file_entry(struct voldir_t *voldir,
			int inode, struct file_entry_t *file) {

	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];
	int block,offset;
	int result;

	block=(inode>>8);
	offset=(inode&0xff);


	result=prodos_read_block(voldir,voldir_buffer,block);
	if (result<0) {
		return result;
	}

	prodos_populate_filedesc(voldir_buffer+4+offset*PRODOS_FILE_DESC_LEN,
			file);

	return 0;


}

	/* load a file from the disk image.  */
	/* inode = voldirblock<<8 | entry */
static int prodos_load_file(struct voldir_t *voldir,
		int inode,char *filename) {

	int output_fd;
	unsigned char data[PRODOS_BYTES_PER_BLOCK];
	unsigned char index_block[PRODOS_BYTES_PER_BLOCK];
	unsigned char master_index_block[PRODOS_BYTES_PER_BLOCK];
	int result,chunk,chunk_block,index,blocks_left,read_blocks;
	struct file_entry_t file;

	/* FIXME!  Warn if overwriting file! */
	output_fd=open(filename,O_WRONLY|O_CREAT|O_TRUNC,0666);
	if (output_fd<0) {
		fprintf(stderr,"Error! could not open %s for local save\n",
			filename);
		return -1;
	}

	if (prodos_get_file_entry(voldir,inode,&file)<0) {
		fprintf(stderr,"Error opening inode %x\n",inode);
		return -1;
	}


	switch(file.storage_type) {
		case PRODOS_FILE_SEEDLING:
			/* Just a single block */
			if (debug) fprintf(stderr,"Loading %d bytes from "
					"block $%x\n",
					file.eof,file.key_pointer);
			result=prodos_read_block(voldir,data,
					file.key_pointer);
			if (result<0) {
				return result;
			}
			result=write(output_fd,data,file.eof);
			if (result!=file.eof) {
				fprintf(stderr,"Error writing file!\n");
				return -1;
			}
			break;

		case PRODOS_FILE_SAPLING:
			/* Index block points to up to 256 blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Address of zero means file hole, all zeros */
			if (debug) fprintf(stderr,"Loading index "
					"block $%x\n",
					file.key_pointer);
			result=prodos_read_block(voldir,index_block,
					file.key_pointer);
			if (result<0) {
				return result;
			}

			for(chunk=0;chunk<file.blocks_used;chunk++) {
				chunk_block=(index_block[chunk])|(index_block[chunk+256]<<8);

				if (chunk_block==0) {
					/* FILE hole */
					lseek(output_fd,
						PRODOS_BYTES_PER_BLOCK,
						SEEK_CUR);
				}
				else {
					result=prodos_read_block(voldir,data,
							chunk_block);
					if (result<0) {
						return result;
					}
				}

				result=write(output_fd,data,PRODOS_BYTES_PER_BLOCK);
				if (result!=PRODOS_BYTES_PER_BLOCK) {
					fprintf(stderr,"Error writing file!\n");
					return -1;
				}
			}
			/* truncate to actual size of file */
			ftruncate(output_fd,file.eof);

			break;

		case PRODOS_FILE_TREE:
			/* Master Index block points to up to 256 index blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Index block points to up to 256 blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Address of zero means file hole, all zeros */

			blocks_left=file.blocks_used;

			if (debug) fprintf(stderr,"Loading master index "
					"block $%x\n",
					file.key_pointer);
			result=prodos_read_block(voldir,master_index_block,
					file.key_pointer);
			if (result<0) {
				return result;
			}

			for(index=0;index<file.blocks_used/256;index++) {
				result=prodos_read_block(voldir,
					index_block,
					(master_index_block[index])|
					(master_index_block[256+index]<<8));
				if (result<0) {
					return result;
				}

				if (blocks_left<256) {
					read_blocks=blocks_left;
				}
				else {
					read_blocks=256;
				}

				for(chunk=0;chunk<read_blocks;chunk++) {
					chunk_block=(index_block[chunk])|
						(index_block[chunk+256]<<8);

					result=prodos_read_block(voldir,data,
							chunk_block);
					if (result<0) {
						return result;
					}


					result=write(output_fd,data,PRODOS_BYTES_PER_BLOCK);
					if (result!=PRODOS_BYTES_PER_BLOCK) {
						fprintf(stderr,"Error writing file!\n");
						return -1;
					}
				}
			}
			/* truncate to actual size of file */
			ftruncate(output_fd,file.eof);

			break;


		case PRODOS_FILE_SUBDIR:
		case PRODOS_FILE_DELETED:
		case PRODOS_FILE_SUBDIR_HDR:
		case PRODOS_FILE_VOLUME_HDR:
		default:
			fprintf(stderr,"Error!  "
				"Cannot load this type of file: %x\n",
				file.storage_type);
			break;
	}

	close(output_fd);

	return 0;

}



    /* rename a file */
    /* FIXME: validate the new filename is valid */
static int prodos_rename_file(struct voldir_t *voldir,
	char *old_filename,char *new_filename) {

	int result;
	int inode;
	struct file_entry_t file;
	unsigned char data_buffer[PRODOS_BYTES_PER_BLOCK];
	int newlen;

	/* get the voldir/entry for file */
	inode=prodos_lookup_file(voldir,old_filename);

	if (inode<0) {
		fprintf(stderr,"Error!  %s not found!\n",
				old_filename);
		return -1;
	}

	/* get the file entry */
	if (prodos_get_file_entry(voldir,inode,&file)<0) {
		fprintf(stderr,"Error opening inode %x\n",inode);
		return -1;
	}

	/* change the filename */
	newlen=strlen(new_filename);
	memset(file.file_name,0,15);
	memcpy(file.file_name,new_filename,newlen);

	file.name_length=newlen;

	/* read in existing voldir entry */
	result=prodos_read_block(voldir,data_buffer,inode>>8);

	/* copy in new data */
	prodos_writeout_filedesc(voldir,&file,
		data_buffer+4+(inode&0xff)*PRODOS_FILE_DESC_LEN);

	/* write back existing voldir entry */
	result=prodos_write_block(voldir,data_buffer,inode>>8);
	if (result<0) {
		fprintf(stderr,"I/O Error!\n");
		return result;
	}

	return 0;
}


static int prodos_delete_file(struct voldir_t *voldir,char *apple_filename) {

	unsigned char data_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char index_block[PRODOS_BYTES_PER_BLOCK];
	unsigned char master_index_block[PRODOS_BYTES_PER_BLOCK];
	int result,chunk,chunk_block,index,blocks_left,read_blocks,mblock;
	struct file_entry_t file;
	int inode;


	/* get the voldir/entry for file */
	inode=prodos_lookup_file(voldir,apple_filename);

	if (inode<0) {
		fprintf(stderr,"Error!  %s not found!\n",
				apple_filename);
		return -1;
	}

	result=prodos_read_block(voldir,data_buffer,inode>>8);

	if (prodos_get_file_entry(voldir,inode,&file)<0) {
		fprintf(stderr,"Error opening inode %x\n",inode);
		return -1;
	}

	/******************************/
	/* delete all the file blocks */
	/******************************/

	switch(file.storage_type) {
		case PRODOS_FILE_SEEDLING:
			/* Just a single block */
			if (debug) fprintf(stderr,"Deleting block $%x\n",
				file.key_pointer);

			result=prodos_free_block(voldir,file.key_pointer);
			if (result<0) {
				return result;
			}
			break;

		case PRODOS_FILE_SAPLING:
			/* Index block points to up to 256 blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Address of zero means file hole, all zeros */
			if (debug) fprintf(stderr,"Freeing index "
					"block $%x\n",
					file.key_pointer);
			result=prodos_read_block(voldir,index_block,
					file.key_pointer);
			if (result<0) {
				return result;
			}

			for(chunk=0;chunk<file.blocks_used;chunk++) {
				chunk_block=(index_block[chunk])|(index_block[chunk+256]<<8);

				if (chunk_block==0) {
					/* FILE hole */
				}
				else {
					result=prodos_free_block(voldir,chunk_block);
					if (result<0) {
						return result;
					}
				}
			}
			result=prodos_free_block(voldir,file.key_pointer);
			break;

		case PRODOS_FILE_TREE:
			/* Master Index block points to up to 256 index blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Index block points to up to 256 blocks */
			/* Addresses are stored low-byte (256 bytes) then hi-byte */
			/* Address of zero means file hole, all zeros */

			blocks_left=file.blocks_used;

			if (debug) fprintf(stderr,"Deleting master index "
					"block $%x\n",
					file.key_pointer);
			result=prodos_read_block(voldir,master_index_block,
					file.key_pointer);
			if (result<0) {
				return result;
			}

			for(index=0;index<file.blocks_used/256;index++) {
				mblock=(master_index_block[index])|
					(master_index_block[256+index]<<8);
				result=prodos_read_block(voldir,
					index_block,
					mblock);
				if (result<0) {
					return result;
				}

				if (blocks_left<256) {
					read_blocks=blocks_left;
				}
				else {
					read_blocks=256;
				}

				for(chunk=0;chunk<read_blocks;chunk++) {
					chunk_block=(index_block[chunk])|
						(index_block[chunk+256]<<8);

					result=prodos_free_block(voldir,chunk_block);
					if (result<0) {
						return result;
					}
				}
				result=prodos_free_block(voldir,mblock);
			}
			result=prodos_free_block(voldir,file.key_pointer);
			break;


		case PRODOS_FILE_SUBDIR:
		case PRODOS_FILE_DELETED:
		case PRODOS_FILE_SUBDIR_HDR:
		case PRODOS_FILE_VOLUME_HDR:
		default:
			fprintf(stderr,"Error!  "
				"Cannot delete this type of file: %x\n",
				file.storage_type);
			break;
	}


	/* now that file is gone, disconnect the directory image */

	/* should we clear it out? */
	/* makes undelete harder */
	// memset(&file,0,sizeof(struct file_entry_t));

	file.storage_type=PRODOS_FILE_DELETED;

	/* copy in new data */
	prodos_writeout_filedesc(voldir,&file,
		data_buffer+4+(inode&0xff)*PRODOS_FILE_DESC_LEN);

	/* write back existing voldir entry */
	result=prodos_write_block(voldir,data_buffer,inode>>8);

	/* update file count */
	if (debug) printf("Updating file count...\n");
	voldir->file_count--;
	prodos_sync_voldir(voldir);

	return 0;
}


static void display_help(char *name, int version_only) {
	printf("\nprodos version %s\n",VERSION);
	printf("by Vince Weaver <vince@deater.net>\n");
	printf("\n");

	if (version_only) return;

	printf("Usage: %s [-h] [i interleave] [-y] [-x] disk_image COMMAND [options]\n",name);
	printf("\t-h : this help message\n");
	printf("\t-i : interleave (prodos or dos33)\n");
	printf("\t-y : always answer yes for warning questions\n");
	printf("\t-x : ignore errors (useful for making invalid filenames)\n");
	printf("\n");
	printf("  Where disk_image is a valid PRODOS disk image\n"
		"  and COMMAND is one of the following:\n");
	printf("\tCATALOG   [dir_name]\n");
	printf("\tLOAD      apple_file <local_file>\n");
	printf("\tSAVE      [-t type] [-a addr] [-l len] local_file <apple_file>\n");
	printf("\tDELETE    apple_file\n");
	printf("\tRENAME    apple_file_old apple_file_new\n");
	printf("\tDUMP\n");
	printf("\tVOLUME    volume_name\n");
	printf("\tMKDIR     dir_name\n");
	printf("\tRMDIR     dir_name\n");
	printf("\tTYPE      TODO: set type\n");
	printf("\tAUX       TODO: set aux\n");
	printf("\tTIMESTAMP TODO: set timestamp\n");
	printf("\tACCESS    TODO: set access\n");

	printf("\n");
	return;
}

#define COMMAND_LOAD		0
#define COMMAND_SAVE		1
#define COMMAND_CATALOG		2
#define COMMAND_DELETE		3
#define COMMAND_RENAME		4
#define COMMAND_DUMP		5
#define COMMAND_SHOWFREE	6
#define COMMAND_VOLNAME		7
#define COMMAND_MKDIR		8
#define COMMAND_RMDIR		9

#define MAX_COMMAND		10
#define COMMAND_UNKNOWN		255

static struct command_type {
	int type;
	char name[32];
} commands[MAX_COMMAND] = {
	{COMMAND_LOAD,"LOAD"},
	{COMMAND_SAVE,"SAVE"},
	{COMMAND_CATALOG,"CATALOG"},
	{COMMAND_DELETE,"DELETE"},
	{COMMAND_RENAME,"RENAME"},
	{COMMAND_DUMP,"DUMP"},
	{COMMAND_SHOWFREE,"SHOWFREE"},
	{COMMAND_VOLNAME,"VOLNAME"},
	{COMMAND_MKDIR,"MKDIR"},
	{COMMAND_RMDIR,"RMDIR"},
};

static int lookup_command(char *name) {

	int which=COMMAND_UNKNOWN,i;

	for(i=0;i<MAX_COMMAND;i++) {
		if(!strncmp(name,commands[i].name,strlen(commands[i].name))) {
			which=commands[i].type;
			break;
		}
	}
	return which;

}

static int truncate_filename(char *out, char *in) {

	int truncated=0;

	/* Truncate filename if too long */
	if (strlen(in)>15) {
		fprintf(stderr,"Warning!  Truncating %s to 15 chars\n",in);
		truncated=1;
	}
	strncpy(out,in,15);
	out[15]='\0';

	return truncated;
}


int main(int argc, char **argv) {

	char image[BUFSIZ];
	char type[4];
	int prodos_fd=0,i;
	int interleave=PRODOS_INTERLEAVE_PRODOS,arg_interleave=0;
	int image_offset=0;

	int command,file_exists;
	char temp_string[BUFSIZ];
	char apple_filename[31],new_filename[31];
	char local_filename[BUFSIZ];
	char *result_string;
	int always_yes=0;
	char *temp,*endptr;
	int c;
	int inode;
	int address=0, length=0;
	struct voldir_t voldir;
	int dir_block;

	/* Check command line arguments */
	while ((c = getopt (argc, argv,"a:i:l:t:dhvxy"))!=-1) {
		switch (c) {

		case 'd':
			fprintf(stderr,"DEBUG enabled\n");
			debug=1;
			break;
		case 'a':
			address=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Address=%d\n",address);
			break;
		case 't':
			if (strlen(optarg)!=3) {
				fprintf(stderr,"Type %s too long, should be 3 chars\n",optarg);
				return -1;
			}
			for(i=0;i<3;i++) {
				type[i]=toupper(optarg[i]);
			}
			type[3]=0;
			if (debug) fprintf(stderr,"Type=%s\n",type);
			break;
		case 'i':
			if (!strncmp(optarg,"prodos",6)) {
				arg_interleave=1;
			}
			if (!strncmp(optarg,"dos33",5)) {
				arg_interleave=2;
			}
			if (debug) fprintf(stderr,"Interleave=%d\n",arg_interleave);
			break;
		case 'l':
			length=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Length=%d\n",address);
			break;
		case 'v':
			display_help(argv[0],1);
			return 0;
		case 'h': display_help(argv[0],0);
			return 0;
		case 'x':
			ignore_errors=1;
			break;
		case 'y':
			always_yes=1;
			break;
		}
	}

	if (optind==argc) {
		fprintf(stderr,"ERROR!  Must specify disk image!\n\n");
		return -1;
	}

	/* get argument 1, which is image name */
	strncpy(image,argv[optind],BUFSIZ-1);
	prodos_fd=open(image,O_RDWR);
	if (prodos_fd<0) {
		fprintf(stderr,"Error opening disk_image: %s\n",image);
		return -1;
	}

	if (debug) {
		printf("checking extension: %s\n",&image[strlen(image)-4]);
	}

	/* Try to autodetect interleave based on filename */
	if (strlen(image)>4) {

		if (!strncmp(&image[strlen(image)-4],".dsk",4)) {
			if (debug) printf("Detected DOS33 interleave\n");
			interleave=PRODOS_INTERLEAVE_DOS33;
		}

		/* FIXME: detect this based on magic number */
		else if (!strncmp(&image[strlen(image)-4],".2mg",4)) {

			char header[64];
			int image_format;

			read(prodos_fd,header,64);

			image_offset=	(header[24])|
					(header[25]<<8)|
					(header[26]<<16)|
					(header[27]<<24);

			image_format=(header[12])|
					(header[13]<<8)|
					(header[14]<<16)|
					(header[15]<<24);

			if (image_format==0) {
				interleave=PRODOS_INTERLEAVE_DOS33;
			}
			else if (image_format==1) {
				interleave=PRODOS_INTERLEAVE_PRODOS;
			}
			else {
				fprintf(stderr,"Unsupported 2MG format\n");
				return -1;
			}

			if (debug) {
				char string[5];

				printf("Detected 2MG format\n");

				memcpy(string,header,4);
				string[4]=0;
				printf("magic: %s\n",string);

				memcpy(string,header+4,4);
				string[4]=0;
				printf("creator: %s\n",string);

				printf("Header size: %d\n",
					(header[8]|(header[9]<<8)));

				printf("Version: %d\n",
						(header[10]|(header[11]<<8)));

				printf("Flags: $%X\n",
					(header[16])|
					(header[17]<<8)|
					(header[18]<<16)|
					(header[19]<<24));

				printf("ProDOS blocks: $%X\n",
					(header[20])|
					(header[21]<<8)|
					(header[22]<<16)|
					(header[23]<<24));

				printf("Image offset: $%X\n",image_offset);

				printf("Bytes of data: %d\n",
					(header[28])|
					(header[29]<<8)|
					(header[30]<<16)|
					(header[31]<<24));

				printf("Offset to comment: $%X\n",
					(header[32])|
					(header[33]<<8)|
					(header[34]<<16)|
					(header[35]<<24));

				printf("Length of comment: %d\n",
					(header[36])|
					(header[37]<<8)|
					(header[38]<<16)|
					(header[39]<<24));

				printf("Offset to creator comment: $%X\n",
					(header[40])|
					(header[41]<<8)|
					(header[42]<<16)|
					(header[43]<<24));

				printf("Length of creator comment: %d\n",
					(header[44])|
					(header[45]<<8)|
					(header[46]<<16)|
					(header[47]<<24));


			}
		}
	}

	/* override inteleave if set */
	if (arg_interleave) {
		interleave=arg_interleave-1;
	}

	prodos_init_voldir(prodos_fd,&voldir,interleave,image_offset);

	/* Move to next argument */
	optind++;

	if (optind==argc) {
		fprintf(stderr,"ERROR!  Must specify command!\n\n");
		return -2;
	}

	/* Grab command */
	strncpy(temp_string,argv[optind],BUFSIZ-1);

	/* Make command be uppercase */
	for(i=0;i<strlen(temp_string);i++) {
		temp_string[i]=toupper(temp_string[i]);
	}

	/* Move to next argument */
	optind++;

	command=lookup_command(temp_string);

	switch(command) {

	case COMMAND_UNKNOWN:
		fprintf(stderr,"ERROR!  Unknown command %s\n",temp_string);
		fprintf(stderr,"\tTry \"%s -h\" for help.\n\n",argv[0]);
		goto exit_and_close;
		break;

	/* Load a file from disk image to local machine */
	case COMMAND_LOAD:

		/* check and make sure we have apple_filename */
		if (argc==optind) {
			fprintf(stderr,"Error! Need apple file_name\n");
			fprintf(stderr,"%s %s LOAD apple_filename\n",
				argv[0],image);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		if (debug) printf("\tApple filename: %s\n",apple_filename);

		/* get output filename */
		optind++;
		if (argc>optind) {
			if (debug) printf("Using %s for filename\n",
						local_filename);
			strncpy(local_filename,argv[optind],BUFSIZ-1);
		}
		else {
			if (debug) printf("Using %s for filename\n",
						apple_filename);
			strncpy(local_filename,apple_filename,31);
		}

		if (debug) printf("\tOutput filename: %s\n",local_filename);

		/* get the voldir/entry for file */
		inode=prodos_lookup_file(&voldir,apple_filename);

		if (inode<0) {
			fprintf(stderr,"Error!  %s not found!\n",
				apple_filename);
			goto exit_and_close;
		}


		/* Load the file */
		prodos_load_file(&voldir,inode,local_filename);

		break;

	case COMMAND_CATALOG:

		dir_block=PRODOS_VOLDIR_KEY_BLOCK;

		prodos_catalog(&voldir,dir_block);

		break;

	case COMMAND_SAVE:

		if (debug) printf("\ttype=%s\n",type);

		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");

			fprintf(stderr,"%s %s SAVE "
					"file_name apple_filename\n\n",
					argv[0],image);

			goto exit_and_close;
		}

		strncpy(local_filename,argv[optind],BUFSIZ-1);
		optind++;

		if (debug) printf("\tLocal filename: %s\n",local_filename);

		if (argc>optind) {
			/* apple filename specified */
			truncate_filename(apple_filename,argv[optind]);
		}
		else {
			/* If no filename specified for apple name    */
			/* Then use the input name.  Note, we strip   */
			/* everything up to the last slash so useless */
			/* path info isn't used                       */

			temp=local_filename+(strlen(local_filename)-1);

			while(temp!=local_filename) {
				temp--;
				if (*temp == '/') {
					temp++;
					break;
				}
			}

			truncate_filename(apple_filename,temp);
		}

		if (debug) printf("\tApple filename: %s\n",apple_filename);

		file_exists=prodos_check_file_exists(&voldir,apple_filename);

		if (file_exists>=0) {
			fprintf(stderr,"Warning!  %s exists!\n",apple_filename);
			if (!always_yes) {
				printf("Over-write (y/n)?");
				result_string=fgets(temp_string,BUFSIZ,stdin);
				if ((result_string==NULL) || (temp_string[0]!='y')) {
					printf("Exiting early...\n");
					goto exit_and_close;
				}
			}
			fprintf(stderr,"Deleting previous version...\n");
			prodos_delete_file(&voldir,apple_filename);
		}

		prodos_add_file(&voldir,prodos_fd,type,
				address, length,
				local_filename,apple_filename);

		break;


	case COMMAND_DELETE:

		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");
			fprintf(stderr,"%s %s DELETE apple_filename\n",
				argv[0],image);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		file_exists=prodos_check_file_exists(&voldir,apple_filename);
		if (file_exists<0) {
			fprintf(stderr, "Error!  File %s does not exist\n",
					apple_filename);
			goto exit_and_close;
		}
		prodos_delete_file(&voldir,apple_filename);

		break;

	case COMMAND_DUMP:
		printf("Dumping %s!\n",image);
		prodos_dump(&voldir);
		break;

	case COMMAND_SHOWFREE:
		printf("Showing Free %s!\n",image);
		prodos_showfree(&voldir);
		break;

	case COMMAND_RENAME:
		/* check and make sure we have apple_filename */
		if (argc==optind) {
			fprintf(stderr,"Error! Need two filenames\n");
			fprintf(stderr,"%s %s RENAME apple_filename_old "
				"apple_filename_new\n",
				argv[0],image);
	     		goto exit_and_close;
		}

		/* Truncate filename if too long */
		truncate_filename(apple_filename,argv[optind]);
		optind++;

		if (argc==optind) {
			fprintf(stderr,"Error! Need two filenames\n");
			fprintf(stderr,"%s %s RENAME apple_filename_old "
				"apple_filename_new\n",
				argv[0],image);
	     		goto exit_and_close;
		}

		truncate_filename(new_filename,argv[optind]);

		/* get the entry/track/sector for file */
		file_exists=prodos_check_file_exists(&voldir,apple_filename);
		if (file_exists<0) {
			fprintf(stderr,"Error!  %s not found!\n",
							apple_filename);
			goto exit_and_close;
		}

		prodos_rename_file(&voldir,apple_filename,new_filename);

		break;


	/* Change the volume name */
	case COMMAND_VOLNAME:


		/* check and make sure we have a volume name */
		if (argc==optind) {
			fprintf(stderr,"Error! Need apple volume_name\n");
			fprintf(stderr,"%s %s VOLUME volume_name\n",
				argv[0],image);
			goto exit_and_close;
		}

		prodos_change_volume_name(&voldir,argv[optind]);

		break;

	default:
		fprintf(stderr,"Sorry, unsupported command %s\n\n",temp_string);
		goto exit_and_close;
	}

exit_and_close:
	close(prodos_fd);

	return 0;
}
