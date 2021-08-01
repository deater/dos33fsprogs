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

static int ignore_errors=0;
int debug=1;

    /* Read volume directory into a buffer */
static int prodos_read_voldir(int fd, struct voldir_t *voldir, int interleave) {

	int result;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];

	voldir->interleave=interleave;

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



	/* Checks if "filename" exists */
	/* returns file type  */
static int prodos_check_file_exists(struct voldir_t *voldir,
					char *filename,
					struct file_entry_t *file) {


	int catalog_block,catalog_offset,catalog_inode;

	catalog_block=PRODOS_VOLDIR_KEY_BLOCK;
	catalog_offset=0;       /* skip the header */
	catalog_inode=(catalog_block<<8)|catalog_offset;


	while(1) {
		catalog_inode=prodos_find_next_file(catalog_inode,voldir);
		if (catalog_inode==-1) break;
	}

	return 0;
}

static int prodos_free_block(struct voldir_t *voldir,int block) {

#if 0

	int result;

	/* mark as free using VOLDIR */
	result=prodos_voldir_free_block(voldir,block);


	/* write modified VTOC back out */
	lseek(fd,DISK_OFFSET(PRODOS_VOLDIR_TRACK,PRODOS_VOLDIR_BLOCK),SEEK_SET);
	result=write(fd,&voldir,PRODOS_BYTES_PER_BLOCK);

	if (result<0) {
		fprintf(stderr,"Error on I/O\n");
	}
#endif

	return 0;
}

