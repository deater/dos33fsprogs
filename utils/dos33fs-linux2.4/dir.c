/*****************************************************************************
 * dir.c
 * File and inode operations for directories.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes =========================================================*/

#include <linux/blkdev.h>

/*= DOS 3.3 Includes =======================================================*/

#include "dos33.h"

/*= Forward Declarations ===================================================*/

/* For dos33_dir_inode_operations. */
struct dentry *dos33_lookup(struct inode *,struct dentry *);
int dos33_create(struct inode *,struct dentry *,int);
int dos33_unlink(struct inode *,struct dentry *);
int dos33_rename(struct inode *,struct dentry *,struct inode *,struct dentry *);

/* For dos33_dir_operations. */
int dos33_readdir(struct file *,void *,filldir_t);

/*= VFS Interface Structures ================================================*/

struct inode_operations dos33_dir_inode_operations = {
	lookup: dos33_lookup,
	create: dos33_create,
	unlink: dos33_unlink,
	rename: dos33_rename
};

struct file_operations dos33_dir_operations = {
	read: generic_read_dir,
	readdir: dos33_readdir
/*	fsync: file_fsync */
};


/*****************************************************************************
 * dos33_new_dir_block()
 * Allocate and initialize a new directory block.
 *****************************************************************************/
int dos33_expand_dir(struct super_block *sb,u16 block) {
	int result = 0;
//	u16 new_block = 0;
//	struct buffer_head *dir_bh = NULL;
//	struct dos33_dir_block *dir = NULL;
   
        DOS33_DEBUG("expand_dir\n");
   
#if 0	
	/* Try to allocate a new block. */
	new_block = prodos_alloc_block(sb);
	if (!new_block) {
		result = -ENOSPC;
		goto out_cleanup;
	}

	/* Read the block. */
	dir_bh = prodos_bread(sb,new_block);
	if (!dir_bh) {
		result = -EIO;
		goto out_cleanup;
	}
	dir = (void*)dir_bh->b_data;

	/* Initialize the block. */
	memset(dir,0,PRODOS_BLOCK_SIZE);
	dir->header.prev = cpu_to_le16(block);
	dir->header.next = 0;
	mark_buffer_dirty(dir_bh);
	result = new_block;

out_cleanup:
	if (dir_bh) prodos_brelse(dir_bh);
#endif   
	return result;
}

/*****************************************************************************
 * dos33_find_entry()
 * Search directory @inode for an entry. If @name is non-NULL, the directory
 * is searched for an entry with matching name; if @name is NULL, the
 * directory is searched (and possibly expanded) for an unused entry.  Zero is
 * returned on failure; the found entry's inode number is returned on success.
 *****************************************************************************/
