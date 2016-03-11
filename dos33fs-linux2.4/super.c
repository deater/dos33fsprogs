/*****************************************************************************
 * super.c
 * Superblock operations and basic interface to the Linux VFS.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes =========================================================*/

#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/blkdev.h>

/*= DOS 3.3 Includes =======================================================*/

#include "dos33.h"

/*= Forward Declarations ====================================================*/

/* For the Linux module interface. */
int __init init_dos33_fs(void);
void __exit exit_dos33_fs(void);

/* For dos33_fs_type. */
struct super_block *dos33_read_super(struct super_block *,void *,int);

/* For dos33_super_operations. */
void dos33_put_super(struct super_block *);
void dos33_write_super(struct super_block *);
int dos33_statfs(struct super_block *,struct statfs *);

/*= VFS Interface Structures ================================================*/

/* Linux module operations. */
EXPORT_NO_SYMBOLS;
module_init(init_dos33_fs)
module_exit(exit_dos33_fs)

/* DOS 3.3 driver metainformation. */
DECLARE_FSTYPE_DEV(dos33_fs_type,"dos33",dos33_read_super);

/* DOS 3.3 superblock operations. */
struct super_operations dos33_super_operations = {
	read_inode: dos33_read_inode,
	write_inode: dos33_write_inode,
	put_inode: dos33_put_inode,
	put_super: dos33_put_super,
//	write_super: dos33_write_super,
	statfs: dos33_statfs
};

/* Number of one bits in a given 4-bit value. */
static int onebits[] = { 0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4 };

/*= Private Functions =======================================================*/

/*****************************************************************************
 * dos33_count_ones()
 * Counts the one (set) bits in a block of @data, @size bytes long. This is
 * basically the nifty algorithm that is also employed by (and was stolen
 * from) the minix fs driver.
 *****************************************************************************/
int dos33_count_ones(void *data,size_t size) {
	
    const u32 *bytes = (u32*)data;
    u32 ones = 0;
    u32 tmp = 0;
   
    DOS33_DEBUG("Count Ones\n");

       /* Count one bits, one nibble at a time. */
    for(size /= 4;size > 0;size--) {
       tmp = *bytes++;
       while (tmp) {
          ones += onebits[tmp & 0x0f];
	  tmp >>= 4;
       }
    }

       /* Return the number of ones found. */
    return ones;
}

/*****************************************************************************
 * dos33_find_first_one()
 * Return the position of the first one bit in a block of @data which is @size
 * bytes in length. Returns -1 if no one bits were found.
 *****************************************************************************/
int dos33_find_first_one(void *data,size_t size) {
//	const u32 *bytes = (u32*)data;
//	int pos = 0;
//	u32 tmp = 0;
   
           DOS33_DEBUG("find_first_one\n");
#if 0
	/* Search for a one bit; if found, return its position. */
	for (size /= 4;size > 0;size--,bytes++,pos += 32) {
		if (*bytes) {
			for (tmp = be32_to_cpu(*bytes);!(tmp & 0x80000000);tmp <<= 1,pos++);
			return pos;
		}
	}

	/* No one bits were found. */
#endif
	return -1;
}

/*****************************************************************************
 * prodos_mark_block()
 * Modify an entry in the volume bitmap. Note that the bitmap must be locked
 * before calling this function.
 *****************************************************************************/
void dos33_mark_block(struct super_block *sb,int block,int free) {
//	SHORTCUT struct prodos_sb_info *psb = PRODOS_SB(sb);
//	SHORTCUT struct buffer_head *bh = psb->s_bm_bh[block / 4096];
//	u32 * const data = ((u32*)bh->b_data) + block % 4096 / 32;
//	const int bit = cpu_to_be32(0x80000000 >> block % 4096 % 32);
        DOS33_DEBUG("mark_block\n");
#if 0
	/* Check whether we are to mark the block used or free. */
	if (free) {
		/* We should only be freeing used blocks. */
		if (*data & bit) {
			PRODOS_ERROR_1(sb,"block %i is already marked free",block);
			return;
		}

		/* Mark it free. */
		*data |= bit;
		if (psb->s_bm_free >= 0) psb->s_bm_free++;
	}
	else {
		/* We should only be allocating free blocks. */
		if (!(*data & bit)) {
			PRODOS_ERROR_1(sb,"block %i is already marked used",block);
			return;
		}

		/* Mark it clear. */
		*data &= ~bit;
		if (psb->s_bm_free >= 0) psb->s_bm_free--;
	}
#endif
	/* The bitmap block is now dirty. */
//	mark_buffer_dirty(bh);
}

/*****************************************************************************
 * prodos_parse_options()
 * Parse the mount options string and fill prodos_sb_info fields accordingly.
 *****************************************************************************/
