#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "notes.h"

int main(int argc, char **argv) {

	unsigned char triad[3];
	char temp[5];
	int fd,result;

	fd=open("HIGHWIND.ED",O_RDONLY);
	if (fd<0) {
		fprintf(stderr,"Could not open HIGHWIND.ED\n");
		return -1;
	}

	while(1) {
		result=read(fd,triad,3);
		if (result<3) break;

		if (triad[0]==0) {
			printf("Instrument 1=%d, Instrument 2=%d\n",triad[1],triad[2]);
		}
		else {
			printf("Duration %d, ",triad[0]);
			printf("%s ",ed_to_note(triad[1],temp));
			printf("%s ",ed_to_note(triad[2],temp));
			printf("\n");
		}

	}

	close(fd);

	return 0;
}