unsigned long dos33_find_entry(struct inode *inode,struct qstr *name) {
   
    unsigned long result = 0;
    u32 catalog_block = (DOS33_INO_TRACK(inode->i_ino)<<4)+
                        DOS33_INO_SECTOR(inode->i_ino);
    u32 odd=0,entry_num=0;
    struct buffer_head *bh = NULL;
    struct dos33_catalog_sector *catalog = NULL;
   
    DOS33_DEBUG("find entry: %i %x\n",(int)inode->i_ino,(int)catalog_block);
   
       /* Scan the directory for a matching entry. */
    while (catalog_block) {
	      
	  /* Load next directory block when necessary. */
       if (!bh) {
	  odd=catalog_block%2;
	     /* Load the block. */
	  DOS33_DEBUG("==Loading block %x\n",catalog_block);
	  bh = dos33_bread(inode->i_sb,catalog_block);
	  if (!bh) {
	     DOS33_DEBUG("dos33_bread() failed for block %d\n",catalog_block);
	     goto out_cleanup;
	  }
             /* deal with 256byte sector size */      
	  if (odd) {
	     catalog = (struct dos33_catalog_sector*)(bh->b_data+256);
	  }
	  else {
	     catalog = (struct dos33_catalog_sector*)(bh->b_data);
	  }
       }
          /* Searching for an empty entry.  FIX ME */
       if (!name) {
	  DOS33_DEBUG("== no name dir.c FIXME\n");
	  // result = DOS33_MAKE_INO(0,(cur_block>>4)&0xffff,cur_block&0xf);
	  goto out_cleanup;
       }
       else {
	  int qlen=name->len;
	  int mismatch=0;
	  int i;
	  struct dos33_file_t *file_ent=&catalog->files[entry_num];
	
	     /* Do the names match? */
	  for(i=0;i<qlen;i++) {
	     if ( name->name[i] != ((file_ent->file_name[i])&0x7f)) mismatch++;
	  }
	     /* If they match, return the inode */	   
	  if (!mismatch) {
	     DOS33_DEBUG("==MATCH %s\n",name->name);
	     result = DOS33_MAKE_INO(0,entry_num,
				     (catalog_block>>4)&0x7f,
				     (catalog_block)&0xf);
	     goto out_cleanup;
	  }
       }
		

	  /* Advance to next entry. */
          /* For now only handle first 7 files */
       if (++entry_num >= 7) {
	  DOS33_DEBUG("ENDDDDDDDDDDDING\n");
	  entry_num=0;
	   
	  catalog_block = ((catalog->next.track)<<4)+catalog->next.sector;
          DOS33_DEBUG("== next block %x\n",catalog_block);
		   
	     /* Release previous block. */
	  dos33_brelse(bh);
	  bh = NULL;
       }
    }

out_cleanup:
    if (bh) {
       dos33_brelse(bh);
       bh = NULL;
    }
    return result;
}

/*****************************************************************************
 * prodos_unlink_all()
 * Unlink (delete) all forks of the ProDOS file represented by an @inode.
 *****************************************************************************/
#if 0
int dos33_unlink_all(struct inode *inode,struct dos33_dir_entry *ent) {
	int result = 0;
	const u16 dblk = PRODOS_INO_DBLK(inode->i_ino);
	const u8 dent = PRODOS_INO_DENT(inode->i_ino);
	u8 dfrk = PRODOS_INO_DFORK(inode->i_ino);
	struct buffer_head *ext_bh = NULL;

	/* We may have to delete TWO forks. */
	if (PRODOS_ISEXTENDED(*ent)) {
		struct prodos_ext_key_block *ext_block = NULL;

		/* Load the extended directory block. */
		ext_bh = prodos_bread(inode->i_sb,PRODOS_I(inode)->i_key);
		if (!ext_bh) {
			result = -EIO;
			goto out_cleanup;
		}
		ext_block = (void*)ext_bh->b_data;

		/* Free the resource fork. */
		prodos_free_tree_blocks(inode->i_sb,ext_block->res.stype << 4,
		 le16_to_cpu(ext_block->res.key_block),
		 le16_to_cpu(ext_block->res.blocks_used));

		/* Free the data fork. */
		prodos_free_tree_blocks(inode->i_sb,ext_block->data.stype << 4,
		 le16_to_cpu(ext_block->data.key_block),
		 le16_to_cpu(ext_block->data.blocks_used));

		/* Release the extended directory block. */
		prodos_brelse(ext_bh);
		ext_bh = NULL;

		/* Free the extended directory block. */
		prodos_free_block(inode->i_sb,PRODOS_I(inode)->i_key);
	}

	/* ...or we may only have to delete one fork. */
	else {
		prodos_free_tree_blocks(inode->i_sb,PRODOS_I(inode)->i_stype,
		 le16_to_cpu(ent->key_block),
		 le16_to_cpu(ent->blocks_used));
	}

	/* Update this inode. */
	inode->i_nlink--;
	mark_inode_dirty(inode);

	/* Unlink the resource fork inode. */
	if (PRODOS_I(inode)->i_stype == PRODOS_STYPE_EXTENDED) {
		inode = iget(inode->i_sb,PRODOS_MAKE_INO(dblk,dent,PRODOS_DFORK_RES));
		if (inode) {
			down(&inode->i_sem);
			inode->i_nlink--;
			mark_inode_dirty(inode);
			up(&inode->i_sem);
			iput(inode);
		}
	}

	/* We may have been called on either a data fork inode OR a meta file
	 inode.  Unlink the one upon which we were NOT called (the one we were
	 called on has, obviously, already been unlinked.) */
	dfrk = dfrk == PRODOS_DFORK_META ? PRODOS_DFORK_DATA : PRODOS_DFORK_META;
	inode = iget(inode->i_sb,PRODOS_MAKE_INO(dblk,dent,dfrk));
	if (inode) {
		down(&inode->i_sem);
		inode->i_nlink--;
		mark_inode_dirty(inode);
		up(&inode->i_sem);
		iput(inode);
	}

	/* Mark the directory entry as deleted. */
	ent->name[0] &= 0x0f;
	result = 1;

out_cleanup:
	if (ext_bh) prodos_brelse(ext_bh);

	return result;
}
#endif
/*****************************************************************************
 * prodos_unlink_res()
 * Unlink (delete) the resource fork of the ProDOS file represented by an
 * @inode.  This is the most involved of the unlink operations.  The resource
 * fork is deleted and its blocks freed, then the file is collapsed into a
 * a regular (non-extended) file by copying the data fork metainformation from
 * the extended directory block into the base directory entry itself.
 *****************************************************************************/
