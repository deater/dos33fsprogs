#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"

int main(int argc, char **argv) {

	int ch,i;
	char output[BUFSIZ];
	unsigned char data[1024];
	FILE *fff;

	grsim_init();

	home();

	gr();

	text();


	if (argc<2) {

		basic_htab(10);

		basic_vtab(10);

		basic_print("HELLO WORLD!\r\r");


		for(i=0;i<128;i++) {
			sprintf(output,"%c",i);
			basic_print(output);
		}
	}
	else {
		fff=fopen(argv[1],"r");
		if (fff==NULL) {
			fprintf(stderr,"Error opening %s\n",argv[1]);
			exit(1);
		}
		fread(data,1024,1,fff);
		memcpy(ram+1024,data,1024);
	}

	while(1) {
		grsim_update();

		ch=grsim_input();

		if (ch=='q') break;

		usleep(100000);

	}

	return 0;
}
