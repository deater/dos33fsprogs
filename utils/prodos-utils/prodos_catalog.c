#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

#include "prodos.h"

//static int debug=0;


	/* returns the next valid catalog entry */
	/* after the one passed in */

	/* inode = block<<8|entry */

static int prodos_find_next_file(int inode, struct voldir_t *voldir) {

	int result,catalog_block,catalog_offset;
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	int storage_type,file;

	catalog_block=inode>>8;
	catalog_offset=inode&0xff;

	catalog_offset++;

	while(1) {

		/* Read in Sector */
		result=prodos_read_block(voldir,catalog_buffer,catalog_block);
                if (result<0) {
			fprintf(stderr,"Error on I/O\n");
			return -1;
		}

		for(file=catalog_offset;
                        file<voldir->entries_per_block;file++) {

			storage_type=(catalog_buffer[4+file*PRODOS_FILE_DESC_LEN]>>4)&0xf;

			if (storage_type!=PRODOS_FILE_DELETED) {

				return (catalog_block<<8)|file;
			}
		}

		catalog_offset=0;
		catalog_block=catalog_buffer[2]|
				(catalog_buffer[3]<<8);
		if (catalog_block==0) break;

	}

	return -1;
}

int prodos_populate_filedesc(unsigned char *file_desc,
		struct file_entry_t *file_entry) {

	file_entry->storage_type=(file_desc[0]>>4)&0xf;
	file_entry->name_length=file_desc[0]&0xf;
	memcpy(&file_entry->file_name[0],&file_desc[1],
		file_entry->name_length);
	file_entry->file_name[file_entry->name_length]=0;

	file_entry->file_type=file_desc[0x10];
	file_entry->key_pointer=file_desc[0x11]|file_desc[0x12]<<8;
	file_entry->blocks_used=file_desc[0x13]|file_desc[0x14]<<8;
	file_entry->eof=file_desc[0x15]|file_desc[0x16]<<8|
		file_desc[0x17]<<16;
	file_entry->creation_time=(file_desc[0x18]<<16)|
			(file_desc[0x19]<<24)|
			(file_desc[0x1a]<<0)|
			(file_desc[0x1b]<<8);
	file_entry->version=file_desc[0x1c];
	file_entry->min_version=file_desc[0x1d];
	file_entry->access=file_desc[0x1e];
	file_entry->aux_type=file_desc[0x1f]|file_desc[0x20]<<8;
	file_entry->last_mod=(file_desc[0x21]<<16)|
			(file_desc[0x22]<<24)|
			(file_desc[0x23]<<0)|
			(file_desc[0x24]<<8);
	file_entry->header_pointer=file_desc[0x25]|file_desc[0x26]<<8;

	return 0;
}

static int prodos_print_short_filetype(int type) {

	switch(type) {
		case 0x01: printf("BAD"); break;	/* Bad Blocks */
		case 0x04: printf("TXT"); break;	/* ASCII Text */
		case 0x06: printf("BIN"); break;	/* Binary */
		case 0x0f: printf("DIR"); break;	/* Directory */
		case 0x19: printf("ADB"); break;	/* Appleworks Database */
		case 0x1A: printf("AWP"); break;	/* Appleworks Word Processing */
		case 0x1B: printf("ASP"); break;	/* AppleWorks Spreadsheet */
		case 0xEF: printf("PAS"); break;	/* PASCAL */
		case 0xF0: printf("CMD"); break;	/* Command */
                case 0xF1: case 0xF2: case 0xF3: case 0xF4:
                case 0xF5: case 0xF6: case 0xF7: case 0xF8:
				printf("USR"); break;
		case 0xFC: printf("BAS"); break;	/* Applesoft BASIC */
		case 0xFD: printf("VAR"); break;	/* Applesoft variables */
                case 0xFE: printf("REL"); break;	/* Relocatable Object */
                case 0xFF: printf("SYS"); break;	/* ProDOS system */
		default:
		case 0x00: printf("???"); break;
	}


	return 0;
}