static int prodos_allocate_sector(int fd, struct voldir_t *voldir) {

#if 0

	int found_track=0,found_sector=0;
	int result;

	/* Find an empty sector */
	result=prodos_voldir_find_free_sector(voldir,&found_track,&found_sector);

	if (result<0) {
		fprintf(stderr,"ERROR: prodos_allocate_sector: Disk full!\n");
		return -1;
	}


	/* store new track/direction info */
	voldir[VTOC_LAST_ALLOC_T]=found_track;

//	if (found_track>PRODOS_VOLDIR_TRACK) vtoc[VTOC_ALLOC_DIRECT]=1;
//	else vtoc[VTOC_ALLOC_DIRECT]=-1;

	/* Seek to VTOC */
	lseek(fd,DISK_OFFSET(PRODOS_VOLDIR_TRACK,PRODOS_VOLDIR_BLOCK),SEEK_SET);

	/* Write out VTOC */
	result=write(fd,voldir,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");

	return ((found_track<<8)+found_sector);
#endif
	return 0;
}


#define ERROR_INVALID_FILENAME	1
#define ERROR_FILE_NOT_FOUND	2
#define ERROR_NO_SPACE		3
#define ERROR_IMAGE_NOT_FOUND	4
#define ERROR_CATALOG_FULL	5

#define ADD_RAW		0
#define ADD_BINARY	1

	/* creates file apple_filename on the image from local file filename */
	/* returns ?? */
static int prodos_add_file(struct voldir_t *voldir,
		int fd, char dos_type,
		int file_type, int address, int length,
		char *filename, char *apple_filename) {

#if 0
	int free_space,file_size,needed_sectors;
	struct stat file_info;
	int size_in_sectors=0;
	int initial_ts_list=0,ts_list=0,i,data_ts,x,bytes_read=0,old_ts_list;
	int catalog_track,catalog_sector,sectors_used=0;
	int input_fd;
	int result;
	int first_write=1;
	unsigned char ts_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char data_buffer[PRODOS_BYTES_PER_BLOCK];

	if (apple_filename[0]<64) {
		fprintf(stderr,"Error!  First char of filename "
				"must be ASCII 64 or above!\n");
		if (!ignore_errors) return ERROR_INVALID_FILENAME;
	}

	/* Check for comma in filename */
	for(i=0;i<strlen(apple_filename);i++) {
		if (apple_filename[i]==',') {
			fprintf(stderr,"Error!  "
				"Cannot have , in a filename!\n");
			return ERROR_INVALID_FILENAME;
		}
	}

	/* FIXME */
	/* check type */
	/* and sanity check a/b filesize is set properly */

	/* Determine size of file to upload */
	if (stat(filename,&file_info)<0) {
		fprintf(stderr,"Error!  %s not found!\n",filename);
		return ERROR_FILE_NOT_FOUND;
	}

	file_size=(int)file_info.st_size;

	if (debug) printf("Filesize: %d\n",file_size);

	if (file_type==ADD_BINARY) {
		if (debug) printf("Adding 4 bytes for size/offset\n");
		if (length==0) length=file_size;
		file_size+=4;
	}

	/* We need to round up to nearest sector size */
	/* Add an extra sector for the T/S list */
	/* Then add extra sector for a T/S list every 122*256 bytes (~31k) */
	needed_sectors=(file_size/PRODOS_BYTES_PER_BLOCK)+ /* round sectors */
			((file_size%PRODOS_BYTES_PER_BLOCK)!=0)+/* tail if needed */
			1+/* first T/S list */
			(file_size/(122*PRODOS_BYTES_PER_BLOCK)); /* extra t/s lists */

	/* Get free space on device */
	free_space=prodos_vtoc_free_space(voldir);

	/* Check for free space */
	if (needed_sectors*PRODOS_BYTES_PER_BLOCK>free_space) {
		fprintf(stderr,"Error!  Not enough free space "
				"on disk image (need %d have %d)\n",
				needed_sectors*PRODOS_BYTES_PER_BLOCK,free_space);
		return ERROR_NO_SPACE;
	}

	/* plus one because we need a sector for the tail */
	size_in_sectors=(file_size/PRODOS_BYTES_PER_BLOCK)+
		((file_size%PRODOS_BYTES_PER_BLOCK)!=0);
	if (debug) printf("Need to allocate %i data sectors\n",size_in_sectors);
	if (debug) printf("Need to allocate %i total sectors\n",needed_sectors);

	/* Open the local file */
	input_fd=open(filename,O_RDONLY);
	if (input_fd<0) {
		fprintf(stderr,"Error! could not open %s\n",filename);
		return ERROR_IMAGE_NOT_FOUND;
	}

	i=0;
	while (i<size_in_sectors) {

		/* Create new T/S list if necessary */
		if (i%TSL_MAX_NUMBER==0) {
			old_ts_list=ts_list;

			/* allocate a sector for the new list */
			ts_list=prodos_allocate_sector(fd,voldir);
			sectors_used++;
			if (ts_list<0) return -1;

			/* clear the t/s sector */
			memset(ts_buffer,0,PRODOS_BYTES_PER_BLOCK);

			lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
			result=write(fd,ts_buffer,PRODOS_BYTES_PER_BLOCK);

			if (i==0) {
				initial_ts_list=ts_list;
			}
			else {
				/* we aren't the first t/s list so do special stuff */

				/* load in the old t/s list */
				lseek(fd,
					DISK_OFFSET(get_high_byte(old_ts_list),
					get_low_byte(old_ts_list)),
					SEEK_SET);

				result=read(fd,ts_buffer,PRODOS_BYTES_PER_BLOCK);

				/* point from old ts list to new one we just made */
				ts_buffer[TSL_NEXT_TRACK]=get_high_byte(ts_list);
				ts_buffer[TSL_NEXT_SECTOR]=get_low_byte(ts_list);

				/* set offset into file */
				ts_buffer[TSL_OFFSET_H]=get_high_byte((i-122)*256);
				ts_buffer[TSL_OFFSET_L]=get_low_byte((i-122)*256);

				/* write out the old t/s list with updated info */
				lseek(fd,
					DISK_OFFSET(get_high_byte(old_ts_list),
					get_low_byte(old_ts_list)),
					SEEK_SET);

				result=write(fd,ts_buffer,PRODOS_BYTES_PER_BLOCK);
			}
		}

		/* allocate a sector */
		data_ts=prodos_allocate_sector(fd,voldir);
		sectors_used++;

		if (data_ts<0) return -1;

		/* clear data sector */
		memset(data_buffer,0,PRODOS_BYTES_PER_BLOCK);

		/* read from input */
		if ((first_write) && (file_type==ADD_BINARY)) {
			first_write=0;
			data_buffer[0]=address&0xff;
			data_buffer[1]=(address>>8)&0xff;
			data_buffer[2]=(length)&0xff;
			data_buffer[3]=((length)>>8)&0xff;
			bytes_read=read(input_fd,data_buffer+4,
					PRODOS_BYTES_PER_BLOCK-4);
			bytes_read+=4;
		}
		else {
			bytes_read=read(input_fd,data_buffer,
					PRODOS_BYTES_PER_BLOCK);
		}
		first_write=0;

		if (bytes_read<0) fprintf(stderr,"Error reading bytes!\n");

		/* write to disk image */
		lseek(fd,DISK_OFFSET((data_ts>>8)&0xff,data_ts&0xff),SEEK_SET);
		result=write(fd,data_buffer,PRODOS_BYTES_PER_BLOCK);

		if (debug) {
			printf("Writing %i bytes to %i/%i\n",
				bytes_read,(data_ts>>8)&0xff,data_ts&0xff);
		}

		/* add to T/s table */

		/* read in t/s list */
		lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
		result=read(fd,ts_buffer,PRODOS_BYTES_PER_BLOCK);

		/* point to new data sector */
		ts_buffer[((i%TSL_MAX_NUMBER)*2)+TSL_LIST]=(data_ts>>8)&0xff;
		ts_buffer[((i%TSL_MAX_NUMBER)*2)+TSL_LIST+1]=(data_ts&0xff);

		/* write t/s list back out */
		lseek(fd,DISK_OFFSET((ts_list>>8)&0xff,ts_list&0xff),SEEK_SET);
		result=write(fd,ts_buffer,PRODOS_BYTES_PER_BLOCK);

		i++;
	}

	/* Add new file to Catalog */

	catalog_track=voldir[VTOC_CATALOG_T];
	catalog_sector=voldir[VTOC_CATALOG_S];

continue_parsing_catalog:

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);
	if (result!=PRODOS_BYTES_PER_BLOCK) {
		fprintf(stderr,"Catalog: Error, only read %d bytes at $%02X:$%02X (%s)\n",
			result,catalog_track,catalog_sector,strerror(errno));
		return ERROR_NO_SPACE;
	}

	/* Find empty directory entry */
	i=0;
	while(i<7) {
		/* for undelete purposes might want to skip 0xff */
		/* (deleted) files first and only use if no room */

		if ((catalog_buffer[CATALOG_FILE_LIST+
				(i*CATALOG_ENTRY_SIZE)]==0xff) ||
			(catalog_buffer[CATALOG_FILE_LIST+
				(i*CATALOG_ENTRY_SIZE)]==0x00)) {
			goto got_a_dentry;
		}
		i++;
	}

	if ((catalog_track=0x11) && (catalog_sector==1)) {
		/* in theory can only have 105 files */
		/* if full, we have no recourse!     */
		/* can we allocate new catalog sectors */
		/* and point to them?? */
		fprintf(stderr,"Error!  No more room for files!\n");
		return ERROR_CATALOG_FULL;
	}

	catalog_track=catalog_buffer[CATALOG_NEXT_T];
	catalog_sector=catalog_buffer[CATALOG_NEXT_S];

	goto continue_parsing_catalog;

got_a_dentry:
//	printf("Adding file at entry %i of catalog 0x%x:0x%x\n",
//		i,catalog_track,catalog_sector);

	/* Point entry to initial t/s list */
	catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)]=(initial_ts_list>>8)&0xff;
	catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+1]=(initial_ts_list&0xff);
	/* set file type */
	catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_TYPE]=
		prodos_char_to_type(dos_type,0);

