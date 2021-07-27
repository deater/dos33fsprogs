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

static int debug=0,ignore_errors=0;

static unsigned char get_high_byte(int value) {
	return (value>>8)&0xff;
}

static unsigned char get_low_byte(int value) {
	return (value&0xff);
}

    /* Read volume directory into a buffer */
static int prodos_read_voldir(int fd, struct voldir_t *voldir) {

	int result;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];

	/* read in VOLDIR */
	voldir->fd=fd;
	result=prodos_read_block(voldir,voldir_buffer,PRODOS_VOLDIR_BLOCK);

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

	voldir->creation_time=(voldir_buffer[0x1c]<<24)|
			(voldir_buffer[0x1d]<<16)|
			(voldir_buffer[0x1e]<<8)|
			(voldir_buffer[0x1f]<<0);

	voldir->version=voldir_buffer[0x20];
	voldir->min_version=voldir_buffer[0x21];
	voldir->access=voldir_buffer[0x22];
	voldir->entry_length=voldir_buffer[0x23];
	voldir->entries_per_block=voldir_buffer[0x24];
	voldir->file_count=voldir_buffer[0x25]|(voldir_buffer[0x26]<<8);
	voldir->bit_map_pointer=voldir_buffer[0x27]|(voldir_buffer[0x28]<<8);
	voldir->total_blocks=voldir_buffer[0x29]|(voldir_buffer[0x2A]<<8);


	return 0;
}


	/* Checks if "filename" exists */
	/* returns entry/track/sector  */
static int prodos_check_file_exists(int fd,
					char *filename,
					int file_deleted) {

	int catalog_track,catalog_sector;
	int i,file_track;
	char file_name[31];
	int result;
	struct voldir_t voldir;
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];

	/* read the VOLDIR into buffer */
	prodos_read_voldir(fd,&voldir);
#if 0
	/* FIXME: we have a function for this */
	/* get the catalog track and sector from the VTOC */
	catalog_track=voldir[VTOC_CATALOG_T];
	catalog_sector=voldir[VTOC_CATALOG_S];

repeat_catalog:

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	/* scan all file entries in catalog sector */
	for(i=0;i<7;i++) {
		file_track=catalog_buffer[CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE)];
		/* 0xff means file deleted */
		/* 0x0 means empty */
		if (file_track!=0x0) {

			if (file_track==0xff) {
				prodos_filename_to_ascii(file_name,
					catalog_buffer+(CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE+FILE_NAME)),29);

				if (file_deleted) {
					/* return if we found the file */
					if (!strncmp(filename,file_name,29)) {
						return ((i<<16)+(catalog_track<<8)+catalog_sector);
					}
				}
			}
			else {
				prodos_filename_to_ascii(file_name,
					catalog_buffer+(CATALOG_FILE_LIST+(i*CATALOG_ENTRY_SIZE+FILE_NAME)),30);
				/* return if we found the file */
				if (!strncmp(filename,file_name,30)) {
					return ((i<<16)+(catalog_track<<8)+catalog_sector);
				}
			}
		}
	}

	/* point to next catalog track/sector */
	catalog_track=catalog_buffer[CATALOG_NEXT_T];
	catalog_sector=catalog_buffer[CATALOG_NEXT_S];

	if (catalog_sector!=0) goto repeat_catalog;

	if (result<0) fprintf(stderr,"Error on I/O\n");
#endif
	return -1;
}

