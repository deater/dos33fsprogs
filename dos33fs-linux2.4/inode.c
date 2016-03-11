/*****************************************************************************
 * inode.c
 * Inode operations.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes =========================================================*/

#include <linux/blkdev.h>

/*= DOS 3.3 Includes ========================================================*/

#include "dos33.h"

/*****************************************************************************
 * dos33_read_inode()
 *****************************************************************************/
void dos33_read_inode(struct inode *inode) {
   
    SHORTCUT struct dos33_inode_info * const pi = DOS33_I(inode);
    SHORTCUT struct super_block * const sb = inode->i_sb;
    SHORTCUT const int dblk = (DOS33_INO_TRACK(inode->i_ino)*0x10)+
                               DOS33_INO_SECTOR(inode->i_ino);
    int dent=DOS33_INO_ENTRY(inode->i_ino);
    struct buffer_head *bh = NULL;
    struct dos33_catalog_sector *dir = NULL;   
    
    DOS33_DEBUG("read_inodes: inode 0x%08x\n",(int)inode->i_ino);

	/* Initialize the inode structure. */
    memset(pi,0,sizeof(struct dos33_inode_info));

    DOS33_DEBUG("DBLK %x ENTRY %x\n",dblk,dent);
   
	/* Read the directory block containing this entry. */
    bh = dos33_bread(sb,dblk);
    if (!bh) {
       DOS33_ERROR("dos33_bread() failed");
       make_bad_inode(inode);
       goto out_cleanup;
    }
          /* Get a pointer to the directory block. */
    if (dblk%2) {
       dir = (struct dos33_catalog_sector*) (bh->b_data+256);
    }
    else {
       dir = (struct dos33_catalog_sector*)bh->b_data;
    }
	  
	/* Read a directory inode. */
    if (DOS33_INO_DENT(inode->i_ino)) {
	   
       DOS33_DEBUG("DIRECTORY\n");

	  /* Initialize items that are common to all directories. */
       pi->i_key = inode->i_ino;
       inode->i_op = &dos33_dir_inode_operations;
       inode->i_fop = &dos33_dir_operations;
       inode->i_mode = S_IFDIR;

       inode->i_mtime = inode->i_atime = inode->i_ctime =0;

	  /* Convert the access flags. */
       inode->i_mode |=0777;
       inode->i_blocks = 1;

	  /* Calculate the "size" of the directory. */
       inode->i_size = inode->i_blocks << DOS33_BLOCK_SIZE_BITS;
    }

	/* Read a file inode. */
    else {
	   
       struct dos33_file_t *file_entry = NULL;
	  
       file_entry=&dir->files[dent];
       
       DOS33_DEBUG("FILE inode %x\n",(int)inode->i_ino);
	   
          /* Set up stuff that is specific to files. */
       pi->i_filetype = file_entry->file_type;
       inode->i_op = &dos33_file_inode_operations;
       inode->i_fop = &dos33_file_operations;
       inode->i_mapping->a_ops = &dos33_address_space_operations;
       if (file_entry->file_type &0x80){
	  inode->i_mode=(S_IFREG|S_IRUGO|S_IXUGO);
       }
       else {
	  inode->i_mode=(S_IFREG|S_IRWXUGO);
	  
       }
//       inode->i_mode = S_IFREG;  | prodos_get_mode(ent->access,0);
       /* My birthdate */
       /* a bit anachronistic, 2 years 6 months before the Disk ][ was available */
       inode->i_mtime = 256246800;
       inode->i_atime = inode->i_ctime = 256246800;
       
       inode->i_size = le16_to_cpu(file_entry->num_sectors)*256;
       inode->i_blocks = le16_to_cpu(file_entry->num_sectors)/2;
    }

	/* Set up stuff that is common to every type of inode. */
    inode->i_nlink = 1;
    inode->i_uid = 0; /* root uid (just for now.) */
    inode->i_gid = 0; /* root gid (just for now.) */

out_cleanup:
	/* Release the directory block. */
	dos33_brelse(bh);
	bh = NULL;

}

/*****************************************************************************
 * prodos_write_inode()
 * Write an @inode's metainformation back to disk.
 *****************************************************************************/
void dos33_write_inode(struct inode *inode,int unused) {
           DOS33_DEBUG("write inodes\n");
   
#if 0
	SHORTCUT struct prodos_inode_info * const pi = PRODOS_I(inode);
	struct buffer_head *dir_bh = NULL;
	struct prodos_dir_entry *ent = NULL;
	u32 eof = cpu_to_le32((u32)inode->i_size);

	PRODOS_INFO_1(inode->i_sb,"called for inode 0x%08x",(int)inode->i_ino);

	/* XXX: we'll eventually want to modify privileges and time stamps. */

	/* Do nothing if the inode is not linked (free.) */
	if (!inode->i_nlink) return;

	/* Load the directory block and get pointer to this entry. */
	dir_bh = prodos_bread(inode->i_sb,PRODOS_INO_DBLK(inode->i_ino));
	if (!dir_bh) {
		PRODOS_ERROR_0(inode->i_sb,"failed to read directory block");
		goto out_cleanup;
	}

	/* Write a directory inode. */
	if (PRODOS_INO_DENT(inode->i_ino) == PRODOS_DENT_DIR) {
		struct prodos_dir_block_first *dir = (void*)dir_bh->b_data;
		struct buffer_head *parent_bh = NULL;

		/* Load and update the parent directory entry. */
		parent_bh = prodos_bread(inode->i_sb,le16_to_cpu(dir->u.dir_header.parent_block));
		if (!parent_bh) {
			PRODOS_ERROR_0(inode->i_sb,"failed to read parent directory block");
			goto out_cleanup;
		}
		ent = &((struct prodos_dir_block*)parent_bh->b_data)->entries[dir->u.dir_header.parent_entry - 1];
		memcpy(&ent->eof,&eof,3);
		ent->blocks_used = cpu_to_le16(inode->i_blocks);
		mark_buffer_dirty(parent_bh);
		prodos_brelse(parent_bh);
	}

	/* Write a file inode. */
	else {
		/* Update the directory entry. */		
		ent = &((struct prodos_dir_block*)dir_bh->b_data)->entries[PRODOS_INO_DENT(inode->i_ino)];
		memcpy(&ent->eof,&eof,3);
		ent->key_block = cpu_to_le16(pi->i_key);
		ent->blocks_used = cpu_to_le16(inode->i_blocks);
		ent->name[0] = (ent->name[0] & 0x0f) | pi->i_stype;
		mark_buffer_dirty(dir_bh);
	}

out_cleanup:
	if (dir_bh) prodos_brelse(dir_bh);

#endif
}

/*****************************************************************************
 * dos33_put_inode()
 *****************************************************************************/
void dos33_put_inode(struct inode *inode) {
           DOS33_DEBUG("put inodes\n");

	DOS33_DEBUG("called on ino 0x%08x",(int)inode->i_ino);

}