int dos33_parse_options(struct super_block *sb,char *opts) {
//	SHORTCUT struct prodos_sb_info * const psb = PRODOS_SB(sb);
//	char *arg_key = NULL;
//	char *arg_value = NULL;
           DOS33_DEBUG("parse_options\n");
#if 0	
	/* Step through "key[=value]" options, modifying members of psb */
	if (!opts) return 1;
	for (arg_key = strtok(opts,",");arg_key;arg_key = strtok(NULL,",")) {
		if ((arg_value = strchr(arg_key,'='))) *arg_value++ = 0;
		if (!strcmp(arg_key,"verbose")) psb->s_flags |= PRODOS_FLAG_VERBOSE;
		else if (!strcmp(arg_key,"crconv")) psb->s_flags |= PRODOS_FLAG_CONVERT_CR;
		else if (!strcmp(arg_key,"case")) {
			if (arg_value) {
				if (!strcmp(arg_value,"lower"))
					psb->s_flags |= PRODOS_FLAG_LOWERCASE;
				else if (strcmp(arg_value,"asis")) goto out_invalid_value;
			}
			else goto out_omitted_value;
		}
		else if (!strcmp(arg_key,"forks")) {
			if (arg_value) {
				if (!strcmp(arg_value,"show"))
					psb->s_flags |= PRODOS_FLAG_SHOW_FORKS;
				else if (strcmp(arg_value,"hide")) goto out_invalid_value;
			}
			else goto out_omitted_value;
		}
		else if (!strcmp(arg_key,"partition") || !strcmp(arg_key,"part")) {
			if (arg_value) strncpy(psb->s_part,arg_value,32);
			else goto out_omitted_value;
		}
		else goto out_invalid_key;
	}

	/* Success. */
	return ~0;

out_omitted_value:
	PRODOS_ERROR_1(sb,"option \"%s\" requires a value",arg_key);
	goto out_error;
out_invalid_value:
	PRODOS_ERROR_2(sb,"option \"%s\" given unrecognized value \"%s\"",arg_key,arg_value);
	goto out_error;
out_invalid_key:
	PRODOS_ERROR_1(sb,"unrecognized option \"%s\"",arg_key);
	goto out_error;

out_error:
#endif
	return 0;
}

/*= Exported Functions ======================================================*/

/*****************************************************************************
 * dos33_count_free_blocks()
 * Count free blocks on the volume by counting the one bits in the volume
 * bitmap.
 *****************************************************************************/
int dos33_count_free_blocks(struct super_block *sb) {
	
    SHORTCUT struct dos33_sb_info * const psb = DOS33_SB(sb);
   
    DOS33_DEBUG("Count_free_blocks\n");

       /* Grab the bitmap lock. */
    down(&psb->s_bm_lock);

       /* Count free blocks if they have not already been counted. */
    if (psb->s_bm_free < 0) {
       psb->s_bm_free = 0;
       psb->s_bm_free += (dos33_count_ones(&(psb->bitmaps[0]),0x23))/2;
    }

       /* Release the bitmap lock and return free block count. */
    up(&psb->s_bm_lock);
    return psb->s_bm_free;
}

/*****************************************************************************
 * prodos_alloc_block()
 * Find the first free block on the volume, mark it used, and return its
 * index.
 *****************************************************************************/
int dos33_alloc_block(struct super_block *sb) {
//	SHORTCUT struct prodos_sb_info * const psb = PRODOS_SB(sb);
	int result = -ENOSPC;
//	int pos = -1;
//	int i = 0;
           DOS33_DEBUG("alloc_block\n");
#if 0
	/* Grab the bitmap lock. */
	down(&psb->s_bm_lock);

	/* Fail early if we already know that all blocks are full. */
	if (!psb->s_bm_free) goto out_cleanup;

	/* Find first one bit in the bitmap, which signifies a free block. */
	for (i = 0;psb->s_bm_bh[i];i++) {
		pos = prodos_find_first_one(psb->s_bm_bh[i]->b_data,PRODOS_BLOCK_SIZE);
		if (pos != -1) {
			pos += (i * 4096);
			break;
		}
	}

	/* XXX: should probably cache first free block index. */
	/* If a bit was found, clear it. */
	if (pos >= 0 && pos < psb->s_part_size) {
		prodos_mark_block(sb,pos,0);
		result = pos;
	}

out_cleanup:
	up(&psb->s_bm_lock);
#endif   
	return result;
}

/*****************************************************************************
 * prodos_free_block()
 * Mark a block as free by setting its bit in the volume bitmap.
 *****************************************************************************/
