#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

/* Need liblz4 installed */
#include "lz4.h"
#include "lz4hc.h"

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
static unsigned char compressed_buffer[MAX_SIZE];


static void dump_asm(char *name,int size,unsigned char *buffer) {

	int j;

	printf("%s:\n",name);

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

int main(int argc, char **argv) {

	int i,j,fd,size,total_size=0,compressed_size=0,total_compressed=0;

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
		total_size+=size;

		/* Convert to Apple II ASCII */
		for(j=0;j<size;j++) {
			if (buffer[j]=='\n') buffer[j]=13;
			buffer[j]=buffer[j]|0x80;
		}
		buffer[j]=0;

		compressed_size=LZ4_compress_HC ((char *)buffer,
                                                (char *)compressed_buffer,
                                                size,
                                                MAX_SIZE,
                                                16);

                if (compressed_size>MAX_SIZE) {
                        fprintf(stderr,"Error!  Compressed data too big!\n");
                }

		total_compressed+=compressed_size;

		fprintf(stderr,"%s %d %d\n",art_files[i],size,compressed_size);
		close(fd);

		dump_asm(art_names[i],compressed_size,compressed_buffer);


	}

	fprintf(stderr,"Total original: %d\n",total_size);
	fprintf(stderr,"Total compressed: %d\n",total_compressed);


	return 0;
}