#if 0
int dos33_unlink_res(struct inode *inode,struct prodos_dir_entry *ent) {
	int result = 0;
	struct buffer_head *key_bh = NULL;
	struct prodos_ext_key_block *key_block = NULL;

	/* Need the key block so we can copy data fork info into the dir entry. */
	key_bh = prodos_bread(inode->i_sb,PRODOS_I(inode)->i_key);
	if (!key_bh) {
		result = -EIO;
		goto out_cleanup;
	}
	key_block = (void*)key_bh->b_data;

	/* Update the directory entry. Note that we don't have to worry about byte
	 order since we're copying from one on-disk entry to another. */
	ent->name[0] &= 0x0f;
	ent->name[0] |= key_block->data.stype << 4;
	ent->key_block = key_block->data.key_block;
	ent->blocks_used = key_block->data.blocks_used;
	memcpy(&ent->eof,&key_block->data.eof,3);

	/* TODO: Update the data and meta inodes here (stype, key block, size, blocks used) */

	/* Free affected disk blocks. */
	prodos_free_tree_blocks(inode->i_sb,key_block->res.stype << 4,
	 le16_to_cpu(key_block->res.key_block),
	 le16_to_cpu(key_block->res.blocks_used));
	prodos_free_block(inode->i_sb,PRODOS_I(inode)->i_key);

	/* The inode is now dirty; also return 1 to cause the directory buffer
	 to be marked dirty. */
	mark_inode_dirty(inode);
	result = 1;

out_cleanup:
	if (key_bh) prodos_brelse(key_bh);

	return result;
}
#endif
/*= Interface Functions =====================================================*/

/*****************************************************************************
 * dos33_lookup()
 * Search a directory inode for an entry.
 *****************************************************************************/
struct dentry *dos33_lookup(struct inode *inode,struct dentry *dentry) {
	
    SHORTCUT struct dos33_sb_info * const psb = DOS33_SB(inode->i_sb);
    struct dentry *result = NULL;
    unsigned long ino = 0;
   
    DOS33_DEBUG("Lookup\n");
   
       /* Grab directory lock. */
    down(&psb->s_dir_lock);

       /* Attempt to find matching entry and get its inode number. */
    ino = dos33_find_entry(inode,&dentry->d_name);
    if (!ino) {
       result = ERR_PTR(-ENOENT);
       goto out_cleanup;
    }

       /* Get the inode and set up a dentry. */
    inode = iget(inode->i_sb,ino);
    if (!inode) {
       DOS33_DEBUG("iget() failed for ino 0x%08x",(int)ino);
       result = ERR_PTR(-EACCES);
       goto out_cleanup;
    }
    dentry->d_op = &dos33_dentry_operations;
    d_add(dentry,inode);

out_cleanup:
    up(&psb->s_dir_lock);

    return result;
}

