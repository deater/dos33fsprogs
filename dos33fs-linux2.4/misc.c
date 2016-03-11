/*****************************************************************************
 * misc.c
 * Miscellaneous utility and helper functions.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes =========================================================*/

#include <linux/blkdev.h>

/*= DOS 3.3 Includes =========================================================*/

#include "dos33.h"

extern int dos33_convert_filename(char *filename) {
   
  int i,last_char=0;
   
   for(i=0;i<DOS33_MAX_NAME_LEN;i++) {
      filename[i]&=0x7f;   /* strip high bit */ 
      if (filename[i]!=0x20) last_char=i;
   }
   filename[last_char+1]=0;
//   printk("%i : \"%s\"\n",last_char,filename);
   return last_char+1;
}


/*****************************************************************************
 * dos33_check_name()
 * Check a name for validity under DOS 3.3 naming rules.
 * namely, first character must be > 63
 * no commas or colors allowed.  Everything else goes
 *****************************************************************************/
int dos33_check_name(struct qstr *qstr) {
	
    int len = qstr->len;
    int i;
   
       /* Check only up to ProDOS name length limit. */
    if (len>DOS33_MAX_NAME_LEN) len=DOS33_MAX_NAME_LEN;
   
    if (qstr->name[0]<64) return -EINVAL;
   
    for(i=0;i<len;i++) {
       if ((qstr->name[i]==',') || (qstr->name[i]==':')) return -EINVAL; 
    }
   
    return 0;
}

/*****************************************************************************
 * dos33_bread()
 * Read a block from a device.
 * do some magic for the 256byte->512byte transition
 *****************************************************************************/
struct buffer_head *dos33_bread(struct super_block *sb,int block_num) {
   
    int internal_block_num=block_num/2;
   
    SHORTCUT struct dos33_sb_info * const psb = DOS33_SB(sb);
   
    if (internal_block_num < 0 || internal_block_num >= psb->s_part_size) {
	   return NULL;
    }
    DOS33_DEBUG("Attempting to read block 0x%x %i\n",internal_block_num,
	   psb->s_part_start+internal_block_num);
    return bread(sb->s_dev,psb->s_part_start + internal_block_num,DOS33_BLOCK_SIZE);
}

/*****************************************************************************
 * dos33_brelse()
 * Release a block that was previously read via dos33_bread().
 *****************************************************************************/
void dos33_brelse(struct buffer_head *bh) {
	
    brelse(bh);
}


