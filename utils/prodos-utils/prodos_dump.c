#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>

#include "version.h"

#include "prodos.h"


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

static unsigned char month_names[12][4]={
	"Jan","Feb","Mar","Apr","May","Jun",
	"Jul","Aug","Sep","Oct","Nov","Dec",
};

static void prodos_print_time(int t) {
	int year,month,day,hour,minute;

	/* epoch seems to be 1900 */
	year=(t>>25)&0x7f;
	month=(t>>20)&0xf;
	day=(t>>16)&0x1f;
	hour=(t>>8)&0x1f;
	minute=t&0x3f;

	printf("%d:%02d %d %s %d",hour,minute,
		day+1,month_names[month],1900+year);

}

static void dump_voldir(struct voldir_t *voldir) {

	unsigned char volume_name[16];
	int storage_type,name_length;
	int creation_time;
	unsigned char voldir_buffer[PRODOS_BYTES_PER_BLOCK];

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
	printf("\tAccess: %d\n",voldir->access);
	printf("\tEntry Length: %d\n",voldir->entry_length);
	printf("\tEntries per block: %d\n",voldir->entries_per_block);
	printf("\tFile Count: %d\n",voldir->file_count);
	printf("\tBitmap Pointer: %d\n",voldir->bit_map_pointer);
	printf("\tTotal Blocks: %d\n",voldir->total_blocks);


}


int prodos_dump(struct voldir_t *voldir, int fd) {

	int num_tracks,catalog_t,catalog_s,file,ts_t,ts_s,ts_total;
	int track,sector;
	int i;
	int deleted=0;
	char temp_string[BUFSIZ];
	unsigned char tslist[PRODOS_BYTES_PER_BLOCK];
	unsigned char catalog_buffer[PRODOS_BYTES_PER_BLOCK];
	int result;

	dump_voldir(voldir);
#if 0
	catalog_t=voldir[VTOC_CATALOG_T];
	catalog_s=voldir[VTOC_CATALOG_S];
	ts_total=voldir[VTOC_MAX_TS_PAIRS];
	num_tracks=voldir[VTOC_NUM_TRACKS];

	dos33_vtoc_dump_bitmap(voldir,num_tracks);

repeat_catalog:

	printf("\nCatalog Sector $%02X/$%02x\n",catalog_t,catalog_s);
	lseek(fd,DISK_OFFSET(catalog_t,catalog_s),SEEK_SET);
	result=read(fd,catalog_buffer,PRODOS_BYTES_PER_BLOCK);

	printf("\tNext track/sector $%02X/$%02X (found at offsets $%02X/$%02X\n",
		catalog_buffer[CATALOG_NEXT_T],catalog_buffer[CATALOG_NEXT_S],
		CATALOG_NEXT_T,CATALOG_NEXT_S);

	dump_block(catalog_buffer);

	for(file=0;file<7;file++) {
		printf("\n\n");

		ts_t=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_T))];
		ts_s=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_TS_LIST_S))];

		printf("%i+$%02X/$%02X - ",file,catalog_t,catalog_s);
		deleted=0;

		if (ts_t==0xff) {
			printf("**DELETED** ");
			deleted=1;
			ts_t=catalog_buffer[(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME+0x1e))];
		}

		if (ts_t==0x00) {
			printf("UNUSED!\n");
			goto continue_dump;
		}

		dos33_filename_to_ascii(temp_string,
			catalog_buffer+(CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_NAME)),30);

		for(i=0;i<strlen(temp_string);i++) {
			if (temp_string[i]<0x20) {
				printf("^%c",temp_string[i]+0x40);
			}
			else {
				printf("%c",temp_string[i]);
			}
		}
		printf("\n");
		printf("\tLocked = %s\n",
			catalog_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]>0x7f?
			"YES":"NO");
		printf("\tType = %c\n",
			dos33_file_type(catalog_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE)+FILE_TYPE]));
		printf("\tSize in sectors = %i\n",
			catalog_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_L)]+
			(catalog_buffer[CATALOG_FILE_LIST+(file*CATALOG_ENTRY_SIZE+FILE_SIZE_H)]<<8));

repeat_tsl:
		printf("\tT/S List $%02X/$%02X:\n",ts_t,ts_s);
		if (deleted) goto continue_dump;
		lseek(fd,DISK_OFFSET(ts_t,ts_s),SEEK_SET);
		result=read(fd,&tslist,PRODOS_BYTES_PER_BLOCK);

		for(i=0;i<ts_total;i++) {
			track=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)];
			sector=tslist[TSL_LIST+(i*TSL_ENTRY_SIZE)+1];
			if ((track==0) && (sector==0)) printf(".");
			else printf("\n\t\t%02X/%02X",track,sector);
		}
		ts_t=tslist[TSL_NEXT_TRACK];
		ts_s=tslist[TSL_NEXT_SECTOR];

		if (!((ts_s==0) && (ts_t==0))) goto repeat_tsl;
continue_dump:;
	}

	catalog_t=catalog_buffer[CATALOG_NEXT_T];
	catalog_s=catalog_buffer[CATALOG_NEXT_S];

	if (catalog_s!=0) {
		file=0;
		goto repeat_catalog;
	}

	printf("\n");

	if (result<0) fprintf(stderr,"Error on I/O\n");
#endif
	return 0;
}

int prodos_showfree(struct voldir_t *voldir, int fd) {

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
#if 0
	catalog_t=voldir[VTOC_CATALOG_T];
	catalog_s=voldir[VTOC_CATALOG_S];
	ts_total=voldir[VTOC_MAX_TS_PAIRS];
	num_tracks=voldir[VTOC_NUM_TRACKS];
	sectors_per_track=voldir[VTOC_S_PER_TRACK];

	dos33_vtoc_dump_bitmap(voldir,num_tracks);

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