static int prodos_free_sector(struct voldir_t *voldir,int fd,int track,int sector) {

	int result;

	/* mark as free in VTOC */
	prodos_voldir_free_sector(voldir,track,sector);
#if 0
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

	int found_track=0,found_sector=0;
	int result;

	/* Find an empty sector */
	result=prodos_voldir_find_free_sector(voldir,&found_track,&found_sector);

	if (result<0) {
		fprintf(stderr,"ERROR: prodos_allocate_sector: Disk full!\n");
		return -1;
	}

#if 0
	/* store new track/direction info */
	voldir[VTOC_LAST_ALLOC_T]=found_track;

//	if (found_track>PRODOS_VOLDIR_TRACK) vtoc[VTOC_ALLOC_DIRECT]=1;
//	else vtoc[VTOC_ALLOC_DIRECT]=-1;

	/* Seek to VTOC */
	lseek(fd,DISK_OFFSET(PRODOS_VOLDIR_TRACK,PRODOS_VOLDIR_BLOCK),SEEK_SET);

	/* Write out VTOC */
	result=write(fd,voldir,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");
#endif
	return ((found_track<<8)+found_sector);
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
#if 0
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


    /* load a file.  fts=entry/track/sector */
static int prodos_load_file(int fd,int fts,char *filename) {

	int output_fd;
	int catalog_file,catalog_track,catalog_sector;
	int file_type,file_size=-1,tsl_track,tsl_sector,data_t,data_s;
	unsigned char data_sector[PRODOS_BYTES_PER_BLOCK];
	unsigned char sector_buffer[PRODOS_BYTES_PER_BLOCK];
	int tsl_pointer=0,output_pointer=0;
	int result;

	/* FIXME!  Warn if overwriting file! */
	output_fd=open(filename,O_WRONLY|O_CREAT|O_TRUNC,0666);
	if (output_fd<0) {
		fprintf(stderr,"Error! could not open %s for local save\n",
			filename);
		return -1;
	}

	catalog_file=fts>>16;
	catalog_track=(fts>>8)&0xff;
	catalog_sector=(fts&0xff);


	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	tsl_track=sector_buffer[CATALOG_FILE_LIST+
			(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TS_LIST_T];
	tsl_sector=sector_buffer[CATALOG_FILE_LIST+
			(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TS_LIST_S];
	file_type=prodos_file_type(sector_buffer[CATALOG_FILE_LIST+
			(catalog_file*CATALOG_ENTRY_SIZE)+FILE_TYPE]);

//	printf("file_type: %c\n",file_type);

keep_saving:
	/* Read in TSL Sector */
	lseek(fd,DISK_OFFSET(tsl_track,tsl_sector),SEEK_SET);
	result=read(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);
	tsl_pointer=0;

	/* check each track/sector pair in the list */
	while(tsl_pointer<TSL_MAX_NUMBER) {

		/* get the t/s value */
		data_t=sector_buffer[TSL_LIST+(tsl_pointer*TSL_ENTRY_SIZE)];
		data_s=sector_buffer[TSL_LIST+(tsl_pointer*TSL_ENTRY_SIZE)+1];

		if ((data_s==0) && (data_t==0)) {
			/* empty */
		}
		else {
			lseek(fd,DISK_OFFSET(data_t,data_s),SEEK_SET);
			result=read(fd,&data_sector,PRODOS_BYTES_PER_BLOCK);

			/* some file formats have the size in the first sector */
			/* so cheat and get real file size from file itself    */
			if (output_pointer==0) {
				switch(file_type) {
				case 'A':
				case 'I':
					file_size=data_sector[0]+(data_sector[1]<<8)+2;
					break;
				case 'B':
					file_size=data_sector[2]+(data_sector[3]<<8)+4;
					break;
				default:
					file_size=-1;
				}
			}

			/* write the block read in out to the output file */
			lseek(output_fd,output_pointer*PRODOS_BYTES_PER_BLOCK,SEEK_SET);
			result=write(output_fd,&data_sector,PRODOS_BYTES_PER_BLOCK);
		}
		output_pointer++;
		tsl_pointer++;
	}

	/* finished with TSL sector, see if we have another */
	tsl_track=sector_buffer[TSL_NEXT_TRACK];
	tsl_sector=sector_buffer[TSL_NEXT_SECTOR];

//	printf("Next track/sector=%d/%d op=%d\n",tsl_track,tsl_sector,
//		output_pointer*PRODOS_BYTES_PER_BLOCK);

	if ((tsl_track==0) && (tsl_sector==0)) {
	}
	else goto keep_saving;

	/* Correct the file size */
	if (file_size>=0) {
//		printf("Truncating file size to %d\n",file_size);
		result=ftruncate(output_fd,file_size);
	}

	if (result<0) fprintf(stderr,"Error on I/O\n");

	return 0;

}

    /* lock a file.  fts=entry/track/sector */
static int prodos_lock_file(int fd,int fts,int lock) {

	int catalog_file,catalog_track,catalog_sector;
	int file_type,result;
	unsigned char sector_buffer[PRODOS_BYTES_PER_BLOCK];

	catalog_file=fts>>16;
	catalog_track=(fts>>8)&0xff;
	catalog_sector=(fts&0xff);


	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	file_type=sector_buffer[CATALOG_FILE_LIST+
				(catalog_file*CATALOG_ENTRY_SIZE)
				+FILE_TYPE];

	if (lock) file_type|=0x80;
	else file_type&=0x7f;

	sector_buffer[CATALOG_FILE_LIST+
				(catalog_file*CATALOG_ENTRY_SIZE)
				+FILE_TYPE]=file_type;

	/* write back modified catalog sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=write(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");

	return 0;

}

    /* rename a file.  fts=entry/track/sector */
    /* FIXME: can we rename a locked file?    */
    /* FIXME: validate the new filename is valid */
static int prodos_rename_file(int fd,int fts,char *new_name) {

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

	return 0;
}

	/* undelete a file.  fts=entry/track/sector */
	/* FIXME: validate the new filename is valid */
static int prodos_undelete_file(int fd,int fts,char *new_name) {

	int catalog_file,catalog_track,catalog_sector;
	char replacement_char;
	int result;
	unsigned char sector_buffer[PRODOS_BYTES_PER_BLOCK];

	catalog_file=fts>>16;
	catalog_track=(fts>>8)&0xff;
	catalog_sector=(fts&0xff);

	/* Read in Catalog Sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=read(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	/* get the stored track value, and put it back  */
	/* FIXME: should walk file to see if T/s valild */
	/* by setting the track value to FF which indicates deleted file */
	sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)]=
		sector_buffer[CATALOG_FILE_LIST+
		(catalog_file*CATALOG_ENTRY_SIZE)+
		FILE_NAME+29];

	/* restore file name if possible */
	replacement_char=0xa0;
	if (strlen(new_name)>29) {
		replacement_char=new_name[29]^0x80;
	}

	sector_buffer[CATALOG_FILE_LIST+(catalog_file*CATALOG_ENTRY_SIZE)+
		FILE_NAME+29]=replacement_char;

	/* write back modified catalog sector */
	lseek(fd,DISK_OFFSET(catalog_track,catalog_sector),SEEK_SET);
	result=write(fd,sector_buffer,PRODOS_BYTES_PER_BLOCK);

	if (result<0) fprintf(stderr,"Error on I/O\n");

	return 0;
}


static int prodos_delete_file(struct voldir_t *voldir,int fd,int fsl) {

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

#if 0
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

/* ??? */
static int prodos_rename_hello(int fd, char *new_name) {

	char buffer[PRODOS_BYTES_PER_BLOCK];
	int i;

	lseek(fd,DISK_OFFSET(1,9),SEEK_SET);
	read(fd,buffer,PRODOS_BYTES_PER_BLOCK);

	for(i=0;i<30;i++) {
		if (i<strlen(new_name)) {
			buffer[0x75+i]=new_name[i]|0x80;
		}
		else {
			buffer[0x75+i]=' '|0x80;
		}
	}

	lseek(fd,DISK_OFFSET(1,9),SEEK_SET);
	write(fd,buffer,PRODOS_BYTES_PER_BLOCK);

	return 0;
}

static void display_help(char *name, int version_only) {
	printf("\nprodos version %s\n",VERSION);
	printf("by Vince Weaver <vince@deater.net>\n");
	printf("\n");

	if (version_only) return;

	printf("Usage: %s [-h] [-y] [-x] disk_image COMMAND [options]\n",name);
	printf("\t-h : this help message\n");
	printf("\t-y : always answer yes for anying warning questions\n");
	printf("\t-x : ignore errors (useful for making invalid filenames)\n");
	printf("\n");
	printf("  Where disk_image is a valid dos3.3 disk image\n"
		"  and COMMAND is one of the following:\n");
	printf("\tCATALOG\n");
	printf("\tLOAD     apple_file <local_file>\n");
	printf("\tSAVE     type local_file <apple_file>\n");
	printf("\tBSAVE    [-a addr] [-l len] local_file <apple_file>\n");
	printf("\tDELETE   apple_file\n");
	printf("\tLOCK     apple_file\n");
	printf("\tUNLOCK   apple_file\n");
	printf("\tRENAME   apple_file_old apple_file_new\n");
	printf("\tUNDELETE apple_file\n");
	printf("\tDUMP\n");
	printf("\tHELLO    apple_file\n");
#if 0
	printf("\tINIT\n");
	printf("\tCOPY\n");
#endif
	printf("\n");
	return;
}

#define COMMAND_LOAD	 0
#define COMMAND_SAVE	 1
#define COMMAND_CATALOG	 2
#define COMMAND_DELETE	 3
#define COMMAND_UNDELETE 4
#define COMMAND_LOCK	 5
#define COMMAND_UNLOCK	 6
#define COMMAND_INIT	 7
#define COMMAND_RENAME	 8
#define COMMAND_COPY	 9
#define COMMAND_DUMP	10
#define COMMAND_HELLO	11
#define COMMAND_BSAVE	12
#define COMMAND_BLOAD	13
#define COMMAND_SHOWFREE	14
#define COMMAND_RAW_WRITE	15

#define MAX_COMMAND	15
#define COMMAND_UNKNOWN	255

static struct command_type {
	int type;
	char name[32];
} commands[MAX_COMMAND] = {
	{COMMAND_LOAD,"LOAD"},
	{COMMAND_SAVE,"SAVE"},
	{COMMAND_CATALOG,"CATALOG"},
	{COMMAND_DELETE,"DELETE"},
	{COMMAND_UNDELETE,"UNDELETE"},
	{COMMAND_LOCK,"LOCK"},
	{COMMAND_UNLOCK,"UNLOCK"},
	{COMMAND_INIT,"INIT"},
	{COMMAND_RENAME,"RENAME"},
	{COMMAND_COPY,"COPY"},
	{COMMAND_DUMP,"DUMP"},
	{COMMAND_HELLO,"HELLO"},
	{COMMAND_BSAVE,"BSAVE"},
	{COMMAND_SHOWFREE,"SHOWFREE"},
	{COMMAND_RAW_WRITE,"RAWWRITE"},
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
	if (strlen(in)>30) {
		fprintf(stderr,"Warning!  Truncating %s to 30 chars\n",in);
		truncated=1;
	}
	strncpy(out,in,30);
	out[30]='\0';

	return truncated;
}

int main(int argc, char **argv) {

	char image[BUFSIZ];
	unsigned char type='b';
	int dos_fd=0,i;

	int command,catalog_entry;
	char temp_string[BUFSIZ];
	char apple_filename[31],new_filename[31];
	char local_filename[BUFSIZ];
	char *result_string;
	int always_yes=0;
	char *temp,*endptr;
	int c;
	int address=0, length=0;
	struct voldir_t voldir;

	/* Check command line arguments */
	while ((c = getopt (argc, argv,"a:l:t:s:dhvxy"))!=-1) {
		switch (c) {

		case 'd':
			fprintf(stderr,"DEBUG enabled\n");
			debug=1;
			break;
		case 'a':
			address=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Address=%d\n",address);
			break;
		case 'l':
			length=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Length=%d\n",address);
			break;
#if 0
		case 't':
			track=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Track=%d\n",address);
			break;
		case 's':
			sector=strtol(optarg,&endptr,0);
			if (debug) fprintf(stderr,"Sector=%d\n",address);
			break;
#endif
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
	dos_fd=open(image,O_RDWR);
	if (dos_fd<0) {
		fprintf(stderr,"Error opening disk_image: %s\n",image);
		return -1;
	}
	prodos_read_voldir(dos_fd,&voldir);

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


		/* get the entry/track/sector for file */
		catalog_entry=prodos_check_file_exists(dos_fd,
							apple_filename,
							DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr,"Error!  %s not found!\n",
				apple_filename);
			goto exit_and_close;
		}

		prodos_load_file(dos_fd,catalog_entry,local_filename);

		break;

       case COMMAND_CATALOG:
		prodos_read_voldir(dos_fd,&voldir);
		prodos_catalog(dos_fd,&voldir);

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
#if 0
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

		catalog_entry=prodos_check_file_exists(dos_fd,apple_filename,
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
			prodos_delete_file(voldir,dos_fd,catalog_entry);
		}
		if (command==COMMAND_SAVE) {
			prodos_add_file(&voldir,dos_fd,type,
				ADD_RAW, address, length,
				local_filename,apple_filename);
		}
		else {
			prodos_add_file(&voldir,dos_fd,type,
				ADD_BINARY, address, length,
				local_filename,apple_filename);
		}
#endif
		break;


	case COMMAND_RAW_WRITE:

		fprintf(stderr,"ERROR!  Not implemented!\n\n");
		goto exit_and_close;

		break;

	case COMMAND_DELETE:

		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");
			fprintf(stderr,"%s %s DELETE apple_filename\n",
				argv[0],image);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		catalog_entry=prodos_check_file_exists(dos_fd,
						apple_filename,
						DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr, "Error!  File %s does not exist\n",
					apple_filename);
			goto exit_and_close;
		}
		prodos_delete_file(&voldir,dos_fd,catalog_entry);

		break;

	case COMMAND_DUMP:
		printf("Dumping %s!\n",image);
		prodos_dump(&voldir,dos_fd);
		break;

	case COMMAND_SHOWFREE:
		printf("Showing Free %s!\n",image);
		prodos_showfree(&voldir,dos_fd);
		break;

	case COMMAND_LOCK:
	case COMMAND_UNLOCK:
		/* check and make sure we have apple_filename */
		if (argc==optind) {
			fprintf(stderr,"Error! Need apple file_name\n");
			fprintf(stderr,"%s %s %s apple_filename\n",
				argv[0],image,temp_string);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		/* get the entry/track/sector for file */
		catalog_entry=prodos_check_file_exists(dos_fd,
							apple_filename,
							DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr,"Error!  %s not found!\n",
				apple_filename);
			goto exit_and_close;
		}

		prodos_lock_file(dos_fd,catalog_entry,command==COMMAND_LOCK);

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
		catalog_entry=prodos_check_file_exists(dos_fd,
						apple_filename,
						DOS33_FILE_NORMAL);
		if (catalog_entry<0) {
			fprintf(stderr,"Error!  %s not found!\n",
							apple_filename);
			goto exit_and_close;
		}

		prodos_rename_file(dos_fd,catalog_entry,new_filename);

		break;

	case COMMAND_UNDELETE:
		/* check and make sure we have apple_filename */
		if (argc==optind) {
			fprintf(stderr,"Error! Need apple file_name\n");
			fprintf(stderr,"%s %s UNDELETE apple_filename\n\n",
				argv[0],image);
			goto exit_and_close;
		}

		/* Truncate filename if too long */
		/* what to do about last char ? */

		truncate_filename(apple_filename,argv[optind]);

		/* get the entry/track/sector for file */
		catalog_entry=prodos_check_file_exists(dos_fd,
						apple_filename,
						DOS33_FILE_DELETED);
		if (catalog_entry<0) {
			fprintf(stderr,"Error!  %s not found!\n",
				apple_filename);
			goto exit_and_close;
		}

		prodos_undelete_file(dos_fd,catalog_entry,apple_filename);

		break;

	case COMMAND_HELLO:
		if (argc==optind) {
			fprintf(stderr,"Error! Need file_name\n");
			fprintf(stderr,"%s %s HELLO apple_filename\n\n",
				argv[0],image);
			goto exit_and_close;
		}

		truncate_filename(apple_filename,argv[optind]);

		catalog_entry=prodos_check_file_exists(dos_fd,
						apple_filename,
						DOS33_FILE_NORMAL);

		if (catalog_entry<0) {
			fprintf(stderr,
				"Warning!  File %s does not exist\n",
					apple_filename);
		}
		prodos_rename_hello(dos_fd,apple_filename);
		break;

	case COMMAND_INIT:
		/* use common code from mkprodosfs? */
	case COMMAND_COPY:
		/* use temp file?  Walking a sector at a time seems a pain */
	default:
		fprintf(stderr,"Sorry, unsupported command %s\n\n",temp_string);
		goto exit_and_close;
	}

exit_and_close:
	close(dos_fd);

	return 0;
}
