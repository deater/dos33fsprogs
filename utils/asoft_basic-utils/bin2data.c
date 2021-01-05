#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>


int main(int argc, char **argv) {

	int address=0x300;
	int bytes=0,line=10,i;
	struct stat file_info;
	int fd;
	unsigned char c;

	if (argc<2) {
		printf("Usage:\t%s binfile [addr]\n\n",argv[0]);
		return -1;
	}

	if (argc>2) {
		address=strtol(argv[2],NULL,0);
	}

	if (stat(argv[1],&file_info)<0) {
		fprintf(stderr,"Could not stat file %s\n\n",argv[1]);
		return -1;
	}
	bytes=(int)file_info.st_size;

	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Could not open file %s\n\n",argv[1]);
		return -1;
	}

	printf("%d FOR I=0 TO %d: READ X: POKE %d+I,X:NEXT I\n",
		line,bytes-1,address);
	line+=10;

	for(i=0;i<bytes;i++) {
		read(fd,&c,1);

		if (i%16==0) {
			printf("%d DATA ",line);
			line+=10;
		}
		printf("%d",c);
		if ((i%16!=15) && (i!=(bytes-1))) printf(",");
		else printf("\n");
	}
	close(fd);

	return 0;
}
