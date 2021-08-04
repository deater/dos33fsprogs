    /* For now hard-coded */
    /* Could be made dynamic if we want to be useful */
    /* On dos3.2 disks, or larger filesystems */

#define PRODOS_BYTES_PER_BLOCK 0x200
#define PRODOS_VOLNAME_LEN	15
#define PRODOS_FILENAME_LEN	15

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

#define PRODOS_TYPE_TXT		0x04
#define PRODOS_TYPE_BIN		0x06
#define PRODOS_TYPE_BAS		0xFC
#define PRODOS_TYPE_VAR		0xFD
#define PRODOS_TYPE_SYS		0xFF

/* Normal access is $C3 */
/* Locked file is $01 */
/* Non-empty directories often locked? */
#define PRODOS_ACCESS_DESTROY	0x80	// can be deleted
#define PRODOS_ACCESS_RENAME	0x40
#define PRODOS_ACCESS_CHANGED	0x20	// has been changed since last backup
#define PRODOS_ACCESS_WRITE	0x02
#define PRODOS_ACCESS_READ	0x01

struct voldir_t {
	int fd;
	int interleave;
	int image_offset;
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

struct subdir_t {
	unsigned char storage_type;
	unsigned char name_length;
	unsigned char version;
	unsigned char min_version;
	unsigned char access;
	unsigned char entry_length;
	unsigned char entries_per_block;
	unsigned char parent_entry;
	unsigned char parent_entry_length;
	unsigned short file_count;
	unsigned short parent_pointer;
//	unsigned short next_block;
//	unsigned short bit_map_pointer;
//	unsigned short total_blocks;
	unsigned char subdir_name[16];
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

/* prodos_volume_bitmap.c */
int prodos_voldir_free_space(struct voldir_t *voldir);
int prodos_voldir_free_block(struct voldir_t *voldir, int block);
int prodos_voldir_reserve_block(struct voldir_t *voldir, int block);
void prodos_voldir_dump_bitmap(struct voldir_t *voldir);
int prodos_voldir_find_free_block(struct voldir_t *voldir);

/* prodos_catalog.c */
int prodos_find_next_file(int inode, struct voldir_t *voldir);
int prodos_populate_filedesc(unsigned char *file_desc,
                struct file_entry_t *file_entry);
//unsigned char prodos_char_to_type(char type, int lock);
void prodos_catalog(struct voldir_t *voldir, int dir_block);
//char *prodos_filename_to_ascii(char *dest,unsigned char *src,int len);
//unsigned char prodos_file_type(int value);

/* prodos_dump.c */
int prodos_dump(struct voldir_t *voldir);
int prodos_showfree(struct voldir_t *voldir);

/* prodos_read.c */
int prodos_read_block(struct voldir_t *voldir,unsigned char *block, int blocknum);
int prodos_write_block(struct voldir_t *voldir,unsigned char *block, int blocknum);

/* prodos_voldir.c */
int prodos_sync_voldir(struct voldir_t *voldir);
int prodos_change_volume_name(struct voldir_t *voldir, char *volname);
int prodos_init_voldir(int fd, struct voldir_t *voldir,
                                int interleave, int image_offset);
int prodos_read_voldir(struct voldir_t *voldir);

/* prodos_time.c */
int prodos_time(time_t t);