int dos33_free_block(struct super_block *sb,u16 block) {
           DOS33_DEBUG("free_blocks\n");
#if 0
	/* Grab the bitmap lock. */
	down(&PRODOS_SB(sb)->s_bm_lock);

	/* Set the bit. */
	prodos_mark_block(sb,block,1);

	/* Release the lock and return. */
	up(&PRODOS_SB(sb)->s_bm_lock);
#endif
	return 0;
}

/*****************************************************************************
 * prodos_free_tree_blocks()
 * Mark all blocks in a tree (file or fork; seedling, sapling, or full tree)
 * as free.
 *****************************************************************************/
int prodos_free_tree_blocks(struct super_block *sb,u8 stype,u16 key_block,u16 blocks_used) {
	int result = 0;
//	struct buffer_head *dind_bh = NULL;
//	u16 ind_block = 0;
//	struct buffer_head *ind_bh = NULL;
           DOS33_DEBUG("free_tree_blocks\n");
#if 0
	/* Grab the bitmap lock. */
	down(&PRODOS_SB(sb)->s_bm_lock);

	/* Free blocks in sapling and tree files. */
	if (stype != PRODOS_STYPE_SEEDLING) {
		int i = 0;
		u16 block = 0;

		/* Load the double indirect block for tree files. */
		if (stype == PRODOS_STYPE_TREE) {
			dind_bh = prodos_bread(sb,key_block);
			if (!dind_bh) {
				result = -EIO;
				goto out_cleanup;
			}

			/* Allow for double indirect to be freed outside the loop. */
			blocks_used--;
		}

		/* Release all data blocks and indirect blocks. */
		while (blocks_used) {
			/* Get next indirect block when necessary. */
			if (!(i % 256)) {
				ind_block = dind_bh ?
				 PRODOS_GET_INDIRECT_ENTRY(dind_bh->b_data,i / 256) :
				 key_block;
				ind_bh = prodos_bread(sb,ind_block);
				if (!ind_bh) {
					result = -EIO;
					goto out_cleanup;
				}
			}

			/* Free next data block (if it isn't sparse.) */
			block = PRODOS_GET_INDIRECT_ENTRY(ind_bh->b_data,i % 256);
			if (block) {
				prodos_mark_block(sb,block,1);
				blocks_used--;
			}

			/* Free indirect block when necessary. */
			if (!(++i % 256) || (blocks_used == 1)) {
				prodos_brelse(ind_bh);
				ind_bh = NULL;
				prodos_mark_block(sb,ind_block,1);
				blocks_used--;
			}
		}

		/* Free the double indirect block for tree files. */
		if (stype == PRODOS_STYPE_TREE) {
			prodos_brelse(dind_bh);
			dind_bh = NULL;
			prodos_mark_block(sb,key_block,1);
		}
	}

	/* Free blocks in seedling files. */
	else prodos_mark_block(sb,key_block,1);

out_cleanup:
	if (ind_bh) prodos_brelse(ind_bh);
	if (dind_bh) prodos_brelse(dind_bh);
	up(&PRODOS_SB(sb)->s_bm_lock);
#endif
	return result;
}

/*= Interface Functions =====================================================*/

/*****************************************************************************
 * dos33_read_super()
 *****************************************************************************/
struct super_block *dos33_read_super(struct super_block *sb,void *opts,int silent) {
	
    SHORTCUT kdev_t const dev = sb->s_dev;
    struct dos33_sb_info *psb = NULL;
    struct buffer_head *bh = NULL;
    struct dos33_vtol *pdbf = NULL;
    struct inode *root_inode = NULL;
    u16 i = 0;
   
    DOS33_DEBUG("read_super\n");

       /* Initialize the device and the super_block struct. */
    set_blocksize(dev,DOS33_BLOCK_SIZE);
    sb->s_magic = DOS33_SUPER_MAGIC;
    sb->s_op = &dos33_super_operations;
    sb->s_blocksize = DOS33_BLOCK_SIZE;
    sb->s_blocksize_bits = DOS33_BLOCK_SIZE_BITS;
    sb->s_maxbytes = DOS33_MAX_FILE_SIZE;
    sb->s_flags = MS_RDONLY | MS_NOSUID;

       /* Allocate the DOS 3.3 superblock metainformation struct. */
    psb = kmalloc(sizeof(struct dos33_sb_info),GFP_KERNEL);
    if (!psb) {
       DOS33_ERROR("failed to allocate memory for prodos_sb_info");
       goto out_error;
    }
    DOS33_SB(sb) = psb;

       /* Fill the superblock metainformation struct with default values. */
    memset(DOS33_SB(sb),0,sizeof(struct dos33_sb_info));
    psb->s_part_size = blk_size[MAJOR(dev)] ? blk_size[MAJOR(dev)][MINOR(dev)] * 2 : 0;
    init_MUTEX(&psb->s_bm_lock);
    init_MUTEX(&psb->s_dir_lock);

