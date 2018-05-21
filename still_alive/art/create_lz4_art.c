#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

#define NUM_FILES	10

static char art_files[NUM_FILES][20]={
	"01_aperture.txt",
	"02_radioactive.txt",
	"03_atom.txt",
	"04_broken_heart.txt",
	"05_explosion.txt",
	"06_fire.txt",
	"07_check.txt",
	"08_black_mesa.txt",
	"09_cake.txt",
	"10_glados.txt",
};

#define MAX_SIZE	1024

static char buffer[MAX_SIZE];

int main(int argc, char **argv) {

	int i,fd,size;

	for(i=0;i<NUM_FILES;i++) {

		fd=open(art_files[i],O_RDONLY);
		if (fd<0) {
			fprintf(stderr,"Error opening %s\n",art_files[i]);
			return -1;
		}

		size=read(fd,buffer,MAX_SIZE);
		if (size<0) {
			fprintf(stderr,"Error reading %s\n",art_files[i]);
		}

		printf("%s %d\n",art_files[i],size);
		close(fd);
	}
	return 0;
}