//	printf("Pointing T/S to %x/%x\n",(initial_ts_list>>8)&0xff,initial_ts_list&0xff);

	/* copy over filename */
	for(x=0;x<strlen(apple_filename);x++) {
		catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_NAME+x]=
		apple_filename[x]^0x80;
	}

	/* pad out the filename with spaces */
	for(x=strlen(apple_filename);x<FILE_NAME_SIZE;x++) {
		catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_NAME+x]=' '^0x80;
	}

	/* fill in filesize in sectors */
	catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_SIZE_L]=
		sectors_used&0xff;
	catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)+FILE_SIZE_H]=
		(sectors_used>>8)&0xff;

	/* write out catalog sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=write(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");
#endif
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
	unsigned char sector_buffer[PRODOS_BYTES_PER_BLOCK];
	int result,chunk,chunk_block;
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
			/* Just a single block */
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
			/* truncate to actual size of file */
			ftruncate(output_fd,file.eof);

			break;

		case PRODOS_FILE_TREE:


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



    /* rename a file.  fts=entry/track/sector */
    /* FIXME: can we rename a locked file?    */
    /* FIXME: validate the new filename is valid */
static int prodos_rename_file(int fd,int fts,char *new_name) {

#if 0
	int catalog_file,catalog_track,catalog_sector;
	int x,result;
	unsigned char sector_buffer[PRODOS_BYTES_PER_BLOCK];

	catalog_file=fts>>16;
	catalog_track=(fts>>8)&0xff;
	catalog_sector=(fts&0xff);

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	/* copy over filename */
	for(x=0;x<strlen(new_name);x++) {
		sector_buffer[CATALOG_FILE_LIST+
				(catalog_file*CATALOG_ENTRY_SIZE)+
				FILE_NAME+x]=new_name[x]^0x80;
	}

	/* pad out the filename with spaces */
	for(x=strlen(new_name);x<FILE_NAME_SIZE;x++) {
		sector_buffer[CATALOG_FILE_LIST+
				(catalog_file*CATALOG_ENTRY_SIZE)+
				FILE_NAME+x]=' '^0x80;
	}

	/* write back modified catalog sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=write(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	if (result<0) {
		fprintf(stderr,"Error on I/O\n");
	}
#endif
	return 0;
}


static int prodos_delete_file(struct voldir_t *voldir,int fd,int fsl) {

#if 0

	int i;
	int catalog_track,catalog_sector,catalog_entry;
	int ts_track,ts_sector;
	char file_type;
	int result;
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];

	/* unpack file/track/sector info */
	catalog_entry=fsl>>16;
	catalog_track=(fsl>>8)&0xff;
	catalog_sector=(fsl&0xff);


	/* Load in the catalog table for the file */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	file_type=catalog_buffer[CATALOG_FILE_LIST+
			(catalog_entry*CATALOG_ENTRY_SIZE)
			+FILE_TYPE];

	if (file_type&0x80) {
		fprintf(stderr,"File is locked!  Unlock before deleting!\n");
		exit(1);
	}

	/* get pointer to t/s list */
	ts_track=catalog_buffer[CATALOG_FILE_LIST+
			catalog_entry*CATALOG_ENTRY_SIZE+FILE_TS_LIST_T];
	ts_sector=catalog_buffer[CATALOG_FILE_LIST+
			catalog_entry*CATALOG_ENTRY_SIZE+FILE_TS_LIST_S];

keep_deleting:

	/* load in the t/s list info */
	lseek(fd,DISK_OFFSET(ts_track,ts_sector),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	/* Free each sector listed by t/s list */
	for(i=0;i<TSL_MAX_NUMBER;i++) {
		/* If t/s = 0/0 then no need to clear */
		if ((catalog_buffer[TSL_LIST+2*i]==0) &&
			(catalog_buffer[TSL_LIST+2*i+1]==0)) {
		}
		else {
			prodos_free_sector(voldir,fd,catalog_buffer[TSL_LIST+2*i],
				catalog_buffer[TSL_LIST+2*i+1]);
		}
	}

	/* free the t/s list */
	prodos_free_sector(voldir,fd,ts_track,ts_sector);

	/* Point to next t/s list */
	ts_track=catalog_buffer[TSL_NEXT_TRACK];
	ts_sector=catalog_buffer[TSL_NEXT_SECTOR];

	/* If more tsl lists, keep looping */
	if ((ts_track==0x0) && (ts_sector==0x0)) {
	}
	else {
		goto keep_deleting;
	}

	/* Erase file from catalog entry */

	/* First reload proper catalog sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	/* save track as last char of name, for undelete purposes */
	catalog_buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)+
		(FILE_NAME+FILE_NAME_SIZE-1)]=
		catalog_buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)];

	/* Actually delete the file */
	/* by setting the track value to FF which indicates deleted file */
	catalog_buffer[CATALOG_FILE_LIST+(catalog_entry*CATALOG_ENTRY_SIZE)]=0xff;

	/* re seek to catalog position and write out changes */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=write(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");
#endif
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
	printf("\tCATALOG   [dir]\n");
	printf("\tLOAD      apple_file <local_file>\n");
	printf("\tSAVE      type local_file <apple_file>\n");
	printf("\tBSAVE     [-a addr] [-l len] local_file <apple_file>\n");
	printf("\tDELETE    apple_file\n");
	printf("\tRENAME    apple_file_old apple_file_new\n");
	printf("\tDUMP\n");
	printf("\tTYPE      TODO: set type\n");
	printf("\tAUX       TODO: set aux\n");
	printf("\tTIMESTAMP TODO: set timestamp\n");
	printf("\tACCESS    TODO: set access\n");

	printf("\n");
	return;
}