/*****************************************************************************
 * prodos_create()
 * Create a new entry in directory inode @dir. Note that the VFS has already
 * checked that the filename is unique within the directory.
 *****************************************************************************/
int dos33_create(struct inode *dir,struct dentry *dentry,int mode) {
//	SHORTCUT struct prodos_sb_info * psb = PRODOS_SB(dir->i_sb);
	int result = 0;
//	unsigned long ino = 0;
//	struct buffer_head *dir_bh = NULL;
                DOS33_DEBUG("create\n");
   
#if 0
	PRODOS_ERROR_0(dir->i_sb,"called");

	/* Grab directory lock. */
	down(&psb->s_dir_lock);

	/* Get an unused "inode" in the directory. */
	ino = prodos_find_entry(dir,NULL);
	if (!ino) {
		result = -ENOSPC;
		goto out_cleanup;
	}

	/* Read the directory block. */
/*	dir_bh = prodos_bread(dir->i_sb,PRODOS_INO_DBLK(ino));
	if (!dir_bh) {
		result = -EIO;
		goto out_cleanup;
	}*/

	result = -EPERM;

out_cleanup:
	if (dir_bh) prodos_brelse(dir_bh);
	up(&psb->s_dir_lock);
#endif
	return result;
}

/*****************************************************************************
 * prodos_unlink()
 *****************************************************************************/
/* NOTE: The VFS holds the inode->i_zombie semaphore during this call. */
/* The big kernel lock is also held for exactly the duration of this call. */
int dos33_unlink(struct inode *inode,struct dentry *dentry) {
//	SHORTCUT struct prodos_sb_info * const psb = PRODOS_SB(inode->i_sb);
//	SHORTCUT struct inode * const victim = dentry->d_inode;
	int result = 0;
//	struct buffer_head *dir_bh = NULL;
//	struct prodos_dir_entry *ent = NULL;
   
            DOS33_DEBUG("unlink\n");
   
#if 0
	/* Grab directory lock. */
	down(&psb->s_dir_lock);

	/* Load the directory block. */
	dir_bh = prodos_bread(inode->i_sb,PRODOS_INO_DBLK(victim->i_ino));
	if (!dir_bh) {
		result = -EIO;
		goto out_cleanup;
	}
	ent = &((struct prodos_dir_block*)dir_bh->b_data)->entries[PRODOS_INO_DENT(victim->i_ino)];

	/* Dispatch appropriate unlink function. */
	switch (PRODOS_INO_DFORK(victim->i_ino)) {
	case PRODOS_DFORK_DATA:
		result = prodos_unlink_all(victim,ent);
		break;
	case PRODOS_DFORK_META:
		result = prodos_unlink_all(victim,ent);
		break;
	case PRODOS_DFORK_RES:
		if (!PRODOS_ISEXTENDED(*ent)) {
			result = -ENOENT;
			goto out_cleanup;
		}
		result = prodos_unlink_res(victim,ent);
		break;
	}

	/* The prodos_unlink_*() helper returned 1 if it dirtied the dir block. */
	if (result == 1) {
		mark_buffer_dirty(dir_bh);
		result = 0;
	}

out_cleanup:
	if (dir_bh) prodos_brelse(dir_bh);
	up(&psb->s_dir_lock);
#endif
	return result;
}

/*****************************************************************************
 * prodos_rename()
 *****************************************************************************/
int dos33_rename(struct inode *oi,struct dentry *od,struct inode *ni,struct dentry *nd) {
	int result = 0;
   
           DOS33_DEBUG("rename\n");
   
#if 0
	/* Our inode number usage prevents all but in-directory renames. */
	if (oi != ni) {
		result = -EPERM;
		goto out_cleanup;
	}

	result = -EPERM;

out_cleanup:
#endif
	return result;
}

/*****************************************************************************
 * dos33_readdir()
 * Standard file operation; reads a directory and returns its entries via
 * the filldir() function supplied by the caller.
 *****************************************************************************/
