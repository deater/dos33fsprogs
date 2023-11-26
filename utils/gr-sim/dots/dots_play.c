#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

#include "../gr-sim.h"
#include "../tfv_zp.h"

int create_gr_files=0;

int skip_factor=1;
int fps=10;

int main(int argc, char **argv) {


	int xx,yy,ch=0,i;
	int current_row=0;
	int frame=0;
	int fd;

	if (argc>1) {
		skip_factor=atoi(argv[1]);
	}
	printf("Only playing 1 of every %d frames\n",skip_factor);

	if (argc>2) {
		fps=atoi(argv[2]);
	}
	printf("Playing at %d frames per second\n",fps);


	grsim_init();

	gr();

	while(1) {
		clear_screens();
		soft_switch(MIXCLR);

		ram[DRAW_PAGE]=0;

        	color_equals(5);
        	for(yy=24;yy<48;yy++) hlin(0,0,40,yy);

		color_equals(0);

		/* skip frames */
		for(i=0;i<(skip_factor-1);i++) {
			while(1) {
				ch=getchar();
				if (ch==0xff) break;

				if (ch==0xfe) break;
			}
			if (ch==0xff) break;
		}

		if (ch==0xff) break;

		/* parse loop */
		while(1) {
			ch=getchar();
			if (ch==0xff) break;

			if (ch==0xfe) {
				color_equals(0);
				break;
			}
			if (ch==0xfd) {
				color_equals(6);
				continue;
			}

			if (ch&0x40) {
				current_row=ch&0x3f;
				ch=getchar();
			}
			xx=ch;
			plot(xx,current_row);
		}
		if (ch==0xff) break;

		usleep(1000000/fps);

		grsim_update();

		if (create_gr_files) {
			char filename[256];

			sprintf(filename,"frame%03d.gr",frame);
			fd=open(filename,O_WRONLY|O_CREAT,0660);
			if (fd<0) {
				fprintf(stderr,"Error opening!\n");
				return -1;
			}
			write(fd,&ram[0x400],1024);
			close(fd);
		}

		frame++;

//again:
		ch=grsim_input();
		if (ch==27) {
			break;
		}
//		else if (ch==0) goto again;

	}

	return 0;
}
