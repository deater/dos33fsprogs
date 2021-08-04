#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <time.h>

#include "version.h"

#include "prodos.h"


extern int debug;

#if 0
static int dump_block(unsigned char *block_buffer) {

	int i,j;

	for(i=0;i<32;i++) {
		printf("$%03X : ",i*16);
		for(j=0;j<16;j++) {
			printf("%02X ",block_buffer[i*16+j]);
		}
		printf("\n");
	}
	return 0;
}
#endif

static unsigned char month_names[12][4]={
	"Jan","Feb","Mar","Apr","May","Jun",
	"Jul","Aug","Sep","Oct","Nov","Dec",
};

static void prodos_print_time(int t) {
	int year,month,day,hour,minute;

	/* babb0f08: 15:08 28 Dec 1993 should be 27 May 1993 15:08 */

	/* 1011 1010 - yyyy yyym, y=101 1101 = 0x5d = 93 */
	/* 1011 1011 - mmmd dddd, m=0101  = 0x05 = May */
	/*                        d=1 1011 = 0x1b = 27 */
	/* 0000 1111 - 000h hhhh, h=15 */
	/* 0000 1000 - 00mm mmmm, m=8 */

	/* epoch seems to be 1900 */
	year=(t>>25)&0x7f;
	month=(t>>21)&0xf;
	day=(t>>16)&0x1f;
	hour=(t>>8)&0x1f;
	minute=t&0x3f;

	printf("%d:%02d %d %s %d",hour,minute,
		day,month_names[month-1],1900+year);

}

static void prodos_print_access(int access) {

	if (access&PRODOS_ACCESS_DESTROY) printf("DESTROY ");
	if (access&PRODOS_ACCESS_RENAME) printf("RENAME ");
	if (access&PRODOS_ACCESS_CHANGED) printf("CHANGED ");
	if (access&PRODOS_ACCESS_WRITE) printf("WRITE ");
	if (access&PRODOS_ACCESS_READ) printf("READ ");

}


static void prodos_print_storage_type(int type) {

	switch(type) {

		case PRODOS_FILE_DELETED:
			printf("Deleted\n");
			break;
		case PRODOS_FILE_SEEDLING:
			printf("Seedling\n");
			break;
		case PRODOS_FILE_SAPLING:
			printf("Sapling\n");
			break;
		case PRODOS_FILE_TREE:
			printf("Tree\n");
			break;
		case PRODOS_FILE_SUBDIR:
			printf("Subdir\n");
			break;
		case PRODOS_FILE_SUBDIR_HDR:
			printf("Subdir Header\n");
			break;
		case PRODOS_FILE_VOLUME_HDR:
			printf("Volume Header\n");
			break;
		default:
			printf("Unknown\n");
			break;
	}
}

static void prodos_print_file_type(int type) {

	switch(type) {
		case 0x00:
			printf("Typeless\n");
			break;
		case 0x01:
			printf("BAD: Bad Blocks\n");
			break;
		case 0x04:
			printf("TXT: ASCII Text\n");
			break;
		case 0x06:
			printf("BIN: Binary\n");
			break;
		case 0x0f:
			printf("DIR: Directory\n");
			break;
		case 0x19:
			printf("ADB: AppleWorks Database\n");
			break;
		case 0x1A:
			printf("AWP: AppleWorks Word Processing\n");
			break;
		case 0x1B:
			printf("ASP: AppleWorks Spreadsheet\n");
			break;
		case 0xEF:
			printf("PAS: PASCAL\n");
			break;
		case 0xF0:
			printf("CMD: Command\n");
			break;
		case 0xF1: case 0xF2: case 0xF3: case 0xF4:
		case 0xF5: case 0xF6: case 0xF7: case 0xF8:
			printf("User defined %x\n",type);
			break;
		case 0xFC:
			printf("BAS: Applesoft BASIC\n");
			break;
		case 0xFD:
			printf("VAR: Applesoft variables\n");
			break;
		case 0xFE:
			printf("REL: Relocatable Object\n");
			break;
		case 0xFF:
			printf("SYS: ProDOS system\n");
			break;

		default:
			printf("Unknown\n");
			break;
	}
}


