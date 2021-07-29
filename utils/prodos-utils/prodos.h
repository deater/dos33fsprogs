    /* For now hard-coded */
    /* Could be made dynamic if we want to be useful */
    /* On dos3.2 disks, or larger filesystems */
#define TRACKS_PER_DISK 0x23
#define BLOCKS_PER_TRACK 0x8
#define PRODOS_BYTES_PER_BLOCK 0x200

#define PRODOS_INTERLEAVE_PRODOS	0x0
#define PRODOS_INTERLEAVE_DOS33		0x1


#define PRODOS_VOLDIR_KEY_BLOCK 0x02		// key block

#define PRODOS_FILE_DESC_LEN	0x27

#define PRODOS_FILE_DELETED	0x00
#define PRODOS_FILE_SEEDLING	0x01
#define PRODOS_FILE_SAPLING	0x02
#define PRODOS_FILE_TREE	0x03
#define PRODOS_FILE_SUBDIR	0x0d
#define PRODOS_FILE_SUBDIR_HDR	0x0e
#define PRODOS_FILE_VOLUME_HDR	0x0f

struct voldir_t {
	int fd;
	int interleave;
	unsigned char storage_type;
	unsigned char name_length;
	unsigned char version;
	unsigned char min_version;
	unsigned char access;
	unsigned char entry_length;
	unsigned char entries_per_block;
	unsigned short next_block;
	unsigned short file_count;
	unsigned short bit_map_pointer;
	unsigned short total_blocks;
	unsigned char volume_name[16];
	unsigned int creation_time;
};

struct file_entry_t {
	unsigned char storage_type;
	unsigned char name_length;
	unsigned char file_name[16];
	unsigned char file_type;
	unsigned short key_pointer;
	unsigned short blocks_used;
	int eof;
	int creation_time;
	unsigned char version;
	unsigned char min_version;
	unsigned char access;
	unsigned short aux_type;
	int last_mod;
	unsigned short header_pointer;
};

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
#define DISK_OFFSET(__track,__sector) ((((__track)*BLOCKS_PER_TRACK)+(__sector))*PRODOS_BYTES_PER_BLOCK)


#define DOS33_FILE_NORMAL 0
#define DOS33_FILE_DELETED 1

/* prodos_volume_bitmap.c */
int prodos_voldir_free_space(struct voldir_t *voldir);
int prodos_voldir_free_block(struct voldir_t *voldir, int block);
int prodos_voldir_reserve_block(struct voldir_t *voldir, int block);
void prodos_voldir_dump_bitmap(struct voldir_t *voldir);
int prodos_voldir_find_free_block(struct voldir_t *voldir,
	int *found_block);

/* prodos_catalog.c */
unsigned char prodos_char_to_type(char type, int lock);
void prodos_catalog(int dos_fd, struct voldir_t *voldir);
char *prodos_filename_to_ascii(char *dest,unsigned char *src,int len);
unsigned char prodos_file_type(int value);

/* prodos_dump.c */
int prodos_dump(struct voldir_t *voldir, int fd);
int prodos_showfree(struct voldir_t *voldir, int fd);

/* prodos_read.c */
int prodos_read_block(struct voldir_t *voldir,unsigned char *block, int blocknum);
