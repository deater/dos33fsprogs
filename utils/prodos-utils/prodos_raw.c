#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#include <sys/stat.h>

#include "prodos.h"

/* usage: prodos_raw block file start count max*/

static void usage(char *exe_name) {
	printf("Usage:\n");
	printf("\t%s disk_image block file start count [max_block]\n\n",exe_name);
	exit(1);
}

//static int dos33_sector_map[16]={
//	0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15
//};

static int goto_prodos_block(int fd, int block, int offset) {

	int result;

	/* For now, assume prodos order */
//	translated_sector=dos33_sector_map[sector%16];

	result=lseek(fd,offset+(block*512),SEEK_SET);

//	printf("going to: B=%d\n",block);

	return result;
}

int main(int argc, char **argv) {

	unsigned int block,start,count,total,max_block,filesize;
	unsigned int check_max=0;
	int disk_image_fd;
	int file_fd;
	unsigned char buffer[512];
	int result,read_result;
	struct stat statbuf;
	unsigned char header[64];
	int debug=0;
	int interleave=PRODOS_INTERLEAVE_PRODOS,num_blocks,offset=0;

	if (argc<6) {
		usage(argv[0]);
	}

	/* usage: prodos_raw block file start count max*/

	block=atoi(argv[2]);
	start=atoi(argv[4]);
	count=atoi(argv[5]);

	if (argc>6) {
		max_block=atoi(argv[6]);
		check_max=1;
	}

	/* open disk image */
	disk_image_fd=open(argv[1],O_RDWR);
	if (disk_image_fd<0) {
		fprintf(stderr,"Error opening disk image %s: %s\n",
			argv[1],strerror(errno));
		exit(1);
	}

	/* open file */
	file_fd=open(argv[3],O_RDONLY);
	if (file_fd<0) {
		fprintf(stderr,"Error opening file %s: %s\n",
			argv[3],strerror(errno));
		exit(1);
	}

	/* check if 2img format */
	result=read(disk_image_fd,header,64);
	if (result<0) {
		fprintf(stderr,"Error reading header\n");
		exit(1);
	}

	result=read_2mg_header(header,&num_blocks,
		&interleave,&offset,debug);
	if (result<0) {
		/* try figuring things out otherwise */
		result=stat(argv[1], &statbuf);
		num_blocks=statbuf.st_size/512;
		if (num_blocks%512==0) num_blocks++;
	}

	/* check filesize using stat */
	result=stat(argv[3], &statbuf);
	if (result<0) {
		fprintf(stderr,"Error stating %s: %s\n",
		argv[3],strerror(errno));
		exit(1);
	}
	filesize=statbuf.st_size;

	if (count==0) {
		count=(filesize/512);
		if ((filesize%512)!=0) count++;
	}

	/* sanity check a bit */

	/* max prodos image is 65535 */
	if (block>65535) {
		fprintf(stderr,"Warning!  Unusual block number %d\n",block);
		exit(1);
	}

	/* check if end too high */
	if (block+count>num_blocks) {
		fprintf(stderr,"Error! Last block %d beyond max image block %d\n",
				block+count,num_blocks);
		exit(1);
	}

	/* sanity check we aren't going above self-imposed max */
	if (check_max) {
		if (block+count>max_block) {
			fprintf(stderr,"Error, %d exceeds max_block of %d\n",
				block+count,max_block);
			exit(1);
		}
	}

	if (interleave!=PRODOS_INTERLEAVE_PRODOS) {
		fprintf(stderr,"Error! Unsupported interleave!\n");
		exit(1);
	}

	/* seek in source file if needed */
	result=lseek(file_fd,(start*512),SEEK_SET);
	if (result<0) {
		fprintf(stderr,"Error skipping: %s\n",strerror(errno));
		exit(1);
	}

	total=0;
	/* write until out of space */
	while(1) {
		if (total>=count) break;

		read_result=read(file_fd,buffer,512);
		if (read_result<0) break;	/* error */
		if (read_result==0) break;	/* done */

		result=goto_prodos_block(disk_image_fd,block,offset);
		if (result<0) {
			fprintf(stderr,"Error seeking: %s\n",strerror(errno));
			exit(1);
		}

		result=write(disk_image_fd,buffer,read_result);
		if (result<0) {
			fprintf(stderr,"Error writing image: %s\n",
				strerror(errno));
			break;
		}
		total++;
		block++;
	}

	close(file_fd);
	close(disk_image_fd);

	fprintf(stderr,"Wrote %d blocks\n",total);

	return 0;
}