int dos33_readdir(struct file *filp,void *dirent,filldir_t filldir) {
	
    SHORTCUT struct super_block * const sb = filp->f_dentry->d_sb;
    SHORTCUT struct inode * const inode = filp->f_dentry->d_inode;
    SHORTCUT struct inode * const parent = filp->f_dentry->d_parent->d_inode;
    int result = 0;
    struct buffer_head *bh = NULL;
    struct dos33_catalog_sector *catalog = NULL;
    u32 dent=0;   
   
    u32 catalog_track = DOS33_INO_TRACK(filp->f_pos);
    u32 catalog_sector = DOS33_INO_SECTOR(filp->f_pos);
    u32 catalog_block;
    u32 odd;
    struct dos33_file_t *ent = NULL;

    char name[DOS33_MAX_NAME_LEN + 3] = "";
    int nlen;
    unsigned int ino = 0;
   
    DOS33_DEBUG("readdir\n");

       /* Handle the special '.' and '..' entries. */
    switch ( (long int)filp->f_pos) {
	 
	  case 0: /* Add the '.' entry. */
		  if (filldir(dirent,".",1,0,inode->i_ino,DT_DIR) < 0)
		     goto out_cleanup;

		  /* fpos is simply incremented at this point. */
		  filp->f_pos++;
		  /* Fall through. */

          case 1: /* Add the '..' entry. */
		  if (filldir(dirent,"..",2,1,parent->i_ino,DT_DIR) < 0)
		     goto out_cleanup;

		  /* fpos takes on special format after second entry. */
		  filp->f_pos = DOS33_MAKE_INO(0,0,
					       DOS33_INO_TRACK(inode->i_ino),
					       DOS33_INO_SECTOR(inode->i_ino));
    }

       /* Grab directory lock. */
    down(&DOS33_SB(sb)->s_dir_lock);

	/* After the two special entries, filp->f_pos is the "inode number" of the
	 next file (or fork) in the directory. See the PRODOS_INO_*() and
	 PRODOS_MAKE_INO() macros for the format of this value. When all entries
	 have been returned filp->f_pos is set to 3 to signal end-of-directory. */
    while (filp->f_pos != 3) {
	  
       catalog_block=((catalog_track<<4)+catalog_sector);
       odd=catalog_block%2;

       DOS33_DEBUG("filp: %x dblk: %x  %i %i\n",(int)filp->f_pos,(int)catalog_block,(int)catalog_track,(int)catalog_sector);
	   
	  /* Load the block if necessary. */
       if (!bh) {
	  bh = dos33_bread(sb,catalog_block);
	  if (!bh) {
	     result = -EIO;
	     goto out_cleanup;
	  }
	     /* handle 256 byte sectors */
	  if (odd) {
	     catalog = (struct dos33_catalog_sector*)(bh->b_data+256);
	  }
	  else {
	     catalog = (struct dos33_catalog_sector*)bh->b_data;
	  }
       }


       ent = &catalog->files[dent];
	 
          /* Copy and modify the name as necessary. */
       if (ent->file_name[0]!=0) {
	  memcpy(name,&(ent->file_name),DOS33_MAX_NAME_LEN+1);
	  nlen=dos33_convert_filename(name);
	       
	     /* Build inode number. */
	  ino = DOS33_MAKE_INO(0,dent,catalog_track,
			              catalog_sector);
	  
	     /* Finally, attempt to return the entry via filldir(). */
	  if (filldir(dirent,&name[0],nlen,filp->f_pos,ino,DT_UNKNOWN) < 0)
	     goto out_cleanup;
       }
       dent++;
	     
       if (dent>6) {
	  dent=0;
	  dos33_brelse(bh);
	  bh=NULL;
	  
	  catalog_track=(catalog->next.track);
	  catalog_sector=(catalog->next.sector);
	  
	  if ((!catalog_track) && (!catalog_sector)) {
	     filp->f_pos=3;
	  }
	  
       }
    }

/* Release remaining resources and return. */
out_cleanup:
	if (bh) {
		dos33_brelse(bh);
		bh = NULL;
	}
    up(&DOS33_SB(sb)->s_dir_lock);

    return result;
}

