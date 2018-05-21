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

static char art_names[NUM_FILES][20]={
	"aperture",
	"radioactive",
	"atom",
	"broken_heart",
	"explosion",
	"fire",
	"check",
	"black_mesa",
	"cake",
	"glados",
};

#define MAX_SIZE	1024

static unsigned char buffer[MAX_SIZE];

int main(int argc, char **argv) {

	int i,j,fd,size,original_size=0,compressed_size=0;

	printf("ascii_art:\n");
	for(i=0;i<NUM_FILES;i++) {
		printf("\t.byte <%s,>%s\n",art_names[i],art_names[i]);
	}
	printf("\n");

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
		original_size+=size;

		/* Conver to Apple II ASCII */
		for(j=0;j<size;j++) {
			if (buffer[j]=='\n') buffer[j]=13;
			buffer[j]=buffer[j]|0x80;
		}
		buffer[j]=0;

		fprintf(stderr,"%s %d\n",art_files[i],size);
		close(fd);

		printf("%s:\n",art_names[i]);
		for(j=0;j<size+1;j++) {
			if (j%16==0) {
				printf("\n\t.byte $%02X",buffer[j]);
			}
			else {
				printf(",$%02X",buffer[j]);
			}
		}
		printf("\n");
	}

	fprintf(stderr,"Total original: %d\n",original_size);
	fprintf(stderr,"Total compressed: %d\n",compressed_size);


	return 0;
}