static void dump_voldir(struct voldir_t *voldir) {


//	printf("\nVOLDIR Block:\n");
//	dump_block(voldir);
	printf("\n\n");

	printf("VOLDIR INFORMATION:\n");
	printf("\tStorage Type: %02X\n",voldir->storage_type);
	printf("\tName Length: %d\n",voldir->name_length);
	printf("\tVolume Name: %s\n",voldir->volume_name);
	printf("\tCreation Time: ");
	prodos_print_time(voldir->creation_time);
	printf("\n");

	printf("\tVersion: %d\n",voldir->version);
	printf("\tMin Version: %d\n",voldir->min_version);
	printf("\tAccess: $%X ",voldir->access);
	prodos_print_access(voldir->access);
	printf("\n");
	printf("\tEntry Length: %d\n",voldir->entry_length);
	printf("\tEntries per block: %d\n",voldir->entries_per_block);
	printf("\tFile Count: %d\n",voldir->file_count);
	printf("\tBitmap Pointer: %d\n",voldir->bit_map_pointer);
	printf("\tTotal Blocks: %d\n",voldir->total_blocks);


}


int prodos_dump_subdir(struct voldir_t *voldir, int subdir_key_block) {

	unsigned char subdir_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char file_desc[PRODOS_FILE_DESC_LEN];
	int result;
	struct file_entry_t file_entry;
	struct subdir_t subdir;
	int subdir_block,subdir_offset,file;

	printf("\n");
	printf("Dumping subdir at $%X\n",subdir_key_block);

	result=prodos_read_block(voldir,subdir_buffer,subdir_key_block);

	subdir.storage_type=subdir_buffer[0x04]>>4;
	subdir.name_length=subdir_buffer[0x04]&0xf;
	memcpy(subdir.subdir_name,&subdir_buffer[0x05],15);
	subdir.subdir_name[subdir.name_length]=0;
	/* note 0x14 must be $75??? */
	subdir.creation_time=(subdir_buffer[0x1c]<<16)|
                        (subdir_buffer[0x1d]<<24)|
                        (subdir_buffer[0x1e]<<0)|
                        (subdir_buffer[0x1f]<<8);
	subdir.version=subdir_buffer[0x20];
	subdir.min_version=subdir_buffer[0x21];
	subdir.access=subdir_buffer[0x22];
	subdir.entry_length=subdir_buffer[0x23];
	subdir.entries_per_block=subdir_buffer[0x24];
	subdir.file_count=(subdir_buffer[0x25]|(subdir_buffer[0x26]<<8));
	subdir.parent_pointer=(subdir_buffer[0x27]|(subdir_buffer[0x28]<<8));
	subdir.parent_entry=subdir_buffer[0x29];
	subdir.parent_entry_length=subdir_buffer[0x2A];


	printf("\tStorage type: ($%x): ",subdir.storage_type);
	prodos_print_storage_type(subdir.storage_type);
	printf("\tName length: $%x\n",subdir.name_length);
	printf("\tName: %s\n",subdir.subdir_name);
	printf("\tCreation Time (%x): ",subdir.creation_time);
	prodos_print_time(subdir.creation_time);
	printf("\n");
	printf("\tVersion: %d\n",subdir.version);
	printf("\tMin Version: %d\n",subdir.min_version);
	printf("\tAccess (%x): ",subdir.access);
	prodos_print_access(subdir.access);
	printf("\n");
	printf("\tEntry length: %d\n",subdir.entry_length);
	printf("\tEntries per block: %d\n",subdir.entries_per_block);
	printf("\tFile count: %d\n",subdir.file_count);
	printf("\tParent Pointer: $%x\n",subdir.parent_pointer);
	printf("\tParent Entry: $%x\n",subdir.parent_entry);
	printf("\tParent Entry Length: $%x\n",subdir.parent_entry_length);

	subdir_block=subdir_key_block;
	subdir_offset=1;	/* skip the header */

	while(1) {

		result=prodos_read_block(voldir,subdir_buffer,subdir_block);
		if (result<0) fprintf(stderr,"Error on I/O\n");

		for(file=subdir_offset;
			file<subdir.entries_per_block;file++) {

			memcpy(file_desc,
				subdir_buffer+4+file*PRODOS_FILE_DESC_LEN,
				PRODOS_FILE_DESC_LEN);
			prodos_populate_filedesc(file_desc,&file_entry);

			if (file_entry.storage_type==PRODOS_FILE_DELETED) continue;

			printf("\n\n");
			printf("FILE $%X-%d: %s\n",subdir_block,file,file_entry.file_name);
			printf("\t");
			prodos_print_storage_type(file_entry.storage_type);

			printf("\t");
			prodos_print_file_type(file_entry.file_type);

			printf("\tKey pointer: $%x\n",file_entry.key_pointer);

			printf("\tBlocks Used: %d\n",file_entry.blocks_used);

			printf("\tFile size (eof): %d\n",file_entry.eof);

			printf("\tCreation Time (%x): ",file_entry.creation_time);
			prodos_print_time(file_entry.creation_time);
			printf("\n");

			printf("\tVersion: %d\n",file_entry.version);

			printf("\tMin Version: %d\n",file_entry.min_version);

			printf("\tAccess (%x): ",file_entry.access);
			prodos_print_access(file_entry.access);
			printf("\n");

			printf("\tAux Type: %x\n",file_entry.aux_type);

			printf("\tLast mod Time: (%x) ",file_entry.last_mod);
			prodos_print_time(file_entry.last_mod);
			printf("\n");

			printf("\tHeader pointer: %x\n",file_entry.header_pointer);

			if (file_entry.storage_type==PRODOS_FILE_SUBDIR) {
				prodos_dump_subdir(voldir,file_entry.key_pointer);
			}

		}

		/* move to next */
		subdir_block=subdir_buffer[0x2]|(subdir_buffer[0x3]<<8);
		if (subdir_block==0) break;
		subdir_offset=0;

	}

	printf("\n");



	return 0;
}