static unsigned char prodos_capital_month_names[12][4]={
        "JAN","FEB","MAR","APR","MAY","JUN",
        "JUL","AUG","SEP","OCT","NOV","DEC",
};

static int prodos_text_timestamp(int t, unsigned char *timestamp) {

	int year,month,day,hour,minute;

	year=(t>>25)&0x7f;
	month=(t>>21)&0xf;
	day=(t>>16)&0x1f;
	hour=(t>>8)&0x1f;
	minute=t&0x3f;

	sprintf((char *)timestamp,"%2d-%s-%02d %2d:%02d",
		day,prodos_capital_month_names[month-1],year,hour,minute);
	timestamp[16]=0;

	return 0;

}


static int prodos_print_file_info(int inode, struct voldir_t *voldir) {

	int result,catalog_block,catalog_offset;
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char file_desc[PRODOS_FILE_DESC_LEN];
	struct file_entry_t file_entry;
	unsigned char timestamp[17];

	catalog_block=inode>>8;
	catalog_offset=inode&0xff;

	/* Read in Sector */
	result=prodos_read_block(voldir,catalog_buffer,catalog_block);
	if (result<0) {
		fprintf(stderr,"Error on I/O\n");
		return -1;
	}

	memcpy(file_desc,
		catalog_buffer+4+catalog_offset*PRODOS_FILE_DESC_LEN,
		PRODOS_FILE_DESC_LEN);

	prodos_populate_filedesc(file_desc,&file_entry);

	/* name */
	printf(" %-16s",file_entry.file_name);

	/* type */
	prodos_print_short_filetype(file_entry.file_type);

	/* blocks used */
	printf("%8d  ",file_entry.blocks_used);

	/* modified timestamp */
	prodos_text_timestamp(file_entry.last_mod,timestamp);
	printf("%s  ",timestamp);

	/* creation timestamp */
	prodos_text_timestamp(file_entry.creation_time,timestamp);
	printf("%s ",timestamp);

	/* eof */
	printf("%8d ",file_entry.eof);

	switch(file_entry.file_type) {

//		case PRODOS_TYPE_TXT:
//			printf("L=$%04X",file_entry.aux_type);
//			break;
		case PRODOS_TYPE_BIN:
			printf("A=$%04X",file_entry.aux_type);
			break;
//		case PRODOS_TYPE_BAS:
//			printf("A=$%04X",file_entry.aux_type);
//			break;
//		case PRODOS_TYPE_VAR:
//			printf("A=$%04X",file_entry.aux_type);
//			break;
//		case PRODOS_TYPE_SYS:
//			printf("A=$%04X",file_entry.aux_type);
//			break;

		default: break;
	}

	printf("\n");


	return 0;
}

void prodos_catalog(int dos_fd, struct voldir_t *voldir) {

	int catalog_block,catalog_offset,catalog_inode;
	int blocks_free=0;

	blocks_free=prodos_voldir_free_space(voldir);

	printf("\n");
	printf("/%s\n\n",voldir->volume_name);

	printf(" NAME           TYPE  BLOCKS  MODIFIED         CREATED          ENDFILE SUBTYPE\n");
	printf("\n");

	catalog_block=PRODOS_VOLDIR_KEY_BLOCK;
	catalog_offset=0;	/* skip the header */
	catalog_inode=(catalog_block<<8)|catalog_offset;

	while(1) {
		catalog_inode=prodos_find_next_file(catalog_inode,voldir);
		if (catalog_inode==-1) break;
		prodos_print_file_info(catalog_inode,voldir);
	}

	printf("\n");
	printf("BLOCKS FREE:  % 3d ",blocks_free);
	printf("    BLOCKS USED: % 3d ",voldir->total_blocks-blocks_free);
	printf("    TOTAL BLOCKS: % 3d ",voldir->total_blocks);

	printf("\n\n");
}
