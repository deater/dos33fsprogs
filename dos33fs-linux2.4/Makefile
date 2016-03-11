CC=gcc
CFLAGS= -O2 -Wall -DDEBUG_LEVEL=0 -DCONFIG_DOS33_FS -D__KERNEL__ -DMODULE -I/usr/src/linux/include
OBJS=file.o dir.o dentry.o inode.o misc.o super.o

dos33.o:	$(OBJS)
		$(LD) -r $^ -o $@

file.o:		dos33.h dos33_fs.h file.c

dir.o:		dos33.h dos33_fs.h dir.c

dentry.o:	dos33.h dos33_fs.h dentry.c

inode.o:	dos33.h dos33_fs.h inode.c

super.o:	dos33.h dos33_fs.h super.c

misc.o:		dos33.h dos33_fs.h misc.c

clean:		
		rm -rf *.o *~
