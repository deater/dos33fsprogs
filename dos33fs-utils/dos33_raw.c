#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

/* usage: dos33_raw track sector file */
static void usage(char *exe_name) {
	printf("Usage:\n");
	printf("\t%s disk_image track sector file start count\n\n",exe_name);
	exit(1);
}

static int dos33_sector_map[16]={
	0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15
};

static int goto_dos_track_sector(int fd, int track, int sector) {

	int result,translated_sector;

	translated_sector=dos33_sector_map[sector%16];

	result=lseek(fd,(translated_sector*256)+(track*16*256),SEEK_SET);

	printf("going to: T=%d S=%d (%d)\n",track,sector,translated_sector);

	return result;
}

int main(int argc, char **argv) {

	unsigned int track,sector,start,count,total;
	int disk_image_fd;
	int file_fd;
	unsigned char buffer[256];
	int result,read_result;

	if (argc<6) {
		usage(argv[0]);
	}

	track=atoi(argv[2]);
	sector=atoi(argv[3]);
	start=atoi(argv[5]);
	count=atoi(argv[6]);

	/* FIXME: check limits based on stat of file */

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

	result=lseek(file_fd,(start*256),SEEK_SET);
	if (result<0) {
		fprintf(stderr,"Error skipping: %s\n",strerror(errno));
		exit(1);
	}


	total=0;
	/* write until out of space */
	while(1) {
		if (total>=count) break;

		read_result=read(file_fd,buffer,256);
		if (read_result<0) break;	/* error */
		if (read_result==0) break;	/* done */

		result=goto_dos_track_sector(disk_image_fd,track,sector);
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
		sector++;
		if (sector==16) {
			sector=0;
			track++;
		}
	}

	close(file_fd);
	close(disk_image_fd);

	return 0;
}
