/*****************************************************************************
 * file.c
 * File and inode operations for regular files.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes =========================================================*/


#include <linux/types.h>
#include <linux/locks.h>

/*= DOS 3.3 Includes =======================================================*/

#include "dos33.h"

/*= Forward Declarations ====================================================*/

/* For dos33_address_space_operations. */
int dos33_readpage(struct file *,struct page *);
int dos33_writepage(struct page *);
int dos33_prepare_write(struct file *,struct page *,unsigned int, unsigned int);
int dos33_commit_write(struct file*,struct page *,unsigned int,unsigned int);
int dos33_bmap(struct address_space *,long);

/*= VFS Interface Structures ================================================*/

struct inode_operations dos33_file_inode_operations = {

};

struct file_operations dos33_file_operations = {
	read: generic_file_read,
	write: generic_file_write,
	mmap: generic_file_mmap
};

struct address_space_operations dos33_address_space_operations = {
	readpage: dos33_readpage,
	writepage: dos33_writepage,
	sync_page: block_sync_page,
	prepare_write: dos33_prepare_write,
	commit_write: dos33_commit_write,
	bmap: dos33_bmap
};

/*= Interface Functions =====================================================*/

/*****************************************************************************
 * dos33_get_block()
 * Translate a block number within an @inode into a logical disk block number.
 *****************************************************************************/