#define COMMAND_LOAD	 0
#define COMMAND_SAVE	 1
#define COMMAND_CATALOG	 2
#define COMMAND_DELETE	 3
#define COMMAND_RENAME	 4
#define COMMAND_DUMP	 5
#define COMMAND_BSAVE	 6
#define COMMAND_BLOAD	 7
#define COMMAND_SHOWFREE	8

#define MAX_COMMAND	9
#define COMMAND_UNKNOWN	255

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
	{COMMAND_BSAVE,"BSAVE"},
	{COMMAND_BLOAD,"BLOAD"},
	{COMMAND_SHOWFREE,"SHOWFREE"},
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
	unsigned char type='b';
	int prodos_fd=0,i;
	int interleave=PRODOS_INTERLEAVE_PRODOS,arg_interleave=0;

	int command,catalog_entry;
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
	struct file_entry_t file;

	/* Check command line arguments */
	while ((c = getopt (argc, argv,"a:i:l:t:s:dhvxy"))!=-1) {
		switch (c) {

		case 'd':
			fprintf(stderr,"DEBUG enabled\n");
			debug=1;
			break;
		case 'a':
			address=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Address=%d\n",address);
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

	/* Try to autodetch interleave based on filename */
	if (strlen(image)>4) {
		if (!strncmp(&image[strlen(image)-4],".dsk",4)) {
			if (debug) printf("Detected DOS33 interleave\n");
			interleave=PRODOS_INTERLEAVE_DOS33;
		}
	}
	/* override inteleave if set */
	if (arg_interleave) {
		interleave=arg_interleave-1;
	}

	prodos_read_voldir(prodos_fd,&voldir,interleave);

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

		prodos_catalog(prodos_fd,&voldir);

		break;

	case COMMAND_SAVE:
		/* argv3 == type == A,B,T,I,N,L etc */
		/* argv4 == name of local file */
		/* argv5 == optional name of file on disk image */

		if (argc==optind) {
			fprintf(stderr,"Error! Need type and file_name\n");
			fprintf(stderr,"%s %s SAVE type "
					"file_name apple_filename\n\n",
					argv[0],image);
			goto exit_and_close;
		}

		type=argv[optind][0];
		optind++;

	case COMMAND_BSAVE:

		if (debug) printf("\ttype=%c\n",type);
//#if 0
		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");

			if (command==COMMAND_BSAVE) {
				fprintf(stderr,"%s %s BSAVE "
						"file_name apple_filename\n\n",
						argv[0],image);

			}
			else {
				fprintf(stderr,"%s %s SAVE type "
						"file_name apple_filename\n\n",
						argv[0],image);
			}
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

		catalog_entry=prodos_check_file_exists(&voldir,apple_filename,
							DOS33_FILE_NORMAL);

		if (catalog_entry>=0) {
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
			prodos_delete_file(&voldir,prodos_fd,catalog_entry);
		}
		if (command==COMMAND_SAVE) {
			prodos_add_file(&voldir,prodos_fd,type,
				ADD_RAW, address, length,
				local_filename,apple_filename);
		}
		else {
			prodos_add_file(&voldir,prodos_fd,type,
				ADD_BINARY, address, length,
				local_filename,apple_filename);
		}
//#endif
		break;


	case COMMAND_DELETE:

		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");
			fprintf(stderr,"%s %s DELETE apple_filename\n",
				argv[0],image);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		catalog_entry=prodos_check_file_exists(&voldir,
						apple_filename,
						DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr, "Error!  File %s does not exist\n",
					apple_filename);
			goto exit_and_close;
		}
		prodos_delete_file(&voldir,prodos_fd,catalog_entry);

		break;

	case COMMAND_DUMP:
		printf("Dumping %s!\n",image);
		prodos_dump(&voldir,prodos_fd);
		break;

	case COMMAND_SHOWFREE:
		printf("Showing Free %s!\n",image);
		prodos_showfree(&voldir,prodos_fd);
		break;

	case COMMAND_RENAME:
		/* check and make sure we have apple_filename */
		if (argc==optind) {
			fprintf(stderr,"Error! Need two filenames\n");
			fprintf(stderr,"%s %s LOCK apple_filename_old "
				"apple_filename_new\n",
				argv[0],image);
	     		goto exit_and_close;
		}

		/* Truncate filename if too long */
		truncate_filename(apple_filename,argv[optind]);
		optind++;

		if (argc==optind) {
			fprintf(stderr,"Error! Need two filenames\n");
			fprintf(stderr,"%s %s LOCK apple_filename_old "
				"apple_filename_new\n",
				argv[0],image);
	     		goto exit_and_close;
		}

		truncate_filename(new_filename,argv[optind]);

		/* get the entry/track/sector for file */
		catalog_entry=prodos_check_file_exists(&voldir,
						apple_filename,
						DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr,"Error!  %s not found!\n",
							apple_filename);
			goto exit_and_close;
		}

		prodos_rename_file(prodos_fd,catalog_entry,new_filename);

		break;

	default:
		fprintf(stderr,"Sorry, unsupported command %s\n\n",temp_string);
		goto exit_and_close;
	}

exit_and_close:
	close(prodos_fd);

	return 0;
}
