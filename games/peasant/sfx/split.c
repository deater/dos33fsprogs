#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

#define SIZE 8192

unsigned char data[SIZE];

int main(int argc, char **argv) {

	int fd,result,i;
	char filename[256];

	fd=open("thump_mono.raw",O_RDONLY);
	if (fd<1) {
		printf("Error opening\n");
		exit(-1);
	}
	result=read(fd,data,SIZE);
	if (result<0) {
		printf("Error reading\n");
		exit(-1);
	}
	close(fd);

	int count=0,size;
	size=result;

	for(i=0;i*64<size;i++) {

		sprintf(filename,"out.%d.raw",i);
		fd=open(filename,O_WRONLY|O_CREAT,0666);
		if (fd<0) {
			fprintf(stderr,"Error opening %s!\n",filename);
			exit(-1);
		}

		result=write(fd,&data[count],64);
		close(fd);
		count+=64;
	}

	return 0;
}
