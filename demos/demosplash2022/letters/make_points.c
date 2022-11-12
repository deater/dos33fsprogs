#include <stdio.h>
#include <stdlib.h>

#define LINE_VALUE	254
#define STOP_VALUE	0
#define MODE_VALUE	3

static int debug=1;

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int a1,a2,a3,a4,a5;
	unsigned char output[1024];
	int out_ptr=0;
	int add=0;
	int xadjust=0;
	int yadjust=0;
	int xdiv=2;
	int ydiv=1;
	int i;
	int first_line=1;

	if (argc>1) {
		xadjust=atoi(argv[1]);
	}

	if (argc>2) {
		yadjust=atoi(argv[2]);
	}

	if (debug) {
		fprintf(stderr,"Using xdiv=%d add=%d xadjust=%d\n",
				xdiv,add,xadjust);
	}

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;
		if (buffer[0]=='#') continue;
		sscanf(buffer,"%d %d %d %d %d",
			&a1,&a2,&a3,&a4,&a5);
		if (debug) fprintf(stderr,"%d %d %d %d %d\n",a1,a2,a3,a4,a5);
		if (a1==LINE_VALUE) {
			if (first_line) {
				first_line=0;
			}
			else {
				output[out_ptr]=((a1)/xdiv)+add;
				out_ptr+=1;
			}
			output[out_ptr+0]=((a2-xadjust)/xdiv)+add;
			output[out_ptr+1]=((a3-yadjust)/ydiv)+add;
			output[out_ptr+2]=((a4-xadjust)/xdiv)+add;
			output[out_ptr+3]=((a5-yadjust)/ydiv)+add;
			out_ptr+=4;
		}
		else if (a1==MODE_VALUE) {
			output[out_ptr]=((a1-xadjust)/xdiv)+add;
			out_ptr+=1;
		}
		else if (a1==STOP_VALUE) {
			output[out_ptr]=((a1-xadjust)/xdiv)+add;
			out_ptr+=1;
			break;
		}
		else {
			output[out_ptr]=((a1-xadjust)/xdiv)+add;
			output[out_ptr+1]=((a2-yadjust)/ydiv)+add;
			out_ptr+=2;
		}
	}
	output[out_ptr-1]=0xff;

	for(i=0;i<out_ptr;i++) {
		if (i%8==0) printf(".byte\t");
		printf("$%02X",output[i]);
		if ((i%8!=7) && (i!=out_ptr-1)) {
			printf(",");
		}
		else {
			printf("\n");
		}
	}
	printf("\n");
	fprintf(stderr,"%d bytes\n",out_ptr);
	return 0;
}