int prodos_dump(struct voldir_t *voldir) {

	int catalog_block,catalog_offset,file;
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	unsigned char file_desc[PRODOS_FILE_DESC_LEN];
	int result;
	struct file_entry_t file_entry;

	dump_voldir(voldir);

	prodos_voldir_dump_bitmap(voldir);

	catalog_block=PRODOS_VOLDIR_KEY_BLOCK;
	catalog_offset=1;	/* skip the header */

	while(1) {

		result=prodos_read_block(voldir,catalog_buffer,catalog_block);
		if (result<0) fprintf(stderr,"Error on I/O\n");

		// dump_block(catalog_buffer);

		for(file=catalog_offset;
			file<voldir->entries_per_block;file++) {

			memcpy(file_desc,
				catalog_buffer+4+file*PRODOS_FILE_DESC_LEN,
				PRODOS_FILE_DESC_LEN);
			prodos_populate_filedesc(file_desc,&file_entry);

			if (file_entry.storage_type==PRODOS_FILE_DELETED) continue;

			printf("\n\n");
			printf("FILE %d: %s\n",file,file_entry.file_name);
			printf("\t($%X): ",file_entry.storage_type);
			prodos_print_storage_type(file_entry.storage_type);

			printf("\t");
			prodos_print_file_type(file_entry.file_type);

			printf("\tKey pointer: $%x\n",file_entry.key_pointer);

			printf("\tBlocks Used: %d\n",file_entry.blocks_used);

			printf("\tFile size (eof): %d\n",file_entry.eof);

			printf("\tCreation Time (%x): ",file_entry.creation_time);
			prodos_print_time(file_entry.creation_time);
			printf("\n");

			printf("\tVersion: %d\n",file_entry.version);

			printf("\tMin Version: %d\n",file_entry.min_version);

			printf("\tAccess (%x): ",file_entry.access);
			prodos_print_access(file_entry.access);
			printf("\n");

			printf("\tAux Type: %x\n",file_entry.aux_type);

			printf("\tLast mod Time: (%x) ",file_entry.last_mod);
			prodos_print_time(file_entry.last_mod);
			printf("\n");

			printf("\tHeader pointer: %x\n",file_entry.header_pointer);

			if (file_entry.storage_type==PRODOS_FILE_SUBDIR) {
				prodos_dump_subdir(voldir,file_entry.key_pointer);
			}

		}

		/* move to next */
		catalog_block=catalog_buffer[0x2]|(catalog_buffer[0x3]<<8);
		if (catalog_block==0) break;
		catalog_offset=0;
	}

	printf("\n");



	return 0;
}



