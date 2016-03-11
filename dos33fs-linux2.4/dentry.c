/*****************************************************************************
 * dentry.c
 * dentry operations.
 *
 * Apple II DOS 3.3 Filesystem Driver for Linux 2.4.x
 * Copyright (c) 2001 Vince Weaver
 * Copyright (c) 2001 Matt Jensen.
 * This program is free software distributed under the terms of the GPL.
 *****************************************************************************/

/*= Kernel Includes ========================================================*/

#include <linux/time.h>
#include <linux/fs.h>

/*= DOS 3.3 Includes =======================================================*/

#include "dos33.h"

/*= Forward Declarations ====================================================*/

/* For dos33_dentry_operations. */
int dos33_hash_dentry(struct dentry *,struct qstr *);
int dos33_compare_dentry(struct dentry *,struct qstr *,struct qstr *);

/*= Preprocessor Macros =====================================================*/

/*= VFS Interface Structures ================================================*/

struct dentry_operations dos33_dentry_operations = {
	d_hash: dos33_hash_dentry,
	d_compare: dos33_compare_dentry
};

/*= Private Functions =======================================================*/

/*= Interface Functions =====================================================*/

/*****************************************************************************
 * dos33_hash_dentry()
 * Check a name for validity under DOS33 naming rules; if it is valid, hash
 * it.
 *****************************************************************************/
int dos33_hash_dentry(struct dentry *de,struct qstr *qstr) {
	
    unsigned long hash = 0;
    int len = 0;
    int i = 0;
   
       /* Ensure that we have a valid ProDOS name. */
    i = dos33_check_name(qstr);
    if (i) return i;

       /* Hash the name. */
    if (len>DOS33_MAX_NAME_LEN) len=DOS33_MAX_NAME_LEN;
   
     hash = init_name_hash();
     for(i = 0;i < len;i++) hash = partial_name_hash(qstr->name[i],hash);
     qstr->hash = end_name_hash(hash);

     return 0;
}

/*****************************************************************************
 * dos33_compare_dentry()
 * Compare two hashed DOS 3.3 names.
 *****************************************************************************/
int dos33_compare_dentry(struct dentry *de,struct qstr *q1,struct qstr *q2) {
    
    int len = 0;
    int i = 0;
   
       /* q2 has not been validated yet. */
    i = dos33_check_name(q2);
    if (i) return i;

       /* Ignore characters past the maximum DOS 3.3 name length. */
    len = q1->len;
    if (q1->len >= DOS33_MAX_NAME_LEN) {
       if (q2->len < DOS33_MAX_NAME_LEN) return 1;
       len = DOS33_MAX_NAME_LEN;
    }
    else if (len != q2->len) return ~0;

       /* Compare the strings. */
    for (i = 0;i < len;i++) {
	if (q1->name[i] != q2->name[i]) return ~0;
    }

    return 0;
}

