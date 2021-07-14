#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>


/* y addresses for 40..88, step 4 */

unsigned short addresses[12]={
	0x2280,	// 40
	0x3280,	// 44
	0x2300,	// 48
	0x3300,	// 52
	0x2380,	// 56
	0x3380,	// 60
	0x2028,	// 64
	0x3028,	// 68
	0x20A8,	// 72
	0x30A8,	// 76
	0x2128,	// 80
	0x3128,	// 84
};


int main(int argc, char **argv) {

	int fd,result,x,y;
	unsigned char hgr[8192];

	if (argc<2) {
		printf("Usage: %s file.hgr\n\n",argv[0]);
		exit(1);
	}

	fd=open(argv[1],O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"ERROR opening %s, %s\n",argv[1],
			strerror(errno));
		exit(1);
	}

	result=read(fd,hgr,8192);
	if (result!=8192) {
		fprintf(stderr,"Error reading!\n");
		exit(1);
	}

	printf("\n");

	for(y=0;y<12;y++) {
		printf(".byte ");
		for(x=0;x<9;x++) {
			printf("$%02X",hgr[addresses[y]-8192+x+23]);
			if (x!=8) printf(",");
		}
		printf("\n");
	}
	close(fd);

	return 0;
}