int prodos_showfree(struct voldir_t *voldir) {
#if 0
	int num_tracks,catalog_t,catalog_s,file,ts_t,ts_s,ts_total;
	int track,sector;
	int i,j;
	int deleted=0;
	char temp_string[BUFSIZ];
	unsigned char tslist[PRODOS_BYTES_PER_BLOCK];
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	int result;

	int sectors_per_track;
	int catalog_used;
	int next_letter='a';
	struct file_key_type {
		int ch;
		char *filename;
	} file_key[100];
	int num_files=0;


	unsigned char usage[35][16];

	for(i=0;i<35;i++) for(j=0;j<16;j++) usage[i][j]=0;

	dump_voldir(voldir);

	catalog_t=voldir[VTOC_CATALOG_T];
	catalog_s=voldir[VTOC_CATALOG_S];
	ts_total=voldir[VTOC_MAX_TS_PAIRS];
	num_tracks=voldir[VTOC_NUM_TRACKS];
	sectors_per_track=voldir[VTOC_S_PER_TRACK];

	prodos_voldir_dump_bitmap(voldir);

	/* Reserve DOS */
	for(i=0;i<3;i++) for(j=0;j<16;j++) usage[i][j]='$';

	/* Reserve CATALOG (not all used?) */
	i=0x11;
	for(j=0;j<16;j++) usage[i][j]='#';


repeat_catalog:

	catalog_used=0;

//	printf("\nCatalog Sector $%02X/$%02x\n",catalog_t,catalog_s);
	lseek(fd,DISK_OFFSET(catalog_t,catalog_s),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);


//	dump_block();

	for(file=0;file<7;file++) {
//		printf("\n\n");

		ts_t=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_T))];
		ts_s=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_S))];

//		printf("%i+$%02X/$%02X - ",file,catalog_t,catalog_s);
		deleted=0;

		if (ts_t==0xff) {
			printf("**DELETED** ");
			deleted=1;
			ts_t=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME+0x1e))];
		}

		if (ts_t==0x00) {
//			printf("UNUSED!\n");
			goto continue_dump;
		}

		dos33_filename_to_ascii(temp_string,
			catalog_buffer+(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME)),
			30);

		for(i=0;i<strlen(temp_string);i++) {
			if (temp_string[i]<0x20) {
				printf("^%c",temp_string[i]+0x40);
			}
			else {
				printf("%c",temp_string[i]);
			}
		}
		printf("\n");
//		printf("\tLocked = %s\n",
//			sector_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]>0x7f?
//			"YES":"NO");
//		printf("\tType = %c\n",
//			dos33_file_type(sector_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]));
//		printf("\tSize in sectors = %i\n",
//			sector_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_L)]+
//			(sector_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_H)]<<8));

		if (!deleted) {
			catalog_used++;
			usage[catalog_t][catalog_s]='@';
		}

repeat_tsl:
//		printf("\tT/S List $%02X/$%02X:\n",ts_t,ts_s);
		if (deleted) goto continue_dump;

		usage[ts_t][ts_s]=next_letter;
		file_key[num_files].ch=next_letter;
		file_key[num_files].filename=strdup(temp_string);

		num_files++;


		lseek(fd,DISK_OFFSET(ts_t,ts_s),SEEK_SET);
		result=read(fd,&tslist,PRODOS_BYTES_PER_BLOCK);

		for(i=0;i<ts_total;i++) {
			track=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)];
			sector=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)+1];
			if ((track==0) && (sector==0)) {
				//printf(".");
			}
			else {
//				printf("\n\t\t%02X/%02X",track,sector);
				usage[track][sector]=toupper(next_letter);
			}
		}
		ts_t=tslist[TSL_NEXT_TRACK];
		ts_s=tslist[TSL_NEXT_SECTOR];

		if (!((ts_s==0) && (ts_t==0))) goto repeat_tsl;
continue_dump:;

		next_letter++;
	}

	catalog_t=catalog_buffer[CATALOG_NEXT_T];
	catalog_s=catalog_buffer[CATALOG_NEXT_S];

	if (catalog_s!=0) {
		file=0;
		goto repeat_catalog;
	}

	printf("\n");

	if (result<0) fprintf(stderr,"Error on I/O\n");

	printf("\nDetailed sector bitmap:\n\n");
	printf("\t                1111111111111111222\n");
	printf("\t0123456789ABCDEF0123456789ABCDEF012\n");

	for(j=0;j<sectors_per_track;j++) {
		printf("$%01X:\t",j);
		for(i=0;i<num_tracks;i++) {
			if (usage[i][j]==0) printf(".");
			else printf("%c",usage[i][j]);
		}
		printf("\n");

	}

	printf("Key: $=DOS, @=catalog used, #=catalog reserved, .=free\n\n");
	for(i=0;i<num_files;i++) {
		printf("\t%c %s\n",file_key[i].ch,file_key[i].filename);
	}
#endif
	return 0;
}

