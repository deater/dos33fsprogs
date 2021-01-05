/*****************************************************************************
 * prodos/prodos_fs.h
 * Includes, definitions, and helpers pertaining to the ProDOS filesystem
 * implementation.
 *
 * Apple II ProDOS Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *
 * 18-May-2001: Created
 *****************************************************************************/
#ifndef __DOS33_DOS33_FS_H
#define __DOS33_DOS33_FS_H

/*= Preprocessor Constants ==================================================*/

/* Block size. */
#define DOS33_BLOCK_SIZE			0x200
#define DOS33_BLOCK_SIZE_BITS		9 /* log base-2 of PRODOS_BLOCK_SIZE */

/* Number of entries per directory block. */
#define DOS33_DIR_ENTS_PER_BLOCK	7

/* Various limits and maximums. */
#define DOS33_MAX_NAME_LEN			0x1e
#define DOS33_MAX_FILE_SIZE		0x00ffffff

#define DOS33_SUPER_MAGIC                     0x02131978

#define DOS33_VOLUME_DIR_BLOCK		(0x11*0x10)
#define DOS33_VOLUME_DIR_TRACK		0x11
#define DOS33_VOLUME_DIR_SECTOR		0x00


#define TWO_BYTES_TO_SHORT(__x,__y) ((((int)__y)<<8)+__x)

#if (DEBUG_LEVEL==1)

#define DOS33_DEBUG printk

#else

#define DOS33_DEBUG if (0) printk

#endif
#define DOS33_ERROR printk

#endif
