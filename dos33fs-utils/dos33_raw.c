#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

/* usage: dos33_raw track sector file */
static void usage(char *exe_name) {
	printf("Usage:\n");
	printf("\t%s disk_image track sector file\n\n",exe_name);
	exit(1);
}


int main(int argc, char **argv) {

	unsigned int track,sector;
	int disk_image_fd;
	int file_fd;
	unsigned char buffer[256];
	int result;

	if (argc<4) {
		usage(argv[0]);
	}

	track=atoi(argv[2]);
	sector=atoi(argv[3]);

	if (track>34) {
		fprintf(stderr,"Warning!  Unusual track number %d\n",track);
	}

	if (track>15) {
		fprintf(stderr,"Warning!  Unusual sector number %d\n",sector);
	}

	disk_image_fd=open(argv[1],O_RDWR);
	if (disk_image_fd<0) {
		fprintf(stderr,"Error opening %s: %s\n",
			argv[1],strerror(errno));
		exit(1);
	}

	file_fd=open(argv[4],O_RDONLY);
	if (file_fd<0) {
		fprintf(stderr,"Error opening %s: %s\n",
			argv[4],strerror(errno));
		exit(1);
	}

	result=lseek(disk_image_fd,(sector*256)+(track*16*256),SEEK_SET);
	if (result<0) {
		fprintf(stderr,"Error seeking: %s\n",strerror(errno));
		exit(1);
	}

	/* write until out of space */
	while(1) {
		result=read(file_fd,buffer,256);
		if (result<0) break;	/* error */
		if (result==0) break;	/* done */
		result=write(disk_image_fd,buffer,result);
		if (result<0) {
			fprintf(stderr,"Error writing image: %s\n",
				strerror(errno));
			break;
		}
	}

	close(file_fd);
	close(disk_image_fd);

	return 0;
}