       /* Parse mount options and, if necessary, find desired partition. */
//	if (!prodos_parse_options(sb,(char*)opts)) goto out_error;

       /* Load DOS 3.3 volume directory block. */
    bh = dos33_bread(sb,DOS33_VOLUME_DIR_BLOCK);
    if (!bh) {
       DOS33_ERROR("failed to read volume directory block");
       goto out_error;
    }
    pdbf = (struct dos33_vtol*)bh->b_data;

	/* Check for DOS 3.3 footprint in the block. */
        /* this is a possibly-bogus check, replace   */
/*    if (pdbf->four != 0x4) {
       DOS33_ERROR("failed to find a DOS 3.3 filesystem");
       goto out_error;
    }
*/
       /* Use size from the volume directory as partition size. */
    psb->s_part_size = ((pdbf->tracks_per_disk*pdbf->sectors_per_track*le16_to_cpu(pdbf->bytes_per_sector))/512);
   
       /* Initialize the volume bitmap stuff. */
    psb->s_bm_free = -1;
   
    for(i=0;i<pdbf->tracks_per_disk;i++) {
       psb->bitmaps[i]=cpu_to_le32(pdbf->bitmaps[i]);  
    }
       
    printk("dos33.o: found %ik DOS 3.%i filesystem, Volume %i\n",
	   psb->s_part_size/2,pdbf->dos_version,pdbf->volume);

       /* Get root inode. */
    root_inode = iget(sb,DOS33_MAKE_INO(1,0,DOS33_VOLUME_DIR_TRACK,0xf));
    sb->s_root = d_alloc_root(root_inode);
    if (!sb->s_root) {
       DOS33_ERROR("failed to get root inode");
       goto out_error;
    }
    sb->s_root->d_op = &dos33_dentry_operations;

       /* Return a copy of the 'sb' pointer on success. */
    return sb;

out_error:
    if (sb->s_root) {
       iput(root_inode);
       root_inode = NULL;
    }
    if (bh) {
       dos33_brelse(bh);
       bh = NULL;
    }
    if (psb) {
       kfree(DOS33_SB(sb));
       DOS33_SB(sb) = NULL;
    }

    return NULL;
}

/*****************************************************************************
 * prodos_put_super()
 *****************************************************************************/
void dos33_put_super(struct super_block *sb) {
	SHORTCUT struct dos33_sb_info * const psb = DOS33_SB(sb);
//	int i = 0;
           
        DOS33_DEBUG("put_super\n");
   
#if 0	/* Release volume bitmap blocks. */
	for (i = 0;psb->s_bm_bh[i];i++) {
		prodos_brelse(psb->s_bm_bh[i]);
		psb->s_bm_bh[i] = NULL;
	}
#endif
	/* Release the ProDOS super block metainformation structure. */
	kfree(psb);

}

/*****************************************************************************
 * prodos_write_super()
 *****************************************************************************
void prodos_write_super(struct super_block *sb) {

}*/

/*****************************************************************************
 * prodos_statfs()
 *****************************************************************************/
int dos33_statfs(struct super_block *sb,struct statfs *statfs) {
	SHORTCUT struct dos33_sb_info * const psb = DOS33_SB(sb);
        DOS33_DEBUG("statfs\n");

	/* Copy applicable information. */
	statfs->f_type = DOS33_SUPER_MAGIC;
	statfs->f_bsize = sb->s_blocksize;
	statfs->f_blocks = psb->s_part_size;
	statfs->f_bfree = dos33_count_free_blocks(sb);
	statfs->f_bavail = statfs->f_bfree;

	return 0;
}

/*= Module Functions ========================================================*/

/*****************************************************************************
 * init_dos33_filesystem()
 *****************************************************************************/
int __init init_dos33_fs(void) {
	/* Since we are overlaying our prodos_inode_info structure over a
	 minix_inode_info structure, we should verify that the former is no larger
	 than the latter. */
   
        DOS33_DEBUG("Insmodding\n");
   
	if (sizeof(struct dos33_inode_info) > sizeof(struct minix_inode_info)) {
                DOS33_ERROR("aborting; struct prodos_inode_info too big!");
		return -EFAULT;
	}

	/* Register the filesystem. */
	return register_filesystem(&dos33_fs_type);
}

/*****************************************************************************
 * exit_dos33_filesystem()
 *****************************************************************************/
void __exit exit_dos33_fs(void) {
	/* Unregister the filesystem. */
   
        DOS33_DEBUG("Rmmodding\n");
	unregister_filesystem(&dos33_fs_type);
}
