/*****************************************************************************
 * dos33.h
 * Includes, definitions, and helpers pertaining to the Linux driver
 * implementation.
 *
 * Apple II Apple DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * based on code Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/
#ifndef __DOS33_DOS33_H
#define __DOS33_DOS33_H

/*= ProDOS Includes =========================================================*/

#include "dos33_fs.h"

/*= Code Readability Tags ===================================================*/

/* SHORTCUT identifies shortcuts to buried struct members, etc. */
#define SHORTCUT /* */


/* Simplify access to custom superblock info. */
#define DOS33_SB(s)   ((struct dos33_sb_info *)((s)->u.generic_sbp))
#define DOS33_I(i)    ((struct dos33_inode_info *)&(i)->u.minix_i)

#define DOS33_INO_DENT(ino)          ((ino)>>31)
#define DOS33_INO_ENTRY(ino)         (((ino)>>16)&0xff)
#define DOS33_INO_TRACK(ino)         (((ino)>>8)&0xff)
#define DOS33_INO_SECTOR(ino)        ((ino)&0xff)
#define DOS33_MAKE_INO(__d,__n,__t,__s)     ( ((__d)<<31) | (((__n)&0xff)<<16) |  (((__t)&0xff)<<8) | (__s &0xff))

/*= Structure Definitions ===================================================*/

/* super_block information specific to ProDOS filesystems. */
struct dos33_sb_info {
	u32 s_flags;

	/* Items relating to partition location. */
	u32 s_part_start;
	u32 s_part_size;
	u8 s_part[32];

	/* Items relating to the volume bitmap. */
	struct semaphore s_bm_lock;
	u32 bitmaps[0x64]; /* one extra to act as NULL terminator */
	u16 s_bm_start;
	int s_bm_free;

	/* Items relating to miscellaneous locking and serialization. */
	struct semaphore s_dir_lock;
};

/* inode information specific to ProDOS "inodes." Note that this structure is
 never actually instantiated. It is simply overlaid upon inode.u.minix_i to
 avoid the need to modify fs.h in the standard Linux source. Obviously, this
 limits the prodos_inode_info structure to a size <= the size of
 struct minix_inode_info. */
struct dos33_inode_info {
	u8 i_flags;
	u8 i_filetype;
	u8 i_stype;
	u16 i_key;
	u16 i_auxtype;
	u8 i_access;
};

struct dos33_track_sector {
   u8 track;
   u8 sector;
} __attribute__((packed));

struct dos33_vtol {
   u8 four;
   struct dos33_track_sector catalog;
   u8 dos_version;
   u8 unused1[2];
   u8 volume;
   u8 unused2[0x20];
   u8 ts_pairs;
   u8 unused3[8];
   u8 last_track;
   u8 allocation_direction;
   u8 unused4[2];
   u8 tracks_per_disk;
   u8 sectors_per_track;
   u16 bytes_per_sector;
   u32 bitmaps[0x23];
   u8 unused5[0x3b];
} __attribute__((packed));

struct dos33_file_t {
   struct dos33_track_sector first_tsl;
   u8 file_type;
   u8 file_name[0x1e];  /* high bit set, padded with spaces */
   u16 num_sectors;
} __attribute__((packed));

struct dos33_catalog_sector {
   u8 unused1;
   struct dos33_track_sector next;
   u8 unused[8];
   struct dos33_file_t files[7]; 
} __attribute__((packed));

struct dos33_ts_list {
   u8 unused1;
   struct dos33_track_sector next;
   u8 unused2[2];
   u16 current_sectors_deep;
   u8 unused3[5];
   struct dos33_track_sector data_location[122];
} __attribute__((packed));


/*= Externals ===============================================================*/

/* dir.c */
extern struct inode_operations dos33_dir_inode_operations;
extern struct file_operations dos33_dir_operations;

/* file.c */
extern struct inode_operations dos33_file_inode_operations;
extern struct file_operations dos33_file_operations;
extern struct address_space_operations dos33_address_space_operations;

/* dentry.c */
extern struct dentry_operations dos33_dentry_operations;

/* inode.c */
extern void dos33_read_inode(struct inode *);
extern void dos33_write_inode(struct inode *,int);
extern void dos33_put_inode(struct inode *);

/* super.c */
extern int dos33_count_free_blocks(struct super_block *sb);
extern int dos33_alloc_block(struct super_block *sb);
extern int dos33_free_block(struct super_block *sb,u16 block);
extern int dos33_free_tree_blocks(struct super_block *sb,u8,u16,u16);

/* misc.c */
extern int dos33_convert_filename(char *filename);
extern int dos33_check_name(struct qstr *);
extern struct buffer_head *dos33_bread(struct super_block *,int);
extern void dos33_brelse(struct buffer_head *);

#endif
