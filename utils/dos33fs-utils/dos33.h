    /* For now hard-coded */
    /* Could be made dynamic if we want to be useful */
    /* On dos3.2 disks, or larger filesystems */
#define TRACKS_PER_DISK 0x23
#define SECTORS_PER_TRACK 0x10
#define BYTES_PER_SECTOR 0x100

#define VTOC_TRACK  0x11
#define VTOC_SECTOR 0x00

    /* VTOC Values */
#define VTOC_CATALOG_T     0x1
#define VTOC_CATALOG_S     0x2
#define VTOC_DOS_RELEASE   0x3
#define VTOC_DISK_VOLUME   0x6
#define VTOC_MAX_TS_PAIRS 0x27
#define VTOC_LAST_ALLOC_T 0x30
#define VTOC_ALLOC_DIRECT 0x31
#define VTOC_NUM_TRACKS   0x34
#define VTOC_S_PER_TRACK  0x35
#define VTOC_BYTES_PER_SL 0x36
#define VTOC_BYTES_PER_SH 0x37
#define VTOC_FREE_BITMAPS 0x38

    /* CATALOG_VALUES */
#define CATALOG_NEXT_T     0x01
#define CATALOG_NEXT_S     0x02
#define CATALOG_FILE_LIST  0x0b

#define CATALOG_ENTRY_SIZE 0x23

    /* CATALOG ENTRY */
#define FILE_TS_LIST_T     0x0
#define FILE_TS_LIST_S     0x1
#define FILE_TYPE          0x2
#define FILE_NAME          0x3
#define FILE_SIZE_L        0x21
#define FILE_SIZE_H        0x22

#define FILE_NAME_SIZE     0x1e

    /* TSL */
#define TSL_NEXT_TRACK     0x1
#define TSL_NEXT_SECTOR    0x2
#define TSL_OFFSET_L       0x5
#define TSL_OFFSET_H       0x6
#define TSL_LIST           0xC

#define TSL_ENTRY_SIZE      0x2
#define TSL_MAX_NUMBER      122

    /* Helper Macros */
#define TS_TO_INT(__x,__y) ((((int)__x)<<8)+__y)
#define DISK_OFFSET(__track,__sector) ((((__track)*SECTORS_PER_TRACK)+(__sector))*BYTES_PER_SECTOR)


#define DOS33_FILE_NORMAL 0
#define DOS33_FILE_DELETED 1

/* dos33_vtoc_bitmap.c */
int dos33_vtoc_free_space(unsigned char *vtoc);
void dos33_vtoc_free_sector(unsigned char *vtoc, int track, int sector);
void dos33_vtoc_reserve_sector(unsigned char *vtoc, int track, int sector);
void dos33_vtoc_dump_bitmap(unsigned char *vtoc, int num_tracks);
int dos33_vtoc_find_free_sector(unsigned char *vtoc,
	int *found_track, int *found_sector);

/* dos33_catalog.c */
unsigned char dos33_char_to_type(char type, int lock);
void dos33_catalog(int dos_fd, unsigned char *vtoc);
char *dos33_filename_to_ascii(char *dest,unsigned char *src,int len);
unsigned char dos33_file_type(int value);

/* dos33_dump.c */
int dos33_dump(unsigned char *vtoc, int fd);
int dos33_showfree(unsigned char *vtoc, int fd);


extern int debug;
