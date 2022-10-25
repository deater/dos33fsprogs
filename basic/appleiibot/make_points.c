#include <stdio.h>
#include <stdlib.h>

#if 1

#define LINE_VALUE	279
#define STOP_VALUE	0
#define MODE_VALUE	3

#else

#define LINE_VALUE	3
#define STOP_VALUE	6
#define MODE_VALUE	9

#endif


static int debug=1;

/* if div=3 */
/* 	can't plot at 0 or 279 */
/*	min is 3 = 1 to 276 = 92 */
/*	add = 33 so from 34 to 125 */

/* if div=2 */
/*	can't plot at 0 or 184 */
/*	min is 2 = 1 to 184 = 92 */
/*	centered on screen that's roughly 50 - 234 */

int main(int argc, char **argv) {

	char buffer[1024];
	char *ptr;
	int a1,a2,a3,a4,a5;
	char output[1024];
	int out_ptr=0;
	int add=33;
	int xadjust=0;
	int div=3;

	if (argc>1) {
		div=atoi(argv[1]);
	}

	if (div==2) {
		xadjust=-50;
	}

	if (debug) {
		fprintf(stderr,"Using div=%d add=%d xadjust=%d\n",
				div,add,xadjust);
	}

	while(1) {

		ptr=fgets(buffer,1024,stdin);
		if (ptr==NULL) break;
		if (buffer[0]=='#') continue;
		sscanf(buffer,"%d %d %d %d %d",
			&a1,&a2,&a3,&a4,&a5);
		if (debug) fprintf(stderr,"%d %d %d %d %d\n",a1,a2,a3,a4,a5);
		if (a1==LINE_VALUE) {
			output[out_ptr]=((a1-xadjust)/div)+add;
			output[out_ptr+1]=((a2-xadjust)/div)+add;
			output[out_ptr+2]=((a3-xadjust)/div)+add;
			output[out_ptr+3]=((a4-xadjust)/div)+add;
			output[out_ptr+4]=((a5-xadjust)/div)+add;
			out_ptr+=5;
		}
		else if (a1==MODE_VALUE) {
			output[out_ptr]=((a1-xadjust)/div)+add;
			out_ptr+=1;
		}
		else if (a1==STOP_VALUE) {
			output[out_ptr]=((a1-xadjust)/div)+add;
			out_ptr+=1;
			break;
		}
		else {
			output[out_ptr]=((a1-xadjust)/div)+add;
			output[out_ptr+1]=((a2-xadjust)/div)+add;
			out_ptr+=2;
		}
	}
	output[out_ptr]=0;
	printf("%s\n",output);

	return 0;
}