int dos33_get_block(struct inode *inode,long block,struct buffer_head *bh_res,int create) {

    int result = 0;

    struct dos33_catalog_sector *catalog = NULL;
    struct dos33_file_t *file_ent;
   
    struct dos33_ts_list *tsl;
    int i;         
    u32 catalog_block=(DOS33_INO_TRACK(inode->i_ino)<<4)+
                       DOS33_INO_SECTOR(inode->i_ino);
   
    u32 data_block;
    u32 odd,half_block;

    u32 file_entry=DOS33_INO_ENTRY(inode->i_ino);
    u32 tsl_block;
		    
    struct buffer_head *bh = NULL;
    struct buffer_head *bh2 = NULL;

    struct buffer_head *bh_temp=NULL;
   
   
   
    DOS33_DEBUG("** get_block 0x%x from file 0x%x\n",(int)block,(int)inode->i_ino);
 #if 0
        /* Verify that the block number is valid. */
    if ((block < 0) || (block >= inode->i_blocks)) {
       printk("** bad block number: 0< 0x%x < 0x%x\n",(int)block,(int)inode->i_blocks);
       result = -EIO;
       goto out_cleanup;
    }
#endif
    
    if (!bh) {
       odd=catalog_block%2;
          /* Load the block. */
       DOS33_DEBUG("** Loading block %x\n",catalog_block);
       bh = dos33_bread(inode->i_sb,catalog_block);
       if (!bh) {
	  DOS33_ERROR("** dos33_bread() failed for block %d\n",catalog_block);
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
    file_ent=&catalog->files[file_entry];
       
    tsl_block= (file_ent->first_tsl.track<<4)+file_ent->first_tsl.sector;

    DOS33_DEBUG("** going to try reading tsl from 0x%x\n",tsl_block);

    odd=tsl_block%2;
          /* Load the block. */
       
    bh2 = dos33_bread(inode->i_sb,tsl_block);
       if (!bh2) {
	  DOS33_ERROR("** dos33_bread() failed for block %d\n",tsl_block);
	  goto out_cleanup;
       }
          /* deal with 256byte sector size */
       if (odd) {
	  tsl = (struct dos33_ts_list*)(bh2->b_data+256);
       }
       else {
	  tsl = (struct dos33_ts_list*)(bh2->b_data);
       }

           /* each tsl list only holds 122 sectors */
           /* so if bigger, we must follow the chain to the proper tsl */
       if ((block*2) > 122) {
	  DOS33_DEBUG("!! need tsl %i\n",(int)((block*2)/122));
	   
	  for (i=0;i< ((block*2)/122);i++) {
	      tsl_block=((tsl->next.track)<<4)+tsl->next.sector;
	      if (tsl_block==0) {
		 DOS33_ERROR("dos33.o: NULL TSL BLOCK!\n");
		 goto out_cleanup;
	      }
	      DOS33_DEBUG("!! going to tsl in block 0x%x\n",tsl_block);
	  
	      dos33_brelse(bh2);
	      bh2=NULL;
	     
	      odd=tsl_block%2;
                 /* Load the block. */
       
              bh2 = dos33_bread(inode->i_sb,tsl_block);
              if (!bh2) {
	         DOS33_ERROR("dos33_bread() failed for block %d\n",tsl_block);
	         goto out_cleanup;
	      }
                 /* deal with 256byte sector size */
              if (odd) {
	         tsl = (struct dos33_ts_list*)(bh2->b_data+256);
              }
              else {
	         tsl = (struct dos33_ts_list*)(bh2->b_data);
	      }
	  }
	     /* move block to the proper value */
	  block=block%61;
	       
       }
	  
	   
       
       /* OK, we know where the data is, not let's trick the VFS */
       /* into thinking we can read 256 byte blocks */

    for (half_block=0;half_block<2;half_block++) {
        
       
        data_block=(u32)( ((tsl->data_location[(block*2)+half_block].track)<<4)+
			       tsl->data_location[(block*2)+half_block].sector);
        DOS33_DEBUG("!!** found block: %x [%x %x] (pass %i request block %i)\n",
		    data_block,tsl->data_location[(block*2)+half_block].track,
		    tsl->data_location[(block*2)+half_block].sector,half_block,(int)block);    


        if (data_block==0) {
           /* a hole.. but since we have to fake block size */
           /* we fill it with zeros ourselves               */
           DOS33_DEBUG("** HOLE\n");

           lock_buffer(bh_res);
           memset(bh_res->b_data+(half_block*256),0,256);
           bh_res->b_state |= (1 << BH_Mapped);
           mark_buffer_uptodate(bh_res,1);
           unlock_buffer(bh_res);   

       }
       else {
          bh_temp = dos33_bread(inode->i_sb,data_block);
          if (!bh_temp) {
             DOS33_ERROR("dos33_bread() failed for block %d\n",data_block);
             goto out_cleanup;
	  }

          if (data_block%2) {	  
	     lock_buffer(bh_res);
             memcpy(bh_res->b_data+(half_block*256),bh_temp->b_data+256,256);
             bh_res->b_state |= (1 << BH_Mapped);
             mark_buffer_uptodate(bh_res,1);
             unlock_buffer(bh_res);   
	  }
          else {
	     lock_buffer(bh_res);
             memcpy(bh_res->b_data+(half_block*256),bh_temp->b_data,256);
             bh_res->b_state |= (1 << BH_Mapped);
             mark_buffer_uptodate(bh_res,1);
             unlock_buffer(bh_res);   
	  }
          DOS33_DEBUG("** copying 256bytes from sector 0x%x starting with %0x %0x\n",
	         data_block,
	         (char)*(bh_temp->b_data),(char)*(bh_temp->b_data+1));

       }
    }
out_cleanup:

        if (bh) dos33_brelse(bh);
        if (bh2) dos33_brelse(bh2);
        if (bh_temp) dos33_brelse(bh_temp);
	return result;
}

/*****************************************************************************
 * prodos_get_block_write()
 * get_block_t function for write operations.  This function is ugly and
 * probably temporary.  Ultimately it should be merged with prodos_get_block()
 * and thoroughly cleaned.  What you see here is basically a quick and (very)
 * dirty hack.
 *****************************************************************************/
int dos33_get_block_write(struct inode *inode,long block,struct buffer_head *bh_res,int create) {
//	SHORTCUT struct prodos_inode_info * const pi = PRODOS_I(inode);
	int result = 0;

        DOS33_DEBUG("get_block_write\n");
   
#if 0
	/* Croak on non-regular files for now. */
	if ((pi->i_stype < PRODOS_STYPE_SEEDLING) || (pi->i_stype > PRODOS_STYPE_TREE)) {
		PRODOS_ERROR_0(inode->i_sb,"extended files not supported for writing");
		result = -EPERM;
		goto out_cleanup;
	}

	/* Can't translate block numbers that are out of range. */
	if (block >= PRODOS_MAX_FILE_SIZE >> PRODOS_BLOCK_SIZE_BITS) {
		result = -EFBIG;
		goto out_cleanup;
	}

	/* Expand the file if necessary. */
	if (block >= inode->i_blocks) {
		u8 new_stype = pi->i_stype;
		u16 new_key = pi->i_key;
		u16 new_bused = inode->i_blocks;

		/* May have to convert a seedling into a sapling. */
		if ((block > 0) && (new_stype == PRODOS_STYPE_SEEDLING)) {
			u16 key_ptr = 0;
			struct buffer_head *bh = NULL;

			/* Allocate the new indirect block. */
			key_ptr = prodos_alloc_block(inode->i_sb);
			if (!key_ptr) {
				result = -ENOSPC;
				goto out_cleanup;
			}

			/* Load and initialize the indirect block. */
			bh = prodos_bread(inode->i_sb,key_ptr);
			if (!bh) {
				result = -EIO;
				goto out_cleanup;
			}
			memset(bh->b_data,0,PRODOS_BLOCK_SIZE);
			PRODOS_SET_INDIRECT_ENTRY(bh->b_data,0,new_key);
			mark_buffer_dirty(bh);
			prodos_brelse(bh);

			new_stype = PRODOS_STYPE_SAPLING;
			new_key = key_ptr;
			new_bused++;
		}

		/* May have to convert a sapling into a tree. */
		if ((block > 256) && (new_stype == PRODOS_STYPE_SAPLING)) {
			u16 key_ptr = 0;
			struct buffer_head *bh = NULL;

			/* Allocate the new double indirect block. */
			key_ptr = prodos_alloc_block(inode->i_sb);
			if (!key_ptr) {
				result = -ENOSPC;
				goto out_cleanup;
			}

			/* Load and initialize the double indirect block. */
			bh = prodos_bread(inode->i_sb,key_ptr);
			if (!bh) {
				result = -EIO;
				goto out_cleanup;
			}
			memset(bh->b_data,0,PRODOS_BLOCK_SIZE);
			PRODOS_SET_INDIRECT_ENTRY(bh->b_data,0,new_key);
			mark_buffer_dirty(bh);
			prodos_brelse(bh);

			new_stype = PRODOS_STYPE_TREE;
			new_key = key_ptr;
			new_bused++;
		}

		/* Update the inode if storage type changed. */
		if (new_stype != pi->i_stype) {
			pi->i_stype = new_stype;
			pi->i_key = new_key;
			inode->i_blocks = new_bused;
			mark_inode_dirty(inode);
		}

		/* May need to expand indexes for a tree file. */
		if (new_stype == PRODOS_STYPE_TREE) {
			u16 ind_existing = ((inode->i_blocks - 1) >> 8) + 1;
			u16 ind_needed = block >> 8;
			u16 ind_ptr = 0;
			struct buffer_head *dind_bh = NULL;
			struct buffer_head *ind_bh = NULL;

			dind_bh = prodos_bread(inode->i_sb,pi->i_key);
			if (!dind_bh) {
				result = -EIO;
				goto out_cleanup;
			}
			for (;ind_existing < ind_needed;ind_existing++) {
				ind_ptr = prodos_alloc_block(inode->i_sb);
				if (!ind_ptr) {
					result = -ENOSPC;
					goto out_cleanup;
				}
				ind_bh = prodos_bread(inode->i_sb,ind_ptr);
				if (!ind_bh) {
					result = -EIO;
					goto out_cleanup;
				}
				memset(ind_bh,0,PRODOS_BLOCK_SIZE);
				PRODOS_SET_INDIRECT_ENTRY(dind_bh->b_data,ind_existing,ind_ptr);
				prodos_brelse(ind_bh);
				inode->i_blocks = ++new_bused;
			}
			prodos_brelse(dind_bh);
		}

	}

	{
		u16 blk = pi->i_key;
		struct buffer_head *bh = NULL;
		/* Appropriate action depends upon the file's storage type. */
		switch (pi->i_stype) {
			case PRODOS_STYPE_TREE:
				/* Load double indirect block. */
				bh = prodos_bread(inode->i_sb,blk);
				if (!bh) {
					result = -EIO;
					goto out_cleanup;
				}

				/* Get indirect block and release double indirect block. */
				blk = PRODOS_GET_INDIRECT_ENTRY(bh->b_data,block >> 8);
				prodos_brelse(bh);
				bh = NULL;
				/* Fall through. */
			case PRODOS_STYPE_SAPLING:
				/* Load indirect block. */
				bh = prodos_bread(inode->i_sb,blk);
				if (!bh) {
					result = -EIO;
					goto out_cleanup;
				}

				/* Get data block and release indirect block. */
				blk = PRODOS_GET_INDIRECT_ENTRY(bh->b_data,block & 0xff);
				if (!blk) {
					bh_res->b_state |= (1UL << BH_New);
					blk = prodos_alloc_block(inode->i_sb);
					if (!blk) {
						result = -ENOSPC;
						goto out_cleanup;
					}
					PRODOS_SET_INDIRECT_ENTRY(bh->b_data,block & 0xff,blk);
					inode->i_blocks++;
				}
				prodos_brelse(bh);
				bh = NULL;

				/* Fall through. */
			case PRODOS_STYPE_SEEDLING:
				/* Set bh_res fields to cause the block to be read from disk. */
				bh_res->b_blocknr = PRODOS_SB(inode->i_sb)->s_part_start + blk;
				bh_res->b_dev = inode->i_dev;
				bh_res->b_state |= (1 << BH_Mapped);
		}
	}

	mark_inode_dirty(inode);

out_cleanup:
#endif
	return result;
}

/*****************************************************************************
 * dos33_readpage()
 *****************************************************************************/
int dos33_readpage(struct file *filp,struct page *page) {
	int result = 0;

        DOS33_DEBUG("readpage\n");
   
	/* Let the generic "read page" function do most of the work. */
	result = block_read_full_page(page,dos33_get_block);

	/* Propagate block_read_full_page() return value. */
	return result;
}

/*****************************************************************************
 * prodos_writepage()
 *****************************************************************************/
int dos33_writepage(struct page *page) {
           DOS33_DEBUG("writepage\n");
   
	/* Generic function does the work with the help of a get_block function. */
//	PRODOS_ERROR_0(page->mapping->host->i_sb,"called");
//	return block_write_full_page(page,prodos_get_block_write);
        return 0;
}


/*****************************************************************************
 * prodos_prepare_write()
 *****************************************************************************/
int dos33_prepare_write(struct file *file,struct page *page,unsigned int from,unsigned int to) {
	        DOS33_DEBUG("prepare_write\n");
   
////	return block_prepare_write(page,from,to,prodos_get_block_write);
	return 0;
}

/*****************************************************************************
 * prodos_commit_write()
 *****************************************************************************/
int dos33_commit_write(struct file *file,struct page *page,unsigned int from,unsigned int to) {
           DOS33_DEBUG("commit write\n");
   
#if 0  
	/* Convert text files to ProDOS format. */
	if (PRODOS_I(page->mapping->host)->i_flags & PRODOS_I_CRCONV) {
		int i = 0;
		char *pdata = kmap(page);
		for (i = 0;i < PAGE_CACHE_SIZE;i++,pdata++)
			if (*pdata == '\n') *pdata = '\r';
		kunmap(page);
	}

	/* Let generic function do the real work. */
#endif
	return generic_commit_write(file,page,from,to);
}

/*****************************************************************************
 * prodos_bmap()
 *****************************************************************************/
int dos33_bmap(struct address_space *mapping,long block) {
           DOS33_DEBUG("bmap\n");
   
	/* Generic function does the work with the help of a get_block function. */
//	PRODOS_ERROR_0(mapping->host->i_sb,"called");
//	return generic_block_bmap(mapping,block,prodos_get_block_write);
	return 0;
}




